//
//  ExplorePeopleSearchModel.swift
//  R-own
//
//  Created by Aman Sharma on 11/07/23.
//

import Foundation

struct ExplorePeopleSearchModel: Decodable{
    let page, pageSize: Int
    var posts: [Post344]
}

// MARK: - Post
struct Post344: Codable {
    let id, fullName: String
    let profilePic: String
    let mesiboAccount: [MesiboAccount344]
    let verificationStatus, userBio, userName, role: String
    var displayStatus, userID, connectionStatus: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case fullName = "Full_name"
        case profilePic = "Profile_pic"
        case mesiboAccount = "Mesibo_account"
        case verificationStatus, userBio
        case userName = "User_name"
        case role = "Role"
        case displayStatus = "display_status"
        case userID = "User_id"
        case connectionStatus
    }
}

// MARK: - MesiboAccount
struct MesiboAccount344: Codable {
    let uid: Int
    let address, token, id: String

    enum CodingKeys: String, CodingKey {
        case uid, address, token
        case id = "_id"
    }
}
