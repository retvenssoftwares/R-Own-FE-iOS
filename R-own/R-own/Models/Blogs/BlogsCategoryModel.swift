//
//  BlogsCategory.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation


struct BlogsCategoryModel: Codable, Hashable {
    let categoryID, categoryName, image: String
    let blogCount: Int

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
        case image = "Image"
        case blogCount = "blog_count"
    }
}
