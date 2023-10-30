//
//  ProfileRequestListModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation


struct ProfileRequestListModel: Decodable {
    var conns: [Conn342]
}

// MARK: - Conn
struct Conn342: Codable {
    let id, fullName: String
    let profilePic: String
    let verificationStatus, role: String
    let normalUserInfo: [NormalUserInfo342e]
    let userID: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case fullName = "Full_name"
        case profilePic = "Profile_pic"
        case verificationStatus
        case role = "Role"
        case normalUserInfo
        case userID = "User_id"
    }
}

// MARK: - NormalUserInfo
struct NormalUserInfo342e: Codable {
    let jobTitle: String
}
