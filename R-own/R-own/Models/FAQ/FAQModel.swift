//
//  FAQModel.swift
//  R-own
//
//  Created by Aman Sharma on 07/08/23.
//

import SwiftUI


// MARK: - NewFeedElement
struct FAQModel: Codable {
    let id, question, answer, displayStatus: String
    let date, faqID: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case question, answer
        case displayStatus = "display_status"
        case date = "Date"
        case faqID = "faqId"
        case v = "__v"
    }
}
