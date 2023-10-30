//
//  FeedModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct FeedModel: Decodable{
    var posts: [Post535]
}

// MARK: - Post
struct Post535: Codable {
    let id, userID: String
    let caption: String?
    let dateAdded, location, postType: String
    let canSee: String?
    let hotelID, hotelAddress, hotelName: String?
    let hotelCoverpicURL, hotelLogoURL: String?
    let bookingengineLink: String?
    let canComment: String?
    let eventLocation, eventName, checkinLocation, checkinVenue: String
    let jobTitle: String
    let pollQuestion: [PollQuestion535]
    let displayStatus, eventID: String
    let media: [Media535]
    let profilePic, userName, fullName, role: String
    let eventThumbnail, price, eventStartDate, verificationStatus: String
    let postID: String
    let savedPost: [JSONAny]
    let v: Int
    var like: String
    var likeCount, commentCount: Int
    var isSaved: String
    var voted: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case caption
        case dateAdded = "date_added"
        case location
        case postType = "post_type"
        case canSee = "Can_See"
        case hotelID = "hotel_id"
        case hotelAddress, hotelName
        case hotelCoverpicURL = "hotelCoverpicUrl"
        case hotelLogoURL = "hotelLogoUrl"
        case bookingengineLink
        case canComment = "Can_comment"
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
        case like
        case likeCount = "Like_count"
        case commentCount = "Comment_count"
        case isSaved, voted
    }
}

// MARK: - Media
struct Media535: Codable {
    let post: String
    let dateAdded, id: String

    enum CodingKeys: String, CodingKey {
        case post
        case dateAdded = "date_added"
        case id = "_id"
    }
}

// MARK: - PollQuestion
struct PollQuestion535: Codable {
    let question: String
    let options: [Option535]
    let id, questionID: String

    enum CodingKeys: String, CodingKey {
        case question = "Question"
        case options = "Options"
        case id = "_id"
        case questionID = "question_id"
    }
}

// MARK: - Option
struct Option535: Codable {
    let option, id, optionID: String
    var votes: [Vote535?]

    enum CodingKeys: String, CodingKey {
        case option = "Option"
        case id = "_id"
        case optionID = "option_id"
        case votes
    }
}

// MARK: - Vote
struct Vote535: Codable {
    let userID: String?
    let id: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case id = "_id"
    }
}
