//
//  ExplorePostModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct ExplorePostModel: Decodable{
    let page, pageSize: Int
    var posts: [ExplorePost]
}

// MARK: - Post
struct ExplorePost: Codable {
    let id, userID: String
    let caption: String?
    let dateAdded, location: String
    let postType: String
    let canSee: String
    let hotelID, hotelAddress, hotelName, hotelCoverpicURL: String?
    let hotelLogoURL, bookingengineLink: String?
    let canComment: String
    let eventLocation, eventName, checkinLocation, checkinVenue: String
    let jobTitle: String
    let pollQuestion: [JSONAny]
    let displayStatus, eventID: String
    let media: [Media535]
    let profilePic: String?
    let userName: String?
    let fullName: String?
    let role: String?
    let eventThumbnail, price, eventStartDate, verificationStatus: String
    let postID: String
    let savedPost: [JSONAny]
    let v: Int
    var liked: String
    var saved: String
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
        case liked, saved, likeCount, commentCount
    }
}

//// MARK: - Media
//struct ExplorePostMedia: Codable {
//    let post: String
//    let dateAdded, id: String
//
//    enum CodingKeys: String, CodingKey {
//        case post
//        case dateAdded = "date_added"
//        case id = "_id"
//    }
//}
