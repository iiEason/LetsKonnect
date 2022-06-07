//
//  LetsKonnectController.swift
//  Tabbar
//
//  Created by L on 2022/2/21.
//

import UIKit

typealias LetsKonnectTabs = (
    chatroom: UIViewController,
    friends: UIViewController,
    profile: UIViewController
)

protocol TabbarView: class {
    
}

class LetsKonnectController: UITabBarController {
    
    var presenter: Presentation?
    
    init(tabs: LetsKonnectTabs) {
        super.init(nibName: "", bundle: nil)
        self.viewControllers = [tabs.chatroom,
                                tabs.friends,
                                tabs.profile]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

extension LetsKonnectController: TabbarView {
    
}
