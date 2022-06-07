//
//  Builder.swift
//  Profile
//
//  Created by L on 2022/2/21.
//

import UIKit
import Utility
import UseCases

public final class Builder {
    
    public static func build(usingNavigationFactory factory: NavigationFactory,onLogout: @escaping () -> Void) -> UIViewController {
        
        let storyboard = UIStoryboard.init(name: "Profile",
                                           bundle: Bundle(for: self))
        let view = ProfileViewController.instantiate(from: storyboard)
        
        view.title = "Profile"
        
        let subModules: Router.Submodules = ()
        
        let accountInteractor = UseCasesFactory.accountInteractor
        
        let router = Router(viewController: view,
                            submodules: subModules,
                            onLogout: onLogout)
        
        view.presenterProducer = { input in
            
            Presenter(input: input,
                      dependencies: (
                        router: router,
                        useCases: (
                            input: (
                                logout:accountInteractor.logout, ()
                            ),
                            output: (
                                profileUser: accountInteractor.user
                                    .filter({ $0 != nil })
                                    .map({$0!}), ()
                            )
                        )
                      )
            )
        }
        
        return factory(view)
    }
    
}

