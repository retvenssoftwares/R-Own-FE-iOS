//
//  BlogsModel.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//

import Foundation


struct BlogsModel: Decodable {
    let id: String
    let blogImage: String
    let profilePic: String
    let userName, categoryName, blogTitle, blogContent: String
    let categoryID, userID: String
    let likes: [Like12]
    let comments: [Comment12]
    let savedBlog: [JSONAny]
    let blogID, dateAdded: String
    let v: Int
    let fullName, displayStatus, saved, like: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case blogImage = "blog_image"
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case categoryName = "category_name"
        case blogTitle = "blog_title"
        case blogContent = "blog_content"
        case categoryID = "category_id"
        case userID = "User_id"
        case likes, comments
        case savedBlog = "saved_blog"
        case blogID = "blog_id"
        case dateAdded = "date_added"
        case v = "__v"
        case fullName = "Full_name"
        case displayStatus = "display_status"
        case saved, like
    }
}

// MARK: - Comment
struct Comment12: Codable {
    let userID, comment, userName, fullName: String
    let profilePic: String
    let verificationStatus, role, commentID, displayStatus: String
    let dateAdded, id: String
    let replies: [Comment12]?
    let parentCommentID: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case comment
        case userName = "User_name"
        case fullName = "Full_name"
        case profilePic = "Profile_pic"
        case verificationStatus
        case role = "Role"
        case commentID = "comment_id"
        case displayStatus = "display_status"
        case dateAdded = "date_added"
        case id = "_id"
        case replies
        case parentCommentID = "parent_comment_id"
    }
}

// MARK: - Like
struct Like12: Codable {
    let userID, id: String
    let dateAdded: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case id = "_id"
        case dateAdded = "date_added"
    }
}
