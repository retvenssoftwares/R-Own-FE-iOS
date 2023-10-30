//
//  VendorProfileHeaderModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct VendorProfileHeaderModel: Decodable{
    var roleDetails: RoleDetails321
    let postcount, connectioncount, requestcount: Int
    var connectionStatus: String
}

// MARK: - RoleDetails
struct RoleDetails321: Codable {
    var vendorInfo: VendorInfo321
    var id, fullName: String
    let profilePic: String
    let mesiboAccount: [MesiboAccount]
    var verificationStatus, userBio, createdOn, userName: String
    let location, role: String
    let postCount: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case vendorInfo
        case id = "_id"
        case fullName = "Full_name"
        case profilePic = "Profile_pic"
        case mesiboAccount = "Mesibo_account"
        case verificationStatus, userBio
        case createdOn = "Created_On"
        case userName = "User_name"
        case location
        case role = "Role"
        case postCount = "post_count"
    }
}

// MARK: - VendorInfo
struct VendorInfo321: Codable {
    var vendorImage: String
    var vendorName, vendorDescription, websiteLink: String
    var vendorServices: [VendorService321]
    var portfolioLink: [PortfolioLink321]
}

// MARK: - PortfolioLink
struct PortfolioLink321: Codable {
    var image1, image2, image3, id: String

    enum CodingKeys: String, CodingKey {
        case image1 = "Image1"
        case image2 = "Image2"
        case image3 = "Image3"
        case id = "_id"
    }
}

// MARK: - VendorService
struct VendorService321: Codable {
    let vendorServiceID, serviceID, id: String
    let serviceName: String?

    enum CodingKeys: String, CodingKey {
        case vendorServiceID = "vendorServiceId"
        case serviceID = "serviceId"
        case serviceName = "service_name"
        case id = "_id"
    }
}
