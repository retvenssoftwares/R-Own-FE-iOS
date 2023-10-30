//
//  GetPostModel.swift
//  R-own
//
//  Created by Aman Sharma on 10/08/23.
//

import Foundation

// MARK: - NewFeedElement
struct GetPostModel: Codable {
    let id, userID, caption, dateAdded: String
    let location, postType, canSee: String
    let hotelID, hotelAddress, hotelName, hotelCoverpicURL: String?
    let hotelLogoURL, bookingengineLink: String?
    let canComment, eventLocation, eventName, checkinLocation: String
    let checkinVenue, jobTitle: String
    let pollQuestion: [PollQuestion535]
    let displayStatus, eventID: String
    var media: [Media535]
    let profilePic: String
    let userName, fullName, role, eventThumbnail: String
    let price, eventStartDate, verificationStatus, postID: String
    let savedPost: [JSONAny]
    let v: Int
    var saved, liked: String
    var likeCount, commentCount: Int

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
        case saved, liked, likeCount, commentCount
    }
}

// MARK: - Media
struct MediaFeed: Codable {
    let post: String
    let dateAdded, id: String

    enum CodingKeys: String, CodingKey {
        case post
        case dateAdded = "date_added"
        case id = "_id"
    }
}
