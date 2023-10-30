//
//  BlogsListModel.swift
//  R-own
//
//  Created by Aman Sharma on 20/06/23.
//

import Foundation

// MARK: - WelcomeElement
struct BlogListModel: Codable {
    let id: String
    let blogImage: String
    let profilePic: String
    let userName: String
    let categoryName: String?
    let blogTitle, blogContent, categoryID, userID: String
    var likes: [Like345]
    var comments: [Comment345]
    let savedBlog: [JSONAny]
    let blogID, dateAdded: String
    let v: Int
    var fullName, displayStatus, saved, like: String
    let verificationStatus: String?

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
        case saved, like, verificationStatus
    }
}

// MARK: - Comment
struct Comment345: Codable {
    let userID, comment, userName: String
    let fullName: String?
    let profilePic: String
    let verificationStatus: String
    let role: String?
    let commentID, displayStatus, dateAdded, id: String
    let replies: [Comment345]?
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
struct Like345: Codable {
    var userID: String
    var id, dateAdded: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case id = "_id"
        case dateAdded = "date_added"
    }
}
