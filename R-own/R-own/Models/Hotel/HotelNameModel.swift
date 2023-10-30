//
//  HotelNameModel.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import Foundation
import SwiftUI

struct HotelNameModel: Codable, Hashable{
    let id, companyID, companyName: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case companyID = "company_id"
        case companyName = "company_name"
    }
}
