//
//  NearestConcertModel.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//

import Foundation


struct NearestConcertModel: Codable, Hashable {
    let id: String
    let categoryID: String
    let profilePic: String
    let userName: String
    let categoryName: String
    let userID: String
    let location: String
    let venue: String
    let country: String
    let state: String
    let city: String
    let eventTitle: String
    let eventDescription: String
    let eventCategory: String
    let email: String
    let phone: String
    let websiteLink: String
    let bookingLink: String
    let price: String
    let eventThumbnail: String
    let eventStartDate: String
    let eventStartTime: String
    let eventEndDate: String
    let eventEndTime: String
    let registrationStartDate: String
    let registrationStartTime: String
    let registrationEndDate: String
    let registrationEndTime: String
    let eventID, dateAdded: String
    let v: Int
    let saved: String

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
        case saved
    }
}
