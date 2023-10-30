//
//  LikeServiceModel.swift
//  R-own
//
//  Created by Aman Sharma on 05/06/23.
//

import Foundation
import SwiftUI

struct LikeServiceModel: Codable{
    let post: Post7865
    let likeCount: Int
}

// MARK: - Post
struct Post7865: Codable {
    let id, postID, userID: String
    let likes: [Like4566]
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
struct Like4566: Codable {
    let userID, dateAdded: String
    let profilePic: String
    let userName, id: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case dateAdded = "date_added"
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case id = "_id"
    }
}
