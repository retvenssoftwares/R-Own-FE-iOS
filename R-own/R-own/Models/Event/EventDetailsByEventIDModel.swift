//
//  EventDetailsByEventIDModel.swift
//  R-own
//
//  Created by Aman Sharma on 31/05/23.
//

import Foundation

struct EventDetailsByEventIDModel: Decodable {
    var id, categoryID: String
    var profilePic, userName, categoryName: String?
    var userID, location, venue, country: String
    var state, city, eventTitle, eventDescription: String
    var eventCategory, email, phone, websiteLink: String
    var bookingLink, price: String
    var eventThumbnail: String
    var eventStartDate, eventStartTime, eventEndDate, eventEndTime: String
    var registrationStartDate, registrationStartTime, registrationEndDate, registrationEndTime: String
    var eventID, dateAdded: String
    let v: Int

    enum CodingKeys: String, CodingKey {
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
