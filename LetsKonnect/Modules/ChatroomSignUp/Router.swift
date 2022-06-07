//
//  Router.swift
//  Chatrooms
//
//  Created by L on 2022/2/21.
//

import UIKit

protocol Routing {
    
    func routeToWindow()
    
    func routeToLogin()
    
}

class Router {
    
    typealias Submodules = ()
    
    private weak var viewController: UIViewController?
    
    private var submodules: Submodules
    
    private let onSignUp: () -> Void
    
    private let onLogin: () -> Void
    
    init(viewController: UIViewController?,
         submodules: Submodules,
         onSignUp: @escaping () -> Void,
         onLogin: @escaping () -> Void) {
        self.viewController = viewController
        self.submodules = submodules
        self.onSignUp = onSignUp
        self.onLogin = onLogin
    }
    
}

extension Router: Routing {
    
    func routeToWindow() {
        self.onSignUp()
    }
    
    func routeToLogin() {
        self.onLogin()
    }

}
