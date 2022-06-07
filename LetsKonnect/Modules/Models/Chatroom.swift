//
//  Chatroom.swift
//  Models
//
//  Created by L on 2022/3/28.
//

import Foundation
import Utility

public struct Chatroom: Codable {
    
    public let status: Bool
    public let members: [Member]
    public let messages: [Message]
    public let creator, name, subject, createdAt: String
    public let updatedAt, id: String
    
    enum CodingKeys: String, CodingKey {
        case status, members, messages, creator, name, subject
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id
    }
    
}

public extension Chatroom {
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Chatroom.self
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
        status: Bool? = nil,
        members: [Member]? = nil,
        messages: [Message]? = nil,
        creator: String? = nil,
        name: String? = nil,
        subject: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        id: String? = nil
    ) -> Chatroom {
        return Chatroom(status: status ?? self.status,
                        members: members ?? self.members,
                        messages: messages ?? self.messages,
                        creator: creator ?? self.creator,
                        name: name ?? self.name,
                        subject: subject ?? self.subject,
                        createdAt: createdAt ?? self.createdAt,
                        updatedAt: updatedAt ?? self.updatedAt,
                        id: id ?? self.id)
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
}

extension Chatroom: Equatable {
    
    public static func == (lhs: Chatroom,
                           rhs: Chatroom) -> Bool {
        lhs.id == rhs.id
    }
  
}

extension Chatroom: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
