//
//  User.swift
//  Models
//
//  Created by L on 2022/2/18.
//

import Foundation
import Utility

public struct User: Codable {
    
    public let username, password: String?
    
    public let email: String

    public var tokenData: TokenData?
    
}

public extension User {
    
//    init(email: String, password: String) {
//        self.email = email
//        self.password = password
//    }
    
    init(email: String, username: String, password: String) {
        self.email = email
        self.username = username
        self.password = password
    }
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(User.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
//    func with(
//        username: String? = nil,
//        email: String? = nil,
//        password: String? = nil,
//        tokenData: TokenData? = nil
//    ) -> User {
//        return User(
//            username: username ?? self.username,
//            password: password ?? self.password,
//            email: email ?? self.email,
//            tokenData: tokenData ?? self.tokenData
//        )
//    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


