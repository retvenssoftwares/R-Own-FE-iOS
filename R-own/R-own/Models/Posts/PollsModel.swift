//
//  PollsModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct PollsModel: Decodable {
    let id, userID, location, postType: String
    let eventLocation, eventName, checkinLocation, checkinVenue: String
    let pollQuestion: [PollQuestion2]
    let displayStatus: String
    let media: [JSONAny]
    let profilePic: String
    let userName, eventThumbnail, price, eventStartDate: String
    let verificationStatus, postID: String
    let savedPost: [JSONAny]
    let v: Int
    let voted: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case location
        case postType = "post_type"
        case eventLocation = "Event_location"
        case eventName = "Event_name"
        case checkinLocation, checkinVenue, pollQuestion
        case displayStatus = "display_status"
        case media
        case profilePic = "Profile_pic"
        case userName = "User_name"
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
struct PollQuestion2: Codable {
    let question: String
    let options: [Option2]
    let id, questionID, dateAdded: String

    enum CodingKeys: String, CodingKey {
        case question = "Question"
        case options = "Options"
        case id = "_id"
        case questionID = "question_id"
        case dateAdded = "date_added"
    }
}

// MARK: - Option
struct Option2: Codable {
    let option, id, optionID: String
    let votes: [JSONAny]
    let dateAdded: String

    enum CodingKeys: String, CodingKey {
        case option = "Option"
        case id = "_id"
        case optionID = "option_id"
        case votes
        case dateAdded = "date_added"
    }
}
