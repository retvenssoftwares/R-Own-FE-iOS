//
//  GetHotelOwnerInfoModel.swift
//  R-own
//
//  Created by Aman Sharma on 12/06/23.
//

import Foundation

// MARK: - WelcomeElement
struct GetHotelOwnerInfoModel: Codable {
    var hotelOwnerInfo: [HotelOwnerInfoElement23]
    let hotelID: String
    let hotelLogoURL: String

    enum CodingKeys: String, CodingKey {
        case hotelOwnerInfo
        case hotelID = "hotel_id"
        case hotelLogoURL = "hotelLogoUrl"
    }
}

// MARK: - HotelOwnerInfoElement
struct HotelOwnerInfoElement23: Codable {
    var hotelOwnerInfo: HotelOwnerInfoHotelOwnerInfo23
    let id: String

    enum CodingKeys: String, CodingKey {
        case hotelOwnerInfo
        case id = "_id"
    }
}

// MARK: - HotelOwnerInfoHotelOwnerInfo
struct HotelOwnerInfoHotelOwnerInfo23: Codable {
    var hotelownerName, hotelDescription, hotelType, hotelCount: String
    var websiteLink, bookingEngineLink, hotelownerid: String
    var hotelInfo: [JSONAny]
}
