//
//  AppliedJobs.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//

import Foundation


struct AppliedJobsModel: Identifiable, Codable{
    let id, userID, fullName, experience: String
    let resume: String
    let jid, applicationID, status, selfIntroduction: String
    let v: Int
    let jobData: JobData

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case fullName = "Full_name"
        case experience = "Experience"
        case resume, jid
        case applicationID = "applicationId"
        case status
        case selfIntroduction = "self_introduction"
        case v = "__v"
        case jobData
    }
}

// MARK: - JobData
struct JobData: Codable {
    let hotelLogoURL, id, userID, jobCategory: String
    let jobTitle, companyName, workplaceType, jobType: String
    let designationType, noticePeriod, expectedCTC, jobLocation: String
    let jobDescription, skillsRecq, displayStatus: String
    let jobApplicants: [JobApplicant1]
    let jid: String
    let bookmarked: [Bookmarked1]
    let v: Int

    enum CodingKeys: String, CodingKey {
        case hotelLogoURL = "hotelLogoUrl"
        case id = "_id"
        case userID = "user_id"
        case jobCategory, jobTitle, companyName, workplaceType, jobType, designationType, noticePeriod, expectedCTC, jobLocation, jobDescription, skillsRecq
        case displayStatus = "display_status"
        case jobApplicants, jid
        case bookmarked = "Bookmarked"
        case v = "__v"
    }
}

// MARK: - Bookmarked
struct Bookmarked1: Codable {
    let userID, id: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case id = "_id"
    }
}

// MARK: - JobApplicant
struct JobApplicant1: Codable {
    let userID, applicationID, id: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case applicationID = "applicationId"
        case id = "_id"
    }
}
