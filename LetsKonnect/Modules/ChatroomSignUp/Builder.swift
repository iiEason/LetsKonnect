//
//  Builder.swift
//  Chatrooms
//
//  Created by L on 2022/2/21.
//

import UIKit
import Utility
import UseCases

public final class Builder {
    
    public static func build(onSognUp: @escaping () -> Void, onLogin: @escaping () -> Void) -> UIViewController {
        
        let storyboard = UIStoryboard.init(name: "ChatroomSignUp",
                                           bundle: Bundle(for: self))
        let view = SignUpViewController.instantiate(from: storyboard)
        
        view.title = "Chatrooms"
        
        let subModules: Router.Submodules = ()
        
        let accountInteractor = UseCasesFactory.accountInteractor
         
        let router = Router(viewController: view,
                            submodules: subModules,
                            onSignUp: onSognUp,
                            onLogin: onLogin)
        
        view.presenterProducer = {
            
            Presenter(input: $0,
                      dependencies: (
                        router: router,
                        useCases: (
                            input: (
                                signUp: accountInteractor.signUp,()
                            ),
                            output: ()
                        )
                      )
            )
        }
        
        return view
    }
    
}
