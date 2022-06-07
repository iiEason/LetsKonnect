//
//  Role.swift
//  Models
//
//  Created by L on 2022/3/28.
//


import Foundation

public enum Role: String, Codable {
    case participant = "PARTICIPANT"
    case owner = "OWNER"
    case guest = "GUEST"
}
