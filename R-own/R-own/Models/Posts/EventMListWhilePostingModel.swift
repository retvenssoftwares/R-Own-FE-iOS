//
//  EventMListWhilePostingodel.swift
//  R-own
//
//  Created by Aman Sharma on 31/05/23.
//

import Foundation

struct EventListWhilePostingModel: Decodable{
    let id, location, eventTitle: String
    let eventThumbnail: String
    let eventStartDate, eventStartTime, eventID: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case location
        case eventTitle = "event_title"
        case eventThumbnail = "event_thumbnail"
        case eventStartDate = "event_start_date"
        case eventStartTime = "event_start_time"
        case eventID = "event_id"
    }
}
