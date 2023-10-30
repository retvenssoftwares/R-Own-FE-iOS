//
//  EventsByUserIDModel.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import Foundation


struct EventsByUserIDModel: Decodable {
    let displayStatus, id, categoryID: String
    let profilePic: String
    let userName, categoryName, userID, location: String
    let venue, country, state, city: String
    let eventTitle, eventDescription, eventCategory, email: String
    let phone, websiteLink, bookingLink, price: String
    let eventThumbnail: String
    let eventStartDate, eventStartTime, eventEndDate, eventEndTime: String
    let registrationStartDate, registrationStartTime, registrationEndDate, registrationEndTime: String
    let eventID, dateAdded: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case displayStatus = "display_status"
        case id = "_id"
        case categoryID = "category_id"
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case categoryName = "category_name"
        case userID = "User_id"
        case location, venue, country, state, city
        case eventTitle = "event_title"
        case eventDescription = "event_description"
        case eventCategory = "event_category"
        case email, phone
        case websiteLink = "website_link"
        case bookingLink = "booking_link"
        case price
        case eventThumbnail = "event_thumbnail"
        case eventStartDate = "event_start_date"
        case eventStartTime = "event_start_time"
        case eventEndDate = "event_end_date"
        case eventEndTime = "event_end_time"
        case registrationStartDate = "registration_start_date"
        case registrationStartTime = "registration_start_time"
        case registrationEndDate = "registration_end_date"
        case registrationEndTime = "registration_end_time"
        case eventID = "event_id"
        case dateAdded = "date_added"
        case v = "__v"
    }
}
