//
//  ExploreJobModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation

struct ExploreJobModel: Decodable{
    var posts: [ExploreJobPost]
}

// MARK: - Post
struct ExploreJobPost: Codable {
    let hotelLogoURL: String
    let id, jobTitle, companyName, jobType: String
    let jobLocation: String
    let vendorimg: String?

    enum CodingKeys: String, CodingKey {
        case hotelLogoURL = "hotelLogoUrl"
        case id = "_id"
        case jobTitle, companyName, jobType, jobLocation, vendorimg
    }
}
