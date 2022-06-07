//
//  Presenter.swift
//  Window
//
//  Created by L on 2022/2/10.
//

import Foundation
import RxCocoa
import RxSwift

protocol Presentation {
    
}

class Presenter: Presentation {
    
    typealias UseCases = (
        validate: () -> Single<Bool>, ()
    )
    
    private let useCases: UseCases
    
    private let router: Routing
    
    private let routeTpRelay: PublishRelay<RouteTo> = PublishRelay()
    
    private lazy var routeToDriver: Driver<RouteTo> = self.routeTpRelay.asDriver(onErrorDriveWith: .never())
    
    private let bag = DisposeBag()
    
    init(router: Routing,
         useCases: UseCases) {
        
        self.router = router
        self.useCases = useCases
        self.process()
        
    }
}

private extension Presenter {
    
    func process() {
        
        //        self.router.routeToLanding()
        //            .flatMap({ [router] (_) in
        //                router.routeToLogin()
        //            })
        //            .map { [routeTpRelay] (routeTo) in
        //                routeTpRelay.accept(routeTo)
        //            }
        
        let validate = self.useCases.validate()
            .asDriver(onErrorJustReturn: false)
        
        validate
            .filter({ !$0 })
            .map({ _ in () })
            .asObservable()
            .flatMap(self.router.routeToLanding)
            .flatMap(self.router.routeToLogin)
            .map(self.routeTpRelay.accept)
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: self.bag)
        
        validate
            .filter({ $0 })
            .map({ _ in () })
            .asObservable()
            .flatMap(self.router.routeToChatrooms)
            .map(self.routeTpRelay.accept)
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: self.bag)
        
        self.routeToDriver
            .debug("routeToDriver", trimOutput: false)
            .filter({
                guard case RouteTo.signup = $0 else { return false }
                return true
            })
            .map({ _ in () })
            .asObservable()
            .flatMap(self.router.routeToSignUp)
            .map(self.routeTpRelay.accept)
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: self.bag)
        
        self.routeToDriver
            .debug("routeToDriver", trimOutput: false)
            .filter({
                guard case RouteTo.chatrooms = $0 else { return false }
                return true
            })
            .map({ _ in () })
            .asObservable()
            .flatMap(self.router.routeToChatrooms)
            .map(self.routeTpRelay.accept)
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: self.bag)
        
        self.routeToDriver
            .debug("routeToDriver", trimOutput: false)
            .filter({
                guard case RouteTo.login = $0 else { return false }
                return true
            })
            .map({ _ in () })
            .asObservable()
            .flatMap(self.router.routeToLogin)
            .map(self.routeTpRelay.accept)
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: self.bag)
        
    }
    
}
