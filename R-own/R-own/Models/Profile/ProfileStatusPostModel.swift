//
//  ProfileStatusPostModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct ProfileStatusPostModel: Decodable {
    let page, pageSize: Int
    var posts: [Post583]
}

// MARK: - Post
struct Post583: Codable {
    let hotelID, hotelAddress, hotelName: String?
    let hotelCoverpicURL, hotelLogoURL: String?
    let id, userID: String
    var caption: String?
    let dateAdded, location, postType: String
    let canSee, canComment: String?
    let eventLocation, eventName, checkinLocation: String
    let checkinVenue: String
    let jobTitle: String
    let pollQuestion: [JSONAny]
    var displayStatus, eventID: String
    let media: [JSONAny]
    let profilePic: String
    let userName, fullName, eventThumbnail, price: String
    let eventStartDate, verificationStatus, postID: String
    let savedPost: [JSONAny]
    let v: Int
    var saved, liked: String
    var likeCount, commentCount: Int
    let bookingengineLink: String?

    enum CodingKeys: String, CodingKey {
        case hotelID = "hotel_id"
        case hotelAddress, hotelName
        case hotelCoverpicURL = "hotelCoverpicUrl"
        case hotelLogoURL = "hotelLogoUrl"
        case id = "_id"
        case userID = "user_id"
        case caption
        case dateAdded = "date_added"
        case location
        case postType = "post_type"
        case canSee = "Can_See"
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
        case eventThumbnail = "event_thumbnail"
        case price
        case eventStartDate = "event_start_date"
        case verificationStatus
        case postID = "post_id"
        case savedPost = "saved_post"
        case v = "__v"
        case saved, liked, likeCount, commentCount, bookingengineLink
    }
}
