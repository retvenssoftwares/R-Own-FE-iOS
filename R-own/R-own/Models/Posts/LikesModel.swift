//
//  LikesModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct LikesModel: Decodable {
    var post: Post0343
    let likeCount: Int
}

// MARK: - Post
struct Post0343: Codable {
    let id, postID, userID: String
    var likes: [Like0343]
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case postID = "post_id"
        case userID = "user_id"
        case likes
        case v = "__v"
    }
}

// MARK: - Like
struct Like0343: Codable {
    let userID, jobTitle, dateAdded: String
    let profilePic: String
    let userName, verificationStatus, role, fullName: String
    let displayStatus, id: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case jobTitle
        case dateAdded = "date_added"
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case verificationStatus
        case role = "Role"
        case fullName = "Full_name"
        case displayStatus = "display_status"
        case id = "_id"
    }
}
