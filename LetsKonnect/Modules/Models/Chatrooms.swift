//
//  Chatrooms.swift
//  Models
//
//  Created by L on 2022/3/28.
//

import Foundation
import Utility

public typealias Chatrooms = [Chatroom]

extension Array where Element == Chatrooms.Element {
    
    public init(data: Data) throws {
        self = try newJSONDecoder().decode(Chatrooms.self
                                           , from: data)
    }
    
    public init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    public init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    public func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    public func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
}
