//
//  Presenter.swift
//  Chatrooms
//
//  Created by L on 2022/2/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol Presentation {
    
    typealias Input = (
        username: Driver<String>,
        password: Driver<String>,
        email: Driver<String>,
        signup: Driver<Void>,
        backToLogin: Driver<Void>
    )
    
    typealias Output = (
        enableSignUp: Driver<Bool>, ()
    )
    
    typealias Producer = (Presentation.Input) -> Presentation
    
    var input: Input { get }
    
    var output: Output { get }

}

class Presenter: Presentation {
    
    var input: Input
    
    var output: Output
    
    private let router: Routing
    
    private let useCases: UseCases
    
    private let dependencies: Dependencies
    
    private let bag = DisposeBag()
    
    typealias UseCases = (
        input:(
            signUp: (_ email: String,
                     _ username: String,
                     _ password: String) -> Single<()>, ()
        ),
        output:()
    )
    
    typealias Dependencies = (router: Routing,
                              useCases: UseCases)
    
    init(input: Input,
         dependencies: Dependencies) {
        
        self.input = input
        
        self.output = Presenter.output(input: self.input)
        
        self.router = dependencies.router
        
        self.useCases = dependencies.useCases
        
        self.dependencies = dependencies
        
        self.process()
        
    }
    
}

private extension Presenter {
    
    static func output(input: Input) -> Output {
        
        let enableSignUpDriver = Driver.combineLatest(
            input.username.map({ !$0.isEmpty }),
            input.password.map({ !$0.isEmpty }),
            input.email.map({ !$0.isEmpty && $0.isEmail() }))
            .map({ $0 && $1 && $2 })
        
        return (
            enableSignUp: enableSignUpDriver, ()
        )
    }
    
    func process() {
        
        self.input.signup
            .withLatestFrom(Driver.combineLatest(self.input.username, self.input.email,self.input.password))
            .debug("", trimOutput: false)
            .asObservable()
            .flatMapLatest({ [useCases] (username, email, password) in
                useCases.input.signUp(email, username, password).catchError { (error) -> Single<()> in
                    return .never()
                }
            })
            .map({ [router] in
                router.routeToWindow()
            })
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
            
        self.input.backToLogin
            .map ({ [router] (_) in
                router.routeToLogin()
            })
            .drive()
            .disposed(by: bag)
        
    }
}
