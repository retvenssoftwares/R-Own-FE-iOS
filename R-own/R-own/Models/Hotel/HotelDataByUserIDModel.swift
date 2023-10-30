//
//  HotelDataByUserID.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import Foundation
import SwiftUI

struct HotelDataByUserID: Decodable{
    var id, userID, hotelName, hotelAddress: String
    var hotelRating: String
    var hotelLogoURL: String
    var hotelCoverpicURL: String
    var bookingengineLink, dateAdded, hoteldescription, displayStatus: String
    var hotelID: String
    var gallery: [Gallery]
    let v: Int
    var saved: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case hotelName, hotelAddress, hotelRating
        case hotelLogoURL = "hotelLogoUrl"
        case hotelCoverpicURL = "hotelCoverpicUrl"
        case bookingengineLink
        case dateAdded = "date_added"
        case hoteldescription = "Hoteldescription"
        case displayStatus = "display_status"
        case hotelID = "hotel_id"
        case gallery
        case v = "__v"
        case saved
    }
}

// MARK: - Gallery
struct Gallery: Codable {
    var image1, image2, image3: String
    var id: String

    enum CodingKeys: String, CodingKey {
        case image1 = "Image1"
        case image2 = "Image2"
        case image3 = "Image3"
        case id = "_id"
    }
}
