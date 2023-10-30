//
//  BlockedUserListModel.swift
//  R-own
//
//  Created by Aman Sharma on 27/07/23.
//

import Foundation
import SwiftUI

struct BlockedUserListModel: Codable{
    let id, fullName: String
    let profilePic: String
    let mesiboAccount: BlockedUserMesibo
    let verificationStatus, role, userID: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case fullName = "Full_name"
        case profilePic = "Profile_pic"
        case mesiboAccount = "Mesibo_account"
        case verificationStatus
        case role = "Role"
        case userID = "User_id"
    }
}

// MARK: - MesiboAccount
struct BlockedUserMesibo: Codable {
    let address: String
}
