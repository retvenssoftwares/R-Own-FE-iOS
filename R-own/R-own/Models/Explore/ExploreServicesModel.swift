//
//  ExploreServicesModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct ExploreServicesModel: Decodable{
    var page, pageSize: Int
    var vendors: [ExploreVendor]
}

// MARK: - Vendor
struct ExploreVendor: Codable {
    let id, userID, vendorServicePrice: String
    let profilePic: String?
    let userName, vendorName: String?
    let vendorImage: String?
    let location: String?
    let displayStatus: String
    let vendorServices: [ExploreVendorService]
    let averageRating: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case vendorServicePrice
        case profilePic = "Profile_pic"
        case userName = "User_name"
        case vendorName, vendorImage, location
        case displayStatus = "display_status"
        case vendorServices, averageRating
    }
}

// MARK: - VendorService
struct ExploreVendorService: Codable {
    let vendorServiceID: String?
    let serviceID: String?
    let serviceName: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case vendorServiceID = "vendorServiceId"
        case serviceID = "serviceId"
        case serviceName = "service_name"
        case id = "_id"
    }
}
