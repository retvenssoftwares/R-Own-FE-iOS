//
//  VendorServiceModel.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import Foundation
import SwiftUI

struct VendorService: Codable, Hashable{
    let id: String
    let serviceName: String?
    let displayStatus, serviceID: String
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case serviceName = "service_name"
        case displayStatus = "display_status"
        case serviceID = "serviceId"
        case v = "__v"
    }
}
