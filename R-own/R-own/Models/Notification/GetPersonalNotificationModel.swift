//
//  GetPersonalNotificationModel.swift
//  R-own
//
//  Created by Aman Sharma on 07/06/23.
//


import Foundation
import SwiftUI

struct GetPersonalNotification: Codable{
    let postID: String?
    let postType: String?
    let body: String
    let profilePic: String
    let fullName, userID: String
    let userName, verificationStatus, commentID: String?
    let dateAdded: String
    let media: String?
    let id: String

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case postType = "post_type"
        case body
        case profilePic = "Profile_pic"
        case fullName = "Full_name"
        case userID = "user_id"
        case userName = "User_name"
        case verificationStatus
        case commentID = "comment_id"
        case dateAdded = "date_added"
        case media = "Media"
        case id = "_id"
    }
}
