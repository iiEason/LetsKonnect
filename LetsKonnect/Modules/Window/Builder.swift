//
//  Builder.swift
//  Window
//
//  Created by L on 2022/2/10.
//

import UIKit
import Landing
import ChatroomLogin
import ChatroomSignUp
import Tabbar
import UseCases

public final class Builder {
    
    public static func build(windowScene: UIWindowScene) -> UIWindow {
        
        let window: Window = Window.init(windowScene: windowScene)
        
        let landingModule = Landing.Builder.build
        
        let loginModule = ChatroomLogin.Builder.build
        
        let signUpModule = ChatroomSignUp.Builder.build
        
        let tabbarModule = Tabbar.Builder.build
        
        let accountInteractor = UseCasesFactory.accountInteractor
        
        let router: Router = Router.init(
            window: window,
            submodules: (
            loadingModule: landingModule,
                loginModule: loginModule,
                signUpModule: signUpModule,
                tabbarModule: tabbarModule
        ))
        
        let presenter: Presenter = Presenter
            .init(router: router,
                  useCases: (
                    validate: accountInteractor.validate, ()
                  )
            )
        
        window.presenter = presenter
        
        return window
    }
    
}
