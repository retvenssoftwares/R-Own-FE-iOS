//
//  ContactsUserConnectionModel.swift
//  R-own
//
//  Created by Aman Sharma on 12/07/23.
//

import Foundation
import SwiftUI

struct ContactsUserConnectionModel: Decodable{
    let message: String
    var matchedContacts: [MatchedContact]?
}

// MARK: - MatchedContact
struct MatchedContact: Codable {
    let matchedNumber: MatchedNumber
    var connectionStatus: String
}

// MARK: - MatchedNumber
struct MatchedNumber: Codable {
    let id, fullName: String
    let profilePic: String
    let mesiboAccount: [MesiboAccount]
    let verificationStatus, userBio, role: String
    let normalUserInfo: [NormalUserInfo]
    let hospitalityExpertInfo: [JSONAny]
    let userID: String
    let connections, requests: [Connection]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case fullName = "Full_name"
        case profilePic = "Profile_pic"
        case mesiboAccount = "Mesibo_account"
        case verificationStatus, userBio
        case role = "Role"
        case normalUserInfo, hospitalityExpertInfo
        case userID = "User_id"
        case connections, requests
    }
}
// MARK: - NormalUserInfo
struct NormalUserInfo: Codable {
    let jobTitle: String
}
