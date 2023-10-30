//
//  ProfileServicesPostModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct ProfileServicesPostModel: Decodable {
    let id, userID, serviceID, vendorServicePrice: String
    let profilePic: String
    let userName, vendorName, vendorImage, location: JSONNull?
    let serviceName: JSONNull?
    let displayStatus, vendorServiceID: String
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
        case displayStatus = "display_status"
        case vendorServiceID = "vendorServiceId"
        case v = "__v"
    }
}
