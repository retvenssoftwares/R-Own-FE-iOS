//
//  GetConnectionNotificationModel.swift
//  R-own
//
//  Created by Aman Sharma on 07/06/23.
//


import Foundation
import SwiftUI

struct GetConnectionNotification: Codable{
    let body: String
    let role: String
    let profilePic: String
    let verificationStatus, userID, userName, dateAdded: String
    let id: String
    let fullName: String?

    enum CodingKeys: String, CodingKey {
        case body
        case role = "Role"
        case profilePic = "Profile_pic"
        case verificationStatus
        case userID = "user_id"
        case userName = "User_name"
        case dateAdded = "date_added"
        case id = "_id"
        case fullName = "Full_name"
    }
}
