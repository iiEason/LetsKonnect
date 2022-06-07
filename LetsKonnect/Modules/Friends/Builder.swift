//
//  Builder.swift
//  Friends
//
//  Created by L on 2022/2/21.
//

import UIKit
import Utility

public final class Builder {
    
    public static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        
        let storyboard = UIStoryboard.init(name: "Friends",
                                           bundle: Bundle(for: self))
        let view = FriendsViewController.instantiate(from: storyboard)
        
        view.title = "Friends"
        
        let subModules: Router.Submodules = ()
        
        let router = Router(viewController: view,
                            submodules: subModules)
        
        view.presenterProducer = { input in
            
            Presenter(input: input,
                      dependencies: (
                        router: router,
                        useCases: (
                            input: (),
                            output: ()
                        )
                      )
            )
        }
        
        return factory(view)
    }
    
}

