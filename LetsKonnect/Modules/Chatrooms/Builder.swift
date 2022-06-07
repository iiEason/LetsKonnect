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
    
    public static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        
        let storyboard = UIStoryboard.init(name: "Chatrooms",
                                           bundle: Bundle(for: self))
        let view = ChatroomsViewController.instantiate(from: storyboard)
        
        view.title = "Chatrooms"
        
        let chatroomsInteractor = UseCasesFactory.chatroomsInteractor
        
        let subModules: Router.Submodules = ()
        
        let router = Router(viewController: view,
                            submodules: subModules)
        
        view.presenterProducer = {
            
            Presenter(input: $0,
                      dependencies: (
                        router: router,
                        useCases: (
                            input: (
                                fetchChatrooms: chatroomsInteractor.fetchChatrooms, ()
                            ),
                            output: (
                                chatrooms: chatroomsInteractor.chatrooms, ()
                            )
                        )
                      )
            )
        }
        
        return factory(view)
    }
    
}
