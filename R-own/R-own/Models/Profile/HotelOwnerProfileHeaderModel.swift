//
//  HotelOwnerProfileHeaderModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct HotelOwnerProfileHeaderModel: Decodable{
    var profiledata: Profiledata3433
    let hotellogo: Hotellogo3433
    let connectionCount, requestsCount, postCount: Int
    let profile: Profile3433
    var connectionStatus: String

    enum CodingKeys: String, CodingKey {
        case profiledata, hotellogo
        case connectionCount = "connection_Count"
        case requestsCount = "requests_count"
        case postCount = "post_count"
        case profile, connectionStatus
    }
}

// MARK: - Hotellogo
struct Hotellogo3433: Codable {
    let id: String
    let hotelLogoURL: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case hotelLogoURL = "hotelLogoUrl"
    }
}

// MARK: - Profile
struct Profile3433: Codable {
    let hotelOwnerInfo: HotelOwnerInfo3433
    let id, verificationStatus, createdOn, location: String

    enum CodingKeys: String, CodingKey {
        case hotelOwnerInfo
        case id = "_id"
        case verificationStatus
        case createdOn = "Created_On"
        case location
    }
}

// MARK: - HotelOwnerInfo
struct HotelOwnerInfo3433: Codable {
    let hotelDescription, websiteLink: String
}

// MARK: - Profiledata
struct Profiledata3433: Codable {
    let id, fullName: String
    let profilePic: String
    let mesiboAccount: [MesiboAccount]
    var userBio, userName: String
    let postCount: [PostCount3433]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case fullName = "Full_name"
        case profilePic = "Profile_pic"
        case mesiboAccount = "Mesibo_account"
        case userBio
        case userName = "User_name"
        case postCount = "post_count"
    }
}

// MARK: - PostCount
struct PostCount3433: Codable {
    let postID, dateAdded, id: String

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case dateAdded = "date_added"
        case id = "_id"
    }
}
