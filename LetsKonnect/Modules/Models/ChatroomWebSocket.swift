//
//  WebSocketResponse.swift
//  Models
//
//  Created by L on 2022/2/21.
//

public enum ChatroomWebSocket {
    public enum Response {
        case loggedIn(userName: String, eMail: String)
    }
}

