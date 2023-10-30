//
//  CommunityDetailModel.swift
//  R-own
//
//  Created by Aman Sharma on 27/06/23.
//

import SwiftUI

struct CommunityDetailModel: Codable {
    let profilePic: String
    let groupName, description, dateAdded, creatorName: String
    var admin, members: [MesiboGroupUser]
    var latitude, longitude, communityType: String
    var totalmember: Int
    let location: String

    enum CodingKeys: String, CodingKey {
        case profilePic = "Profile_pic"
        case groupName = "group_name"
        case description
        case dateAdded = "date_added"
        case creatorName = "creator_name"
        case admin = "Admin"
        case members = "Members"
        case latitude, longitude
        case communityType = "community_type"
        case totalmember = "Totalmember"
        case location
    }
}

// MARK: - Admin
struct MesiboGroupUser: Codable {
    let userID, fullName, address: String
    let uid: Int
    let profilePic: String
    let verificationStatus, location, role, admin: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case fullName = "Full_name"
        case address, uid
        case profilePic = "Profile_pic"
        case verificationStatus, location
        case role = "Role"
        case admin
    }
}
