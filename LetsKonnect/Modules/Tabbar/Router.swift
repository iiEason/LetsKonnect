//
//  Router.swift
//  Tabbar
//
//  Created by L on 2022/2/21.
//

import UIKit

protocol Routing {
    
    
    
}

class Router {
    
    typealias SubModules = (
        chatroom: UIViewController,
        friends: UIViewController,
        profile: UIViewController
    )
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        
        self.viewController = viewController
        
    }
    
}

extension Router {
    
    static func tabs(usingSubmodules subModules: SubModules) -> LetsKonnectTabs {
        
        let chatImage = UIImage.init(named: "icon_tab_chat", in: Bundle(for: self), with: nil)
        let friendsImage = UIImage.init(named: "icon_tab_friends", in: Bundle(for: self), with: nil)
        let profileImage = UIImage.init(named: "icon_tab_profile", in: Bundle(for: self), with: nil)
        
        let chatroomTabbarItem = UITabBarItem(title: "Chat", image: chatImage, tag: 100)
        let friendsTabbarItem = UITabBarItem(title: "Friends", image: friendsImage, tag: 101)
        let profileTabbarItem = UITabBarItem(title: "Profile", image: profileImage, tag: 102)
        
        
        subModules.chatroom.tabBarItem = chatroomTabbarItem
        subModules.friends.tabBarItem = friendsTabbarItem
        subModules.profile.tabBarItem = profileTabbarItem
        
        return (
            chatroom: subModules.chatroom,
            friends: subModules.friends,
            profile: subModules.profile
        )
    }
    
}

extension Router: Routing {
    
    
}
