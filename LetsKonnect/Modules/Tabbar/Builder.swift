//
//  Builder.swift
//  Tabbar
//
//  Created by L on 2022/2/21.
//

import UIKit
import Chatrooms
import Friends
import Profile
import Utility

public final class Builder {
    
    public static func build(onLogout: @escaping () -> Void) -> UITabBarController {
        
        let subModules: Router.SubModules = (
            chatroom: Chatrooms.Builder.build(usingNavigationFactory: UINavigationController.build),
            friends: Friends.Builder.build(usingNavigationFactory: UINavigationController.build),
            profile: Profile.Builder.build(usingNavigationFactory: UINavigationController.build, onLogout: onLogout )
        )
        
        let tabs: LetsKonnectTabs = Router.tabs(usingSubmodules: subModules)
        
        let presenter = Presenter(useCases: ())
        
        let view = LetsKonnectController(tabs: tabs)
        
        presenter.view = view
        
        view.presenter = presenter
        
        return view
    }
    
}
