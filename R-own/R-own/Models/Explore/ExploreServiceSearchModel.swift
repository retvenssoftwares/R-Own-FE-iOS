//
//  ExploreServiceSearchModekl.swift
//  R-own
//
//  Created by Aman Sharma on 11/07/23.
//

import Foundation

struct ExploreServiceSearchModel: Decodable{
    let page, pageSize: Int
    var posts: [ExploreServiceSearch]
}

// MARK: - Post
struct ExploreServiceSearch: Codable {
    let id, userID, serviceID, vendorServicePrice: String
    let profilePic: String?
    let userName, vendorName, vendorImage, location: String
    let serviceName, verificationStatus, vendorServiceID, displayStatus: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case serviceID = "serviceId"
        case vendorServicePrice
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case vendorName, vendorImage, location
        case serviceName = "service_name"
        case verificationStatus
        case vendorServiceID = "vendorServiceId"
        case displayStatus = "display_status"
        case v = "__v"
    }
}
