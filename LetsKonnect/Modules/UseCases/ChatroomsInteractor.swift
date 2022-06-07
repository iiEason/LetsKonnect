//
//  ChatroomsInteractor.swift
//  UseCases
//
//  Created by L on 2022/3/28.
//

import RxSwift
import RxCocoa
import Models
import LetsKonnectService

public final class ChatroomsInteractor {
    
    private let chatroomsRelay: BehaviorRelay<Set<Chatroom>> = BehaviorRelay(value: [])
    
    public lazy var chatrooms: Observable<Set<Chatroom>> = self.chatroomsRelay.asObservable()
    
    private let chatroomService: ChatroomsAPI
    
    init(chatroomService: ChatroomsAPI) {
        self.chatroomService = chatroomService
    }
    
}

public extension ChatroomsInteractor {
    
    func fetchChatrooms() -> Completable {
        self.chatroomService.chatrooms()
            .map { [chatroomsRelay] (chatrooms) in
                chatroomsRelay.accept(Set(chatroomsRelay.value + chatrooms))
            }
            .asCompletable()
    }
    
}
