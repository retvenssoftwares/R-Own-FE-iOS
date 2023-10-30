//
//  CommentModel.swift
//  R-own
//
//  Created by Aman Sharma on 05/06/23.
//
import Foundation
import SwiftUI

struct CommentServiceModel: Codable{
    var post: Post5355
    var commentCount: Int
}

// MARK: - Post
struct Post5355: Codable {
    let id, userID, postID: String
    var comments: [Comment5355]
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case postID = "post_id"
        case comments
        case v = "__v"
    }
}

// MARK: - Comment
struct Comment5355: Codable {
    let userID, comment, commentID, dateAdded: String
    let profilePic: String
    let userName, fullName, verificationStatus, role: String
    let displayStatus, id: String
    var replies: [Reply5355]?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case comment
        case commentID = "comment_id"
        case dateAdded = "date_added"
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case fullName = "Full_name"
        case verificationStatus
        case role = "Role"
        case displayStatus = "display_status"
        case id = "_id"
        case replies
    }
}

// MARK: - Reply
struct Reply5355: Codable {
    let userID, comment, commentID, parentCommentID: String
    let dateAdded, displayStatus: String
    let profilePic: String
    let userName,fullName, id: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case comment
        case commentID = "comment_id"
        case parentCommentID = "parent_comment_id"
        case dateAdded = "date_added"
        case displayStatus = "display_status"
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case fullName = "Full_name"
        case id = "_id"
    }
}
