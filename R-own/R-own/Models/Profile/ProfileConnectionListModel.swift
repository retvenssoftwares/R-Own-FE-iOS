//
//  ProfileConnectionListModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct ProfileConnectionListModel: Decodable {
    var conns: [Conn334]
}
struct Conn334: Codable, Equatable {
    let id, fullName, phone: String
    let profilePic: String
    let mesiboAccount: [MesiboAccount4325]
    let verificationStatus, role, userID, userName: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case fullName = "Full_name"
        case phone = "Phone"
        case profilePic = "Profile_pic"
        case mesiboAccount = "Mesibo_account"
        case verificationStatus
        case role = "Role"
        case userID = "User_id"
        case userName = "User_name"
    }
}

struct MesiboAccount4325: Codable, Equatable {
    let uid: Int
    let address, token, id: String

    enum CodingKeys: String, CodingKey {
        case uid, address, token
        case id = "_id"
    }
}

extension Conn334: Identifiable {
    var uniqueId: String { id }
}

extension MesiboAccount4325: Identifiable {
    var uniqueId: String { id }
}

extension Conn334: Hashable {
    static func == (lhs: Conn334, rhs: Conn334) -> Bool {
        lhs.id == rhs.id &&
            lhs.fullName == rhs.fullName &&
            lhs.phone == rhs.phone &&
            lhs.profilePic == rhs.profilePic &&
            lhs.mesiboAccount == rhs.mesiboAccount &&
            lhs.verificationStatus == rhs.verificationStatus &&
            lhs.role == rhs.role &&
            lhs.userID == rhs.userID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(fullName)
        hasher.combine(phone)
        hasher.combine(profilePic)
        hasher.combine(mesiboAccount)
        hasher.combine(verificationStatus)
        hasher.combine(role)
        hasher.combine(userID)
    }
}

extension MesiboAccount4325: Hashable {
    static func == (lhs: MesiboAccount4325, rhs: MesiboAccount4325) -> Bool {
        lhs.uid == rhs.uid &&
            lhs.address == rhs.address &&
            lhs.token == rhs.token &&
            lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
        hasher.combine(address)
        hasher.combine(token)
        hasher.combine(id)
    }
}

