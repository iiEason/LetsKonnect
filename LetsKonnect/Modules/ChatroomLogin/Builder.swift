//
//  Builder.swift
//  ChatroomLogin
//
//  Created by L on 2022/2/11.
//

import UIKit
import Utility
import UseCases

public final class Builder {
    
    public static func build(onLogin: @escaping () -> Void,
                             onSignUp: @escaping () -> Void) -> UIViewController {
        
        let storyboard = UIStoryboard.init(name: "ChatroomLogin",
                                           bundle: Bundle.init(for: self))
        let view = ChatroomLoginViewController.instantiate(from: storyboard)
        
        let accountInteractor = UseCasesFactory.accountInteractor
        
        let router = Router(viewController: view,
                            onLogin: onLogin,
                            onSignUp: onSignUp)
        
        view.presenterProducer = {
            Presenter.init(input: $0,
                           router: router,
                           useCases: (
                            login: accountInteractor.login, ()
                           )
            )
        }
        
        return view
        
    }
    
}
