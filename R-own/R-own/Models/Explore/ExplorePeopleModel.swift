//
//  ExplorePeopleModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct ExplorePeopleModel: Decodable{
    let page, pageSize: Int
    var posts: [Post34]
}

// MARK: - Post
struct Post34: Codable {
    let id, fullName: String
    let profilePic: String
    let mesiboAccount: [MesiboAccount34]
    let verificationStatus, userBio, createdOn, userName: String
    let role, displayStatus, userID: String
    var connectionStatus: String
    let blocked, blockbyuser: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case fullName = "Full_name"
        case profilePic = "Profile_pic"
        case mesiboAccount = "Mesibo_account"
        case verificationStatus, userBio
        case createdOn = "Created_On"
        case userName = "User_name"
        case role = "Role"
        case displayStatus = "display_status"
        case userID = "User_id"
        case connectionStatus
        case blocked = "Blocked"
        case blockbyuser
    }
}

// MARK: - MesiboAccount
struct MesiboAccount34: Codable {
    let uid: Int?
    let address: String
    let token: String?
    let id: String

    enum CodingKeys: String, CodingKey {
        case uid, address, token
        case id = "_id"
    }
}
