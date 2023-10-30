//
//  GetSaveEventModel.swift
//  R-own
//
//  Created by Aman Sharma on 16/06/23.
//

import SwiftUI

struct GetSaveEventModel: Decodable {
    let page, pageSize: Int
    var events: [EventSave]
}

// MARK: - Event
struct EventSave: Codable {
    let eventid, eventCategory, eventTitle: String
    let eventThumbnail: String
    let eventStartDate, price: String
    let profilePic: String
    let userName, id: String

    enum CodingKeys: String, CodingKey {
        case eventid
        case eventCategory = "event_category"
        case eventTitle = "event_title"
        case eventThumbnail = "event_thumbnail"
        case eventStartDate = "event_start_date"
        case price
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case id = "_id"
    }
}
