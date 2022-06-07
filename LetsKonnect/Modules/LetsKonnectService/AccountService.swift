//
//  AccountService.swift
//  LetsKonnectService
//
//  Created by L on 2022/2/22.
//

import Foundation
import Models
import RxSwift


public protocol AccountAPI {

    func login(username: String, email: String) -> Single<User>
    
    func signUp(user: User) -> Single<User>
}

public final class AccountService {
    
    private let httpService: ChatroomHttpService = ChatroomHttpService.shared
    
    public init() {}
    
}

extension AccountService: AccountAPI {
    
    public func login(username: String,
                      email: String) -> Single<User> {
        
        AccountHttpRouter
            .logIn(user: User.init(email: email,
                                   username: username,
                                   password: ""))
            .rx.request(withService: httpService)
            .responseJSON()
            .map { (result) -> AuthResponse in
                guard let data = result.data else {
                    throw ChatroomError.notFound(message: "")
                }
                if result.response?.statusCode == 200 {
                    return try AuthResponse(data: data)
                } else {
                    throw ChatroomError.internalError
                }
            }
            .map({ $0.user })
            .asSingle()
        
    }

    
    public func signUp(user: User) -> Single<User> {
        AccountHttpRouter
            .logIn(user: user)
            .rx.request(withService: httpService)
            .responseJSON()
            .map { (result) -> AuthResponse in
                guard let data = result.data else {
                    throw ChatroomError.notFound(message: "")
                }
                if result.response?.statusCode == 200 {
                    return try AuthResponse(data: data)
                } else {
                    throw ChatroomError.internalError
                }
            }
            .map({ $0.user })
            .asSingle()
    }


}

