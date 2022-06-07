//
//  Presenter.swift
//  ChatroomLogin
//
//  Created by L on 2022/2/11.
//

import RxSwift
import RxCocoa

protocol Presentation {

    typealias Input = (
        username: Driver<String>,
        email: Driver<String>,
        login: Driver<Void>,
        signUp: Driver<Void>
    )
    
    typealias Onput = (
        enableLogin: Driver<Bool>, ()
    )
    
    typealias Producer = (Presentation.Input) -> Presentation
    
    var input: Input { get }
    
    var onput: Onput { get }
    
}


class Presenter: Presentation {
    
    typealias UseCases = (
        login: (_ username: String,
                _ email: String) -> Single<()>, ()
    )
    
    var input: Input
    
    var onput: Onput
    
    private let useCases: UseCases
    
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(input: Input,
         router: Routing,
         useCases: UseCases) {
        self.input = input
        self.onput = Presenter.onput(input: input)
        self.useCases = useCases
        self.router = router
        self.process()
    }
    
}

private extension Presenter {
    
    static func onput(input: Input) -> Onput {
        
        let enableLoginDriver = Driver.combineLatest(
            input.username.map({ !$0.isEmpty }),
            input.email.map({ !$0.isEmpty && $0.isEmail() }))
            .map({ $0 && $1 })
        
        return (
            enableLogin: enableLoginDriver, ()
        )
    }
    
    
    func process() {
        
        self.input.login
            .withLatestFrom(Driver.combineLatest(self.input.username, self.input.email))
            .asObservable()
            .flatMap({ [useCases] (username, email) in
                useCases.login(username, email).catchError { (error) -> Single<()> in
                    return .never()
                }
            })
            .map({ [router] (_) in
                // route to tabbar
                router.routeToWindow()
            })
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
        
        self.input.signUp
            .map ({[router] (_) in
                router.routeToSignUp()
            })
            .drive()
            .disposed(by: bag)
    }
}
