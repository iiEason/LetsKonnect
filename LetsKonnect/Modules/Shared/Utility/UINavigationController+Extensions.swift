//
//  UINavigationController+Extensions.swift
//  Utility
//
//  Created by L on 2022/2/21.
//

import UIKit

public typealias NavigationFactory = (UIViewController) -> UINavigationController

extension UINavigationController {
    
    public static func build(rootView: UIViewController) -> UINavigationController {
        
        let vc = UINavigationController(rootViewController: rootView)
        
        vc.navigationBar.prefersLargeTitles = true
        
        return vc
        
    }
  
}
