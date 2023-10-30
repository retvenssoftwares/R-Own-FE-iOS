//
//  ServiceByIDModel.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import Foundation
import SwiftUI

struct ServiceByIDModel: Codable, Hashable{
    let id, userID, serviceID, vendorServicePrice: String
    let vendorName: String
    let vendorImage: String
    let serviceName, verificationStatus, vendorServiceID, displayStatus: String
    let v: Int
    let userName, location: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case serviceID = "serviceId"
        case vendorServicePrice, vendorName, vendorImage
        case serviceName = "service_name"
        case verificationStatus
        case vendorServiceID = "vendorServiceId"
        case displayStatus = "display_status"
        case v = "__v"
        case userName = "User_name"
        case location
    }
}
