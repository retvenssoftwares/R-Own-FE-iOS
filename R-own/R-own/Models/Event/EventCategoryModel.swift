//
//  EventCategory.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//

import Foundation


struct EventCategoryModel: Codable, Hashable {
    let categoryID, categoryName: String
    let image: String
    let eventCount: Int

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
        case image = "Image"
        case eventCount = "event_count"
    }
}
