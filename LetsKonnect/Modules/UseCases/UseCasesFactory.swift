//
//  UseCasesFactory.swift
//  UseCases
//
//  Created by L on 2022/2/18.
//
import LetsKonnectService

public final class UseCasesFactory {
    
    private static let deployedUrl = "https://damp-beach-81446.herokuapp.com/"
    
    private static let websocketService = ChatroomWebsocketService(socketUrl: deployedUrl)
    
    private static let userSettings = UserSettingsService.shared
    
    public static let accountInteractor: AccountInteractor = AccountInteractor.init(websocketService: websocketService, userSettings: userSettings)
    
    private static let chatroomService: ChatroomsService = ChatroomsService.shared
    
    public static let chatroomsInteractor: ChatroomsInteractor = ChatroomsInteractor.init(chatroomService: chatroomService)
    
//    private static let accountService = AccountService()
    
//    public static let accountInteractor: AccountInteractor = AccountInteractor(accountService: accountService)
    
}
