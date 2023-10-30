//
//  GetSaveHotelModel.swift
//  R-own
//
//  Created by Aman Sharma on 16/06/23.
//

import SwiftUI

struct GetSaveHotelModel: Decodable {
    let page, pageSize: Int
    var hotels: [HotelSave]
}

// MARK: - Hotel
struct HotelSave: Codable {
    let hotelid: String
    let hotelCoverpicURL: String
    let hotelAddress, hotelName, hotelRating, id: String

    enum CodingKeys: String, CodingKey {
        case hotelid
        case hotelCoverpicURL = "hotelCoverpicUrl"
        case hotelAddress, hotelName, hotelRating
        case id = "_id"
    }
}

