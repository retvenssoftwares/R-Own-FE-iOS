//
//  ExploreHotelModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct ExploreHotelModel: Decodable{
    let page, pageSize: Int
    var posts: [ExploreHotelPost]
}

// MARK: - Post
struct ExploreHotelPost: Codable {
    let id, hotelName, hotelAddress, hotelRating: String
    let hotelLogoURL, hotelCoverpicURL: String
    let displayStatus, hotelID: String
    var saved: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case hotelName, hotelAddress, hotelRating
        case hotelLogoURL = "hotelLogoUrl"
        case hotelCoverpicURL = "hotelCoverpicUrl"
        case displayStatus = "display_status"
        case hotelID = "hotel_id"
        case saved
    }
}
