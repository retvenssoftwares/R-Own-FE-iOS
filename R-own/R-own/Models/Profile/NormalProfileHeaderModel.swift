//
//  ProfileHeaderModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct NormalProfileHeaderModel: Codable{
    var data: DataClass543
}

// MARK: - DataClass
struct DataClass543: Codable {
    var profile: Profile543
    let postCountLength, connCountLength, reqsCountLength: Int
    var connectionStatus: String
}

// MARK: - Profile
struct Profile543: Codable {
    let id, fullName: String
    let profilePic: String
    var verificationStatus, userBio, userName, location: String
    let normalUserInfo: [NormalUserInfo543]
    let mesiboAccount: [MesiboAccount]
    let userID: String
    let postCount: [PostCount543]
    let createdOn: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case fullName = "Full_name"
        case profilePic = "Profile_pic"
        case verificationStatus, userBio
        case userName = "User_name"
        case location, normalUserInfo
        case mesiboAccount = "Mesibo_account"
        case userID = "User_id"
        case postCount = "post_count"
        case createdOn = "Created_On"
    }
}

// MARK: - NormalUserInfo
struct NormalUserInfo543: Codable {
    let jobTitle: String
}

// MARK: - PostCount
struct PostCount543: Codable {
    let postID, id, dateAdded: String

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case id = "_id"
        case dateAdded = "date_added"
    }
}
