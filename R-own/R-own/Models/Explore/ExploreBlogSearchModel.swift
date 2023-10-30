//
//  ExploreBlogSearchModel.swift
//  R-own
//
//  Created by Aman Sharma on 11/07/23.
//

import Foundation

struct ExploreBlogSearchModel: Decodable{
    let page, pageSize: Int
    var blogs: [ExploreBlogSearch]
}

// MARK: - Blog
struct ExploreBlogSearch: Codable {
    let categoryName, blogTitle: String
    let blogImage: String
    let userName: String
    let profilePic: String
    var fullName, verificationStatus, blogID, saved: String
    var like: String
    let likeCount, commentCount: Int
    let displayStatus: String

    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case blogTitle = "blog_title"
        case blogImage = "blog_image"
        case userName = "User_name"
        case profilePic = "Profile_pic"
        case fullName = "Full_name"
        case verificationStatus
        case blogID = "blog_id"
        case saved, like
        case likeCount = "Like_count"
        case commentCount = "comment_count"
        case displayStatus = "display_status"
    }
}
