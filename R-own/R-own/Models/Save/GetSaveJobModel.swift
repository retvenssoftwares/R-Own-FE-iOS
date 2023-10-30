//
//  GetSaveJobModel.swift
//  R-own
//
//  Created by Aman Sharma on 16/06/23.
//

import Foundation


struct GetSaveJobModel: Decodable {
    let page, pageSize: Int
    var jobs: [JobSave]
}

// MARK: - Job
struct JobSave: Codable {
    let jobid, jobTitle, hotelLogoURL, expectedCTC: String
    let jobType, companyName, jobLocation, id: String

    enum CodingKeys: String, CodingKey {
        case jobid, jobTitle
        case hotelLogoURL = "hotelLogoUrl"
        case expectedCTC, jobType, companyName, jobLocation
        case id = "_id"
    }
}
