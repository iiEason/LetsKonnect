//
//  AuthResponse.swift
//  Models
//
//  Created by L on 2022/3/9.
//

import Foundation
import Utility

public struct AuthResponse: Codable {
    public let message: String
    public let user: User
}

public extension AuthResponse {
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AuthResponse.self
                                           , from: data)
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
    
    func with(
        message: String? = nil,
        user: User? = nil
    ) -> AuthResponse {
        return AuthResponse(message: message ?? self.message,
                            user: user ?? self.user)
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
}



public struct TokenData: Codable {
    
    public let email, accessToken, refreshToken: String
    public let expiresIn: Int
    
    public init(email: String,
                accessToken: String,
                refreshToken: String,
                expiresIn: Int) {
        self.email = email
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
        self.accessToken = accessToken
    }
}

public extension TokenData {
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TokenData.self
                                           , from: data)
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
    
    func with(
        email: String? = nil,
        accessToken: String? = nil,
        refreshToken: String? = nil,
        expiresIn: Int? = nil
    ) -> TokenData {
        return TokenData(email: email ?? self.email,
                         accessToken: accessToken ?? self.accessToken,
                         refreshToken: refreshToken ?? self.refreshToken,
                         expiresIn: expiresIn ?? self.expiresIn)
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
}
