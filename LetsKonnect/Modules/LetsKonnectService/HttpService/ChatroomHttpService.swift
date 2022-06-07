//
//  ChatroomService.swift
//  LetsKonnectService
//
//  Created by L on 2022/2/22.
//

import Alamofire

public final class ChatroomHttpService: ReactiveHttpService {
    
    public static let shared: ChatroomHttpService = ChatroomHttpService()
    
    public var session: SessionManager
    
    private init() {
        self.session = SessionManager.default
    }
    
    public func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        self.session.request(urlRequest)
    }
    
    
    
    
}

