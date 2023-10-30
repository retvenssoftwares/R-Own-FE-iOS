//
//  RequestedUsersModel.swift
//  R-own
//
//  Created by Aman Sharma on 09/06/23.
//

import Foundation

struct RequestedUsersModel: Codable {
    let status, id, userID, designationType: String
    let noticePeriod, department, preferredLocation, expectedCTC: String
    let employmentType, requestjobID: String
    let v: Int
    let fullName: String?
    let profilePic: String?
    let location: String?

    enum CodingKeys: String, CodingKey {
        case status
        case id = "_id"
        case userID, designationType, noticePeriod, department, preferredLocation, expectedCTC, employmentType
        case requestjobID = "requestjob_id"
        case v = "__v"
        case fullName = "Full_name"
        case profilePic = "Profile_pic"
        case location = "Location"
    }
}
