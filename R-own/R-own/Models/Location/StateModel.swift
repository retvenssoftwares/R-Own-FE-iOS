//
//  StateModel.swift
//  R-own
//
//  Created by Aman Sharma on 24/05/23.
//

import Foundation


struct StateModel: Codable, Hashable {
    let name, stateCode: String

    enum CodingKeys: String, CodingKey {
        case name
        case stateCode = "state_code"
    }
}

