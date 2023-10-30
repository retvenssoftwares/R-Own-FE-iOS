//
//  OwnCommunityGroupDetailsModel.swift
//  R-own
//
//  Created by Aman Sharma on 27/06/23.
//

import SwiftUI

struct OwnCommunityGroupDetailsModel: Codable {
    let id, creatorID, creatorName, groupName: String
    let profilePic: String
    let verificationStatus, description, groupID, location: String
    let latitude, longitude, communityType, dateAdded: String
    var admin, members: [Admin]
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case creatorID
        case creatorName = "creator_name"
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
struct Admin: Codable {
    let userID, admin, address: String
    let uid: Int
    let profilePic: String
    let fullName: String
    let role: String
    let verificationStatus, location: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case admin, address, uid
        case profilePic = "Profile_pic"
        case fullName = "Full_name"
        case role = "Role"
        case verificationStatus, location
    }
}
