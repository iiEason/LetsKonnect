//
//  ChatroomError.swift
//  Models
//
//  Created by L on 2022/2/22.
//

public enum ChatroomError: Error {
    
    case notFound(message: String)
    case mandatoryMissing
    case internalError
    case unauthorized(message: String)
    case parsingFaild
    case custom(String)
    
}

private extension ChatroomError {
    
    var errorDescription: String? {
        switch self {
        case .notFound(let message):
            return "\(message) not found"
        case .mandatoryMissing:
            return "mandatory Missing"
        case .internalError:
            return "something went wrong"
        case .unauthorized(let message):
            return "\(message) no authorized"
        case .parsingFaild:
            return "something went wrong while parsing"
        case .custom(let string):
            return string
        }
    }
    
}
