//
//  ProfilePollsPostModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct ProfilePollsPostModel: Decodable{
    let page, pageSize: Int
    var posts: [Post434]
}

// MARK: - Post
struct Post434: Codable {
    let id, userID, dateAdded, location: String
    let postType: String
    let hotelID, hotelAddress, hotelName, hotelCoverpicURL: JSONNull?
    let hotelLogoURL, bookingengineLink: JSONNull?
    let eventLocation, eventName, checkinLocation, checkinVenue: String
    let jobTitle: String
    var pollQuestion: [PollQuestion434]
    let displayStatus, eventID: String
    let media: [JSONAny]
    let profilePic: String
    let userName, fullName, role, eventThumbnail: String
    let price, eventStartDate, verificationStatus, postID: String
    let savedPost: [JSONAny]
    let v: Int
    var voted: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case dateAdded = "date_added"
        case location
        case postType = "post_type"
        case hotelID = "hotel_id"
        case hotelAddress, hotelName
        case hotelCoverpicURL = "hotelCoverpicUrl"
        case hotelLogoURL = "hotelLogoUrl"
        case bookingengineLink
        case eventLocation = "Event_location"
        case eventName = "Event_name"
        case checkinLocation, checkinVenue, jobTitle, pollQuestion
        case displayStatus = "display_status"
        case eventID = "event_id"
        case media
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case fullName = "Full_name"
        case role = "Role"
        case eventThumbnail = "event_thumbnail"
        case price
        case eventStartDate = "event_start_date"
        case verificationStatus
        case postID = "post_id"
        case savedPost = "saved_post"
        case v = "__v"
        case voted
    }
}


// MARK: - PollQuestion
struct PollQuestion434: Codable {
    let question: String
    var options: [Option344]
    let id, questionID: String

    enum CodingKeys: String, CodingKey {
        case question = "Question"
        case options = "Options"
        case id = "_id"
        case questionID = "question_id"
    }
}

// MARK: - Option
struct Option344: Codable {
    let option: String
    let id, optionID: String
    var votes: [Vote344]?

    enum CodingKeys: String, CodingKey {
        case option = "Option"
        case id = "_id"
        case optionID = "option_id"
        case votes
    }
}

// MARK: - Vote
struct Vote344: Codable {
    let userID, fullName, role, id: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case fullName = "Full_name"
        case role = "Role"
        case id = "_id"
    }
}
