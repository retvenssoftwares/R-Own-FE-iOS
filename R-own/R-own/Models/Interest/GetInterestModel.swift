//
//  GetInterestModel.swift
//  R-own
//
//  Created by Aman Sharma on 19/04/23.
//


import Foundation
import SwiftUI

struct GetInterest: Codable, Identifiable, Hashable {
    let id, name, welcomeID: String
    let userList: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "Name"
        case welcomeID = "id"
        case userList = "User_list"
    }
}
