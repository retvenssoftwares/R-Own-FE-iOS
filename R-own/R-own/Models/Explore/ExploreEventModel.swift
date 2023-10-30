//
//  ExploreEventModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct ExploreEventModel: Decodable{
    var events: [ExploreEvent]
}

// MARK: - Event
struct ExploreEvent: Codable {
    let categoryName: String
    let userName, fullName, profilePic: String?
    let eventTitle, eventStartDate, eventID: String?
    let eventThumbnail: String
    let price, saved: String

    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case userName = "User_name"
        case fullName = "Full_name"
        case profilePic = "Profile_pic"
        case eventTitle = "event_title"
        case eventStartDate = "event_start_date"
        case eventID = "event_id"
        case eventThumbnail = "event_thumbnail"
        case price, saved
    }
}
