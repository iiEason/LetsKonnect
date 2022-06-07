//
//  ChatroomHttpRouter.swift
//  LetsKonnectService
//
//  Created by L on 2022/3/28.
//

import Alamofire

enum ChatroomHttpRouter {
    case chatrooms
}

extension ChatroomHttpRouter: ReactiveHttpRouter {
    
    private var accessToken: String {
        return UserSettingsService.shared.accessToken
    }
    
    var baseUrlString: String {
        return "http://localhost:8080/api"
    }
    
    var path: String {
        switch self {
        case .chatrooms:
            return "/chatrooms"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .chatrooms:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
        ]
    }

}
