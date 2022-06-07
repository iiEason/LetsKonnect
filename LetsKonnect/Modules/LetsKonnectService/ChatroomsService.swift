//
//  ChatroomsService.swift
//  LetsKonnectService
//
//  Created by L on 2022/3/28.
//

import RxSwift
import Models

public protocol ChatroomsAPI {
    
    func chatrooms() -> Single<[Chatroom]>
    
}

public final class ChatroomsService {
    
    private let httpService: ChatroomHttpService = ChatroomHttpService.shared
    
    public static let shared: ChatroomsService = ChatroomsService()
    
    private init() {}
    
}

extension ChatroomsService : ChatroomsAPI {
    
    public func chatrooms() -> Single<[Chatroom]> {
        
        ChatroomHttpRouter.chatrooms.rx
            .request(withService: self.httpService)
            .responseJSON()
            .map { (dataResponse) in
                
                if let error = dataResponse.error {
                    throw ChatroomError.custom(error.localizedDescription)
                }
                
                guard let statusCode = dataResponse.response?.statusCode,
                      statusCode == 200,
                      let data = dataResponse.data else {
                    throw ChatroomError.notFound(message: "没有找到")
                }
                return try Chatrooms.init(data: data)
            }
            .asSingle()
        
    }
    
    
}
