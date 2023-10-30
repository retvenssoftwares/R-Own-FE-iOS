//
//  CountryModel.swift
//  R-own
//
//  Created by Aman Sharma on 24/05/23.
//

import Foundation


struct CountryModel: Codable, Hashable {
    let name, numericCode: String

    enum CodingKeys: String, CodingKey {
        case name
        case numericCode = "numeric_code"
    }
}

