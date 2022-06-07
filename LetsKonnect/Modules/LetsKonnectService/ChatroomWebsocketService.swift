//
//  ChatroomWebsocketService.swift
//  LetsKonnectService
//
//  Created by L on 2022/2/18.
//

import SocketIO
import RxSwift
import RxRelay
import Models

public protocol ChatroomWebsocketAPI {
    
    var socketResponse: Observable<ChatroomWebSocket.Response> { get }
    
    func login(username: String, email: String)
    
}

public protocol AccountWebsocketAPI {
    
    func setupConnection(usingSocketUrl url: URL, authToken: String) -> Single<Void>
    
}

public class ChatroomWebsocketService {
    
    private let socketUrl: String
    
    private var socketManager: SocketManager!
    
    private var socket: SocketIOClient!
    
    private let socketResponseRelay: PublishRelay<ChatroomWebSocket.Response> = PublishRelay()
    
    public lazy var socketResponse: Observable<ChatroomWebSocket.Response> = self.socketResponseRelay.asObservable()
    
    public init(socketUrl: String) {
        
        self.socketUrl = socketUrl
        
    }
    
    deinit {
        self.socket.disconnect()
    }
    
}


extension ChatroomWebsocketService: AccountWebsocketAPI {
    
    public func setupConnection(usingSocketUrl url: URL, authToken: String) -> Single<Void> {
        
        return Single.create { [weak self] (single) -> Disposable in
            
            guard let `self` = self else { return Disposables.create()  }
            
            let param: [String: Any] = ["token": authToken]
            self.socketManager = SocketManager(socketURL: url, config: [.log(true), .compress])
            self.socketManager.config = SocketIOClientConfiguration(arrayLiteral: .connectParams(param), .secure(false))
            
            self.socket = self.socketManager.defaultSocket
            
            self.socket.connect()
            
            self.setupSocketResponse(authToken: authToken)
            
            single(.success(()))
            
            return Disposables.create()
        }
        
    }
    
}

extension ChatroomWebsocketService: ChatroomWebsocketAPI {
    
    public func login(username: String,
                      email: String) {
        print("login request received for username: \(username) and email: \(email)")
        self.socket.emit(ChatSocket.Request.login, username, email)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.socketResponseRelay.accept(.loggedIn(userName: username, eMail: email))
        }
    }

}

private extension ChatroomWebsocketService {
    
    func setupSocketResponse(authToken: String) {
        
        let param: [String: Any] = ["token": authToken]
        self.socket.on(ChatSocket.Response.connect) { [weak self] (dataArray, socketAck) in
            // Socket 接受消息回调
            self?.socket.emit(ChatSocket.Request.authenticate, param)

        }
        
        self.socket.on(ChatSocket.Response.authenticated) { (dataArray, socketAck) in
            print("User is authenticated")
        }
        
        self.socket.on(ChatSocket.Response.unauthorized) { (dataArray, socketAck) in
            print("User is unauthorized")
        }
        
        
    }
    
}

struct ChatSocket {
    
    struct Request {
        
        static let authenticate = "authenticate"
        static let login = "login"
        
    }
    
    struct Response {
        
        static let connect = "connect"
        static let authenticated = "authenticate"
        static let unauthorized = "unauthorized"
        
    }
    
}
