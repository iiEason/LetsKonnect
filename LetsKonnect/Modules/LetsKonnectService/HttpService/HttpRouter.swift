//
//  HttpRouter.swift
//  LetsKonnectService
//
//  Created by L on 2022/2/22.
//

import Alamofire
import RxAlamofire
import RxSwift

public protocol HttpRouter {
    
    var baseUrlString: String { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var headers: HTTPHeaders? { get }
    
    var parameters: Parameters? { get }
    
    func body() throws -> Data?
    
    func request(usingHttpService httpService: HttpService) throws -> DataRequest
    
}

extension HttpRouter {
    
    public var parameters: Parameters? { return nil }
    
    public func body() throws -> Data? { return nil }
    
    func asURLRequest() throws -> URLRequest {
        
        var url = try baseUrlString.asURL()
        
        url.appendPathComponent(path)
        
        var request = try URLRequest(url: url,
                                     method: method,
                                     headers: headers)
        
        request.httpBody = try body()
        
        return request
        
    }
    public   
    func request(usingHttpService httpService: HttpService) throws -> DataRequest {
        
        return try httpService.request(asURLRequest())
        
    }
    
}

public protocol ReactiveHttpRouter: HttpRouter, ReactiveCompatible {}

public extension Reactive where Base: ReactiveHttpRouter {
    
    func request<Service: ReactiveHttpService>(withService service: Service) -> Observable<DataRequest> {
        do { return try service.rx.request(base.asURLRequest()) }
        catch { return .error(error) }
    }
    
}


