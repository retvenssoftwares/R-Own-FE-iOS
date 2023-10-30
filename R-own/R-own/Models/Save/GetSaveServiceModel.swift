//
//  GetSaveServiceModel.swift
//  R-own
//
//  Created by Aman Sharma on 16/06/23.
//

import SwiftUI

struct GetSaveServiceModel: Decodable {
    let page, pageSize: Int
    var services: [ServiceSave]
}

// MARK: - Service
struct ServiceSave: Codable {
    let serviceid, vendorName, vendorImage, location: String
    let vendorServicePrice: String
    let profilePic: String
    let userName, id: String

    enum CodingKeys: String, CodingKey {
        case serviceid, vendorName, vendorImage, location, vendorServicePrice
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case id = "_id"
    }
}
