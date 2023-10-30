//
//  GetSaveBlogModel.swift
//  R-own
//
//  Created by Aman Sharma on 16/06/23.
//

import SwiftUI

struct GetSaveBlogModel: Decodable {
    let page, pageSize: Int
    var blogs: [BlogSave]
}

// MARK: - Blog
struct BlogSave: Codable {
    let blogid: String
    let blogImage: String
    let categoryName, blogTitle: String
    let profilePic: String
    let userName, id: String
    let likeCount, commentCount: Int

    enum CodingKeys: String, CodingKey {
        case blogid
        case blogImage = "blog_image"
        case categoryName = "category_name"
        case blogTitle = "blog_title"
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case id = "_id"
        case likeCount, commentCount
    }
}
