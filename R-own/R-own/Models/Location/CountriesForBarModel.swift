//
//  CountriesForBarModel.swift
//  R-own
//
//  Created by Aman Sharma on 05/06/23.
//

import Foundation


struct CountriesForBar: Codable, Hashable {
    let id, name, phoneCode, emoji: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case phoneCode = "phone_code"
        case emoji
    }
}
