//
//  PollVotesModel.swift
//  R-own
//
//  Created by Aman Sharma on 23/07/23.
//

import SwiftUI
import Foundation

struct PollVotesModel: Decodable{
    let question: String
    let options: [Option234]
    let id, questionID: String

    enum CodingKeys: String, CodingKey {
        case question = "Question"
        case options = "Options"
        case id = "_id"
        case questionID = "question_id"
    }
}

// MARK: - Option
struct Option234: Codable {
    let option, id, optionID: String
    let votes: [Vote234]

    enum CodingKeys: String, CodingKey {
        case option = "Option"
        case id = "_id"
        case optionID = "option_id"
        case votes
    }
}

// MARK: - Vote
struct Vote234: Codable {
    let userID: String
    let profilePic: String
    let jobTitle, fullName, role, verificationStatus: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case profilePic = "profile_pic"
        case jobTitle = "job_title"
        case fullName = "Full_name"
        case role = "Role"
        case verificationStatus = "Verification_status"
    }
}
