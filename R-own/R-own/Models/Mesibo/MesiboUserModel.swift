//
//  MesiboUserModel.swift
//  R-own
//
//  Created by Aman Sharma on 11/04/23.
//

import Foundation
import SwiftUI

struct MesiboUserCodable: Codable {
    let userscount, count: Int
    let users: [User]
    let op: String
    let result: Bool
}

// MARK: - User
struct User: Codable {
    let uid: Int
    let address: String
    let ipaddr, lastonline, active, pinned: Int
    let online, flag, flags: Int
    let token: String?
    let appid: Appid?
}

enum Appid: String, Codable {
    case appRetvensRown = "app.retvens.rown"
}
