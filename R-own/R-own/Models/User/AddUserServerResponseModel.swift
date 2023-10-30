//
//  AddUserServerResponseModel.swift
//  R-own
//
//  Created by Aman Sharma on 10/04/23.
//

import Foundation
import SwiftUI

struct AddUserToServerViaNumResponse: Codable{
    let message: String
    let userID: String

    enum CodingKeys: String, CodingKey {
        case message
        case userID = "user_id"
    }
}
