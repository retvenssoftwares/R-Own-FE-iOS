//
//  GetSavePostModel.swift
//  R-own
//
//  Created by Aman Sharma on 16/06/23.
//

import Foundation


struct GetSavePostModel: Decodable {
    var posts: [PostSave]
    var page, pageSize: Int
}

// MARK: - Post
struct PostSave: Codable {
    let postid: String
    let userName, fullName: String?
    let profilePic: String?
    let media: [Media643]
    let id: String
    var likeCount, commentCount: Int

    enum CodingKeys: String, CodingKey {
        case postid
        case userName = "User_name"
        case fullName = "Full_name"
        case profilePic = "Profile_pic"
        case media
        case id = "_id"
        case likeCount, commentCount
    }
}

// MARK: - Media
//struct Media643: Codable {
//    let post: String
//    let dateAdded, id: String
//
//    enum CodingKeys: String, CodingKey {
//        case post
//        case dateAdded = "date_added"
//        case id = "_id"
//    }
//}
