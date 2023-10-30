//
//  JobApplicantsModel.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//

import Foundation


struct JobApplicantsModel: Identifiable, Codable{
    let id, userID, fullName, experience: String
    let resume: String
    let jid, applicationID, status, selfIntroduction: String
    let v: Int

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
    }
}
