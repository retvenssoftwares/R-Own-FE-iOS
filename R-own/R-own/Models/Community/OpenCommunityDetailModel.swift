//
//  OpenCommunityDetailModel.swift
//  R-own
//
//  Created by Aman Sharma on 19/08/23.
//

import Foundation

import SwiftUI

struct OpenCommunityDetailModel: Codable {
    let creatorName, id, creatorID, groupName: String
    var profilePic: String
    var verificationStatus, description, groupID, location: String
    var latitude, longitude, communityType, dateAdded: String
    var admin: [OpenCommunityAdmin]
    var members: [OpenCommunityMember]
    let v: Int

    enum CodingKeys: String, CodingKey {
        case creatorName = "creator_name"
        case id = "_id"
        case creatorID
        case groupName = "group_name"
        case profilePic = "Profile_pic"
        case verificationStatus, description
        case groupID = "group_id"
        case location, latitude, longitude
        case communityType = "community_type"
        case dateAdded = "date_added"
        case admin = "Admin"
        case members = "Members"
        case v = "__v"
    }
}

// MARK: - Admin
struct OpenCommunityAdmin: Codable {
    var userID, admin, address: String
    var uid: Int
    var profilePic: String
    var fullName, role, verificationStatus: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case admin, address, uid
        case profilePic = "Profile_pic"
        case fullName = "Full_name"
        case role = "Role"
        case verificationStatus
    }
}

// MARK: - Member
struct OpenCommunityMember: Codable {
    let userID, admin, address: String
    let uid: Int
    let profilePic: String
    let fullName, role, verificationStatus: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case admin, address, uid
        case profilePic = "Profile_pic"
        case fullName = "Full_name"
        case role = "Role"
        case verificationStatus
    }
}

