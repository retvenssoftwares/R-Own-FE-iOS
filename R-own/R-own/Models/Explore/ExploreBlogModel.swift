//
//  ExploreBlogModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct ExploreBlogModel: Decodable{
    let page, pageSize: Int
    var blogs: [ExploreBlog]
}

// MARK: - Blog
struct ExploreBlog: Codable {
    let blogTitle: String
    let blogImage: String
    let categoryName, userName, fullName: String
    let profilePic: String
    var saved, displayStatus, blogID, like: String
    var likeCount, commentCount: Int
    let dateAdded: String

    enum CodingKeys: String, CodingKey {
        case blogTitle = "blog_title"
        case blogImage = "blog_image"
        case categoryName = "category_name"
        case userName = "User_name"
        case fullName = "Full_name"
        case profilePic = "Profile_pic"
        case saved
        case displayStatus = "display_status"
        case blogID = "blog_id"
        case like
        case likeCount = "Like_count"
        case commentCount = "comment_count"
        case dateAdded = "date_added"
    }
}
