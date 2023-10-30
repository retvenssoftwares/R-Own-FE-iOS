//
//  MatchesJobCriteriaModel.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//

import Foundation


struct MatchesJobCriteriaModel: Identifiable, Codable{
    let id, userID, designationType, noticePeriod: String
    let department, preferredLocation, expectedCTC, employmentType: String
    let requestjobID: String
    let v: Int
    let fullName: String
    let profilePic: String
    let location: String
    let jobType, jobTitle: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID, designationType, noticePeriod, department, preferredLocation, expectedCTC, employmentType
        case requestjobID = "requestjob_id"
        case v = "__v"
        case fullName = "Full_name"
        case profilePic = "profile_pic"
        case location = "Location"
        case jobType, jobTitle
    }
}
