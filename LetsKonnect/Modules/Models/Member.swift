//
//  Member.swift
//  Models
//
//  Created by L on 2022/3/28.
//

import Foundation
import Utility

public struct Member: Codable {
    let role: Role
    let email, id: String
}

public extension Member {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Member.self
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
        role: Role? = nil,
        email: String? = nil,
        id: String? = nil
    ) -> Member {
        return Member(role: role ?? self.role,
                      email: email ?? self.email,
                      id: id ?? self.id)
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
