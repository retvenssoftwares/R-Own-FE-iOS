//
//  ProfileHotelPostModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct ProfileHotelPostModel: Decodable {
    let id, userID, hotelName: String
    let hotelAddress, hotelRating: String?
    let hotelLogoURL: String
    let hotelCoverpicURL: String
    let dateAdded, hoteldescription, hotelID: String
    let gallery: [Gallery43]
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case hotelName, hotelAddress, hotelRating
        case hotelLogoURL = "hotelLogoUrl"
        case hotelCoverpicURL = "hotelCoverpicUrl"
        case dateAdded = "date_added"
        case hoteldescription = "Hoteldescription"
        case hotelID = "hotel_id"
        case gallery
        case v = "__v"
    }
}

// MARK: - Gallery
struct Gallery43: Codable {
    let images: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case images = "Images"
        case id = "_id"
    }
}
