//
//  Window.swift
//  Window
//
//  Created by L on 2022/2/10.
//

import UIKit

class Window: UIWindow {
    
    var presenter: Presentation?
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
