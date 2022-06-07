//
//  HttpService.swift
//  LetsKonnectService
//
//  Created by L on 2022/2/22.
//

import Alamofire
import RxSwift
import RxAlamofire

public protocol HttpService {
    
    var session: SessionManager { get }
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest  
    
}

public protocol ReactiveHttpService: HttpService, ReactiveCompatible {}

extension Reactive where Base: ReactiveHttpService {
    
    public func request(_ urlRequest: URLRequestConvertible) -> Observable<DataRequest> {
        
//        return Observable.create { [base] (observable) -> Disposable in
//
//            observable.onNext(base.session.request(urlRequest))
//
//            observable.onCompleted()
//
//            return Disposables.create()
//        }
        
        return base.session.rx.request(urlRequest: urlRequest)
        
    }
    
}
