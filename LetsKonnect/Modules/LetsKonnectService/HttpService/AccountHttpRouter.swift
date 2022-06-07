//
//  AccountHttpRouter.swift
//  LetsKonnectService
//
//  Created by L on 2022/2/22.
//

import Alamofire
import Models

public enum AccountHttpRouter {
    case logIn(user: User)
    case signUp(user: User)
}

extension AccountHttpRouter: ReactiveHttpRouter {
    
    public var baseUrlString: String {
        return "http:localhost:8080/api"
    }
    
    public var path: String {
        switch self {
        case .logIn:
            return "/login"
        case .signUp:
            return "/signup"
        }
    }
    
    public var method: HTTPMethod {
        return .post
    }
    
    public var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    public func body() throws -> Data? {
        
        switch self {
        case .logIn(let user):
            return try user.jsonData()
        case .signUp(let user):
            return try user.jsonData()
        }
        
    }
    
}
