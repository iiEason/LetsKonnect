//
//  Router.swift
//  Chatrooms
//
//  Created by L on 2022/2/21.
//

import UIKit

protocol Routing {
    
}

class Router {
    
    typealias Submodules = ()
    
    private weak var viewController: UIViewController?
    
    private var submodules: Submodules
    
    init(viewController: UIViewController?,
         submodules: Submodules) {
        self.viewController = viewController
        self.submodules = submodules
    }
    
}

extension Router: Routing {
    
    
}
