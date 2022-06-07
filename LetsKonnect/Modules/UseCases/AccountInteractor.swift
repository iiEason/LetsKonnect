//
//  AccountInteractor.swift
//  UseCases
//
//  Created by L on 2022/2/18.
//

import RxSwift
import RxRelay
import LetsKonnectService
import Models

public final class AccountInteractor {
    
    private let websocketService: ChatroomWebsocketAPI
    
    private let userSettings: UserSettingsAPI
    
//    private let accountService: AccountAPI
    
    private let userRealy: BehaviorRelay<User?> = BehaviorRelay(value: nil)
    
    public lazy var user: Observable<User?> = self.userRealy.asObservable()
    
    init(websocketService: ChatroomWebsocketAPI,
         userSettings: UserSettingsAPI) {
        self.websocketService = websocketService
        self.userSettings = userSettings
    }
    
//    init(accountService: AccountAPI) {
//        self.accountService = accountService
//    }
}

public extension AccountInteractor {
    
    func login(username: String,
               email: String) -> Single<()> {
//        self.websocketService.login(username: username,
//                                    email: email)
        return self.websocketService.socketResponse
            .filter({
                guard case .loggedIn = $0 else { return false }
                return true
            })
            .map({ (result) -> User? in
                guard case .loggedIn(let username,
                                     let email) = result else { return nil }
                var user = User.init(email: email,
                                     username: username,
                                     password: "")
                user.tokenData = TokenData.init(email: email,
                                                accessToken: "accessToken_0",
                                                refreshToken: "refreshToken_0",
                                                expiresIn: 119)
                return user
            })
            .take(1)
            .flatMap(saveUser(user:))
            .asSingle()
            .do(onSubscribed: { [weak self] in
                self?.websocketService.login(username: username,
                                            email: email)
            })
//        self.accountService
//            .login(username: username, email: email)
//            .flatMap(saveUser(user:))
    }
    
    func signUp(email: String,
                username: String,
                password: String) -> Single<()> {
//        self.accountService
//            .signUp(user: User.init(email: email,
//                                    username: username,
//                                    password: password))
//            .flatMap(saveUser(user:))
        return self.saveUser(user: User.init(email: email,
                                             username: username,
                                             password: password))
    }
    
    func logout() -> Single<()> {
        return Single.create{ (single) -> Disposable in
            self.userSettings.clearTokens()
            single(.success(()))
            return Disposables.create()
        }
    }
    
    func validate() -> Single<Bool> {
        return Single.create { (single) -> Disposable in
            single(.success(!self.userSettings.accessToken.isEmpty))
            return Disposables.create()
        }
    }
    
}

private extension AccountInteractor {
    
    func saveUser(user: User?) -> Single<()> {
        self.userRealy.accept(user)
        if let tokenData = user?.tokenData {
            self.userSettings.saveTokens(tokenData: tokenData)
        }
        return .just(())
    }
    
}
