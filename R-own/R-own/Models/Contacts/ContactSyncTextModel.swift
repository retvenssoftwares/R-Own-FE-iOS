//
//  ContactSyncTextModel.swift
//  R-own
//
//  Created by Aman Sharma on 20/08/23.
//

import Foundation

// MARK: - ContactSyncTextElement
struct ContactSyncTextModel: Codable {
    let id, conatctSynctext: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case conatctSynctext
    }
}
