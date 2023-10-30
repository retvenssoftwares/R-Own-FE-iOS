//
//  HotelsModel.swift
//  R-own
//
//  Created by Aman Sharma on 06/05/23.
//


import Foundation
import SwiftUI

struct Hotel {
    let hotelOwnerID, hotelName, hotelAddress, hotelRating: String
    let hotelLogoURL, hotelDescription: String
    let hotelProfilepicURL, hotelCoverpicURL: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case hotelOwnerID = "hotelOwnerId"
        case hotelName, hotelAddress, hotelRating, hotelDescription
        case hotelLogoURL = "hotelLogoUrl"
        case hotelProfilepicURL = "hotelProfilepicUrl"
        case hotelCoverpicURL = "hotelCoverpicUrl"
    }
}
