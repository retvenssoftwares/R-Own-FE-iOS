//
//  NewFeedModel.swift
//  R-own
//
//  Created by Aman Sharma on 28/07/23.
//

import Foundation

// MARK: - NewFeedElement
struct NewFeedModel: Codable {
    var posts: [NewFeedPost]
    var blogs: [NewFeedBlog]
    var hotels: [NewFeedHotel]
    var communities: [NewFeedCommunity]
    var services: [NewFeedService]
}

// MARK: - Blog
struct NewFeedBlog: Codable {
    let blogID, blogTitle, blogContent: String
    let blogImage: String
    let categoryName, id: String
    let profilePic: String
    let userName, categoryID, userID: String
    let likes, comments: [JSONAny]
    var like, saved: String

    enum CodingKeys: String, CodingKey {
        case blogID = "blog_id"
        case blogTitle = "blog_title"
        case blogContent = "blog_content"
        case blogImage = "blog_image"
        case categoryName = "category_name"
        case id = "_id"
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case categoryID = "category_id"
        case userID = "User_id"
        case likes, comments, like, saved
    }
}

// MARK: - Community
struct NewFeedCommunity: Codable {
    let creatorID: String
    let creatorName: String?
    let groupName: String
    let profilePic: String
    let verificationStatus, description, groupID, location: String
    let latitude, longitude, communityType: String
    var admin, members: [Admin]

    enum CodingKeys: String, CodingKey {
        case creatorID
        case creatorName = "creator_name"
        case groupName = "group_name"
        case profilePic = "Profile_pic"
        case verificationStatus, description
        case groupID = "group_id"
        case location, latitude, longitude
        case communityType = "community_type"
        case admin = "Admin"
        case members = "Members"
    }
}

// MARK: - Admin
struct NewFeedCommunityAdmin: Codable {
    let userID: String
    let fullName: String?
    let address: String
    let uid: Int
    let profilePic: String
    let verificationStatus, location: String
    let role: String
    let admin, id: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case fullName = "Full_name"
        case address, uid
        case profilePic = "Profile_pic"
        case verificationStatus, location
        case role = "Role"
        case admin
        case id = "_id"
    }
}

// MARK: - Hotel
struct NewFeedHotel: Codable {
    let hotelID, hotelName, hotelAddress, hotelRating: String
    let hotelLogoURL: String?
    let hotelCoverpicURL: String
    var bookingengineLink, saved: String

    enum CodingKeys: String, CodingKey {
        case hotelID = "hotel_id"
        case hotelName, hotelAddress, hotelRating
        case hotelLogoURL = "hotelLogoUrl"
        case hotelCoverpicURL = "hotelCoverpicUrl"
        case bookingengineLink, saved
    }
}

// MARK: - Post
struct NewFeedPost: Codable {
    let id, userID, caption: String
    let adminpostID, adminStatus: String?
    let dateAdded, location, postType: String
    let hotelID, hotelAddress, hotelName, hotelCoverpicURL: String?
    let hotelLogoURL: String?
    let eventLocation, eventName, checkinLocation, checkinVenue: String
    let jobTitle, displayStatus: String
    let media: [Media535]
    let userName: String
    let fullName: String?
    let eventThumbnail: String
    let pollQuestion: [PollQuestion535]
    let savedPost: [JSONAny]
    let v: Int
    let canSee: String?
    let bookingengineLink: String?
    let canComment, eventID: String?
    let profilePic: String?
    let role: String?
    let price, eventStartDate, verificationStatus, postID: String?
    var like: String?
    var likeCount, commentCount: Int?
    var isSaved: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case caption
        case adminpostID = "adminpostId"
        case adminStatus
        case dateAdded = "date_added"
        case location
        case postType = "post_type"
        case hotelID = "hotel_id"
        case hotelAddress, hotelName
        case hotelCoverpicURL = "hotelCoverpicUrl"
        case hotelLogoURL = "hotelLogoUrl"
        case eventLocation = "Event_location"
        case eventName = "Event_name"
        case checkinLocation, checkinVenue, jobTitle
        case displayStatus = "display_status"
        case media
        case userName = "User_name"
        case fullName = "Full_name"
        case eventThumbnail = "event_thumbnail"
        case pollQuestion
        case savedPost = "saved_post"
        case v = "__v"
        case canSee = "Can_See"
        case bookingengineLink
        case canComment = "Can_comment"
        case eventID = "event_id"
        case profilePic = "Profile_pic"
        case role = "Role"
        case price
        case eventStartDate = "event_start_date"
        case verificationStatus
        case postID = "post_id"
        case like
        case likeCount = "Like_count"
        case commentCount = "Comment_count"
        case isSaved
    }
}


// MARK: - Service
struct NewFeedService: Codable {
    let userID, serviceID, vendorServicePrice: String
    let profilePic: String?
    let userName: String?
    let vendorName: String
    let vendorImage: String
    let location: String?
    let serviceName, verificationStatus, vendorServiceID: String
    let displayStatus: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case serviceID = "serviceId"
        case vendorServicePrice
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case vendorName, vendorImage, location
        case serviceName = "service_name"
        case verificationStatus
        case vendorServiceID = "vendorServiceId"
        case displayStatus = "display_status"
    }
}
