//
//  Router.swift
//  Profile
//
//  Created by L on 2022/2/21.
//

import UIKit

protocol Routing {
    func routeToRoot()
}

class Router {
    
    typealias Submodules = ()
    
    private weak var viewController: UIViewController?
    
    private var submodules: Submodules
    
    private var onLogout: () -> Void
    
    init(viewController: UIViewController?,
         submodules: Submodules,
         onLogout: @escaping () -> Void) {
        self.viewController = viewController
        self.submodules = submodules
        self.onLogout = onLogout
    }
    
}

extension Router: Routing { 
    
    func routeToRoot() {
        self.onLogout()
    }
 
}
