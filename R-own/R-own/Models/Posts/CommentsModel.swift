//
//  CommentsModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct CommentsModel: Decodable {
    let post: Post533
    let commentCount: Int
}

// MARK: - Post
struct Post533: Codable {
    let id, postID: String
    let comments: [Comment4535]
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case postID = "post_id"
        case comments
        case v = "__v"
    }
}

// MARK: - Comment
struct Comment4535: Codable {
    let userID, comment, commentID, dateAdded: String
    let profilePic: String
    let userName, id: String
    let replies: [Comment4535]?
    let parentCommentID: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case comment
        case commentID = "comment_id"
        case dateAdded = "date_added"
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case id = "_id"
        case replies
        case parentCommentID = "parent_comment_id"
    }
}
