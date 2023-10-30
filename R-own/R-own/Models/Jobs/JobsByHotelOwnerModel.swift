//
//  JobsByHotelOwnerModel.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//

import Foundation


struct JobsByHotelOwnerModel: Identifiable, Codable{
    let id, userID: String
    let jobApplicants: [JSONAny]
    let jid, jobTitle, companyName, workplaceType: String
    let jobType, designationType, noticePeriod, expectedCTC: String
    let jobLocation, jobDescription, skillsRecq: String
    let bookmarked: [JSONAny]
    let displayStatus, hotelLogoURL, hotelID: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case jobApplicants, jid, jobTitle, companyName, workplaceType, jobType, designationType, noticePeriod, expectedCTC, jobLocation, jobDescription, skillsRecq
        case bookmarked = "Bookmarked"
        case displayStatus = "display_status"
        case hotelLogoURL = "hotelLogoUrl"
        case hotelID = "hotel_id"
        case v = "__v"
    }
}

