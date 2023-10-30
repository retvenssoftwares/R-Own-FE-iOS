//
//  ContactsModel.swift
//  R-own
//
//  Created by Aman Sharma on 21/04/23.
//

import Foundation
import SwiftUI

struct Contacts: Codable, Hashable{
    let name: String
    let number: String
    let email: String
    let companyName: String

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case number = "Number"
        case email = "Email"
        case companyName = "Company_Name"
    }
}
