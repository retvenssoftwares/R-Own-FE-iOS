//
//  ProfilePostModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct ProfileMediaPostModel: Decodable {
    let page, pageSize: Int
    var posts: [Post643]
}

// MARK: - Post
struct Post643: Codable {
    var id, userID, caption, location: String
    var postType, canSee, canComment, eventLocation: String
    let eventName, checkinLocation, checkinVenue, jobTitle: String
    let pollQuestion: [JSONAny]
    let displayStatus, eventID: String
    let media: [Media643]
    let profilePic: String
    let userName, fullName, eventThumbnail, price: String
    let eventStartDate, verificationStatus, postID, dateAdded: String
    let savedPost: [JSONAny]
    let v: Int
    var saved, liked: String
    var likeCount, commentCount: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case caption, location
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
        case dateAdded = "date_added"
        case savedPost = "saved_post"
        case v = "__v"
        case saved, liked, likeCount, commentCount
    }
}

// MARK: - Media
struct Media643: Codable {
    let post: String
    let dateAdded, id: String

    enum CodingKeys: String, CodingKey {
        case post
        case dateAdded = "date_added"
        case id = "_id"
    }
}
