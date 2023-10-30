//
//  RecentJobsModel.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//

import Foundation


struct RecentJobsModel: Identifiable, Codable{
    let id, userID: String
    let jobApplicants: [JobApplicant]
    let jid, jobTitle, companyName, workplaceType: String
    let jobType, designationType, noticePeriod, expectedCTC: String
    let jobLocation, jobDescription, skillsRecq: String
    let bookmarked: [JSONAny]
    let displayStatus, hotelLogoURL, hotelID: String
    let v: Int
    var saved, applyStatus: String
    let profileData: ProfileData?
    let jobCategory: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case jobApplicants, jid, jobTitle, companyName, workplaceType, jobType, designationType, noticePeriod, expectedCTC, jobLocation, jobDescription, skillsRecq
        case bookmarked = "Bookmarked"
        case displayStatus = "display_status"
        case hotelLogoURL = "hotelLogoUrl"
        case hotelID = "hotel_id"
        case v = "__v"
        case saved, applyStatus, profileData, jobCategory
    }
}

// MARK: - JobApplicant
struct JobApplicant: Codable {
    let userID, applicationID, id: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case applicationID = "applicationId"
        case id = "_id"
    }
}

// MARK: - ProfileData
struct ProfileData: Codable {
    let userName: String
    let profilePic: String

    enum CodingKeys: String, CodingKey {
        case userName = "User_name"
        case profilePic = "Profile_pic"
    }
}
