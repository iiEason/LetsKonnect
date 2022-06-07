//
//  Router.swift
//  ChatroomLogin
//
//  Created by L on 2022/2/11.
//

import UIKit

protocol Routing {
    
    func routeToWindow()
    
    func routeToSignUp()
    
}

class Router {
    
    private weak var viewController: UIViewController?
    
    private let onLogin: () -> Void
    
    private let onSignUp: () -> Void
    
    init(viewController: UIViewController,
         onLogin: @escaping () -> Void,
         onSignUp: @escaping () -> Void) {
        self.viewController = viewController
        self.onLogin = onLogin
        self.onSignUp = onSignUp
    }
    
}

extension Router: Routing {
    
    func routeToWindow() {
        self.onLogin()
    }
      
    func routeToSignUp() {
        self.onSignUp()
    }
}
