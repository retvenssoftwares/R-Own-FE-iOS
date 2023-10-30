//
//  HotelDataModel.swift
//  R-own
//
//  Created by Aman Sharma on 30/05/23.
//

import Foundation
import SwiftUI

struct HotelDataModel: Decodable{
    let id, userID, hotelName, hotelAddress: String
    let hotelRating, hotelLogoURL: String
    let hotelCoverpicURL: String
    let bookingengineLink: String
    let dateAdded, hoteldescription, displayStatus, hotelID: String
    let gallery: [Gallery]
    let v: Int

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
    }
}

// MARK: - Gallery
struct Gallery23: Codable {
    let image1: String
    let image2, image3, id: String

    enum CodingKeys: String, CodingKey {
        case image1 = "Image1"
        case image2 = "Image2"
        case image3 = "Image3"
        case id = "_id"
    }
}
