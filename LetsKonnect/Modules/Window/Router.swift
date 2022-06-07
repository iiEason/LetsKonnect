//
//  Router.swift
//  Window
//
//  Created by L on 2022/2/10.
//

import UIKit
import RxSwift

enum RouteTo {
    case login
    case signup
    case chatrooms
}

protocol Routing {
    
    func routeToLanding() -> Single<Void>
    
    func routeToLogin() -> Single<RouteTo>
    
    func routeToSignUp() -> Single<RouteTo>
    
    func routeToChatrooms() -> Single<RouteTo>
}

class Router {
    
    private unowned let window: UIWindow
    
    private let submodules: Submodules
    
    typealias Submodules = (
        loadingModule: (_ onStart: @escaping () -> Void) -> UIViewController,
        loginModule: (_ onLogin: @escaping () -> Void,
                      _ onSignUp: @escaping () -> Void) -> UIViewController,
        signUpModule: (_ onSignUp: @escaping () -> Void,
                       _ onLogin: @escaping () -> Void) -> UIViewController,
        tabbarModule: (_ onLogout: @escaping () -> Void) -> UIViewController
    )
    
    init(window: UIWindow,
         submodules: Submodules) {
        self.window = window
        self.submodules = submodules
    }
    
}

extension Router: Routing {
    
    func routeToLanding() -> Single<Void> {
        return Single.create { (single) -> Disposable in
            let landingView = self.submodules.loadingModule {
                single(.success(()))
            }
            self.window.rootViewController = landingView
            self.window.makeKeyAndVisible()
            return Disposables.create()
        }
    }
    
    func routeToLogin() -> Single<RouteTo> {
         
        return Single.create { (single) -> Disposable in
            let loginView = self.submodules.loginModule ({
                single(.success(.chatrooms))
            }){
                single(.success(.signup))
            }
            self.window.rootViewController = loginView
            self.window.makeKeyAndVisible()
            return Disposables.create()
        }
        
    }
    
    func routeToSignUp() -> Single<RouteTo> {
        
        return Single.create { (single) -> Disposable in
            let signUpView = self.submodules.signUpModule ({
                single(.success(.chatrooms))
            }) {
                single(.success(.login))
            }
            self.window.rootViewController = signUpView
            self.window.makeKeyAndVisible()
            return Disposables.create()
        }
        
    }
    
    func routeToChatrooms() -> Single<RouteTo> {
        
        return Single.create { (single) -> Disposable in
            let tabbarView = self.submodules.tabbarModule{
                single(.success(.login))
            }
            self.window.rootViewController = tabbarView
            self.window.makeKeyAndVisible()
            
            return Disposables.create()
        }
    }
    
}


