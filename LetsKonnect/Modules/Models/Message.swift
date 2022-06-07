//
//  Message.swift
//  Models
//
//  Created by L on 2022/3/28.
//

import Foundation
import Utility

public struct Message: Codable {
    
    public let sender, kind, status: String
    public let content: String?
    public let createdAt, updatedAt, id: String
    public let url: String?
    public let extn: String?
    
    enum CodingKeys: String, CodingKey {
        case sender, kind, status, content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id, url, extn
    }
}

public extension Message {
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Message.self
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
        sender: String? = nil,
        kind: String? = nil,
        status: String? = nil,
        content: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        id: String? = nil,
        url: String? = nil,
        extn: String? = nil
    ) -> Message {
        return Message(sender: sender ?? self.sender,
                       kind: kind ?? self.kind,
                       status: status ?? self.status,
                       content: content ?? self.content,
                       createdAt: createdAt ?? self.createdAt,
                       updatedAt: updatedAt ?? self.updatedAt,
                       id: id ?? self.id,
                       url: url ?? self.url,
                       extn: extn ?? self.extn)
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
}
