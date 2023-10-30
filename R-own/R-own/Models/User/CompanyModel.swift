//
//  CompanyModel.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import Foundation


struct Company: Codable, Hashable {
    let id, companyID, companyName, addedbyUser: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case companyID = "company_id"
        case companyName = "company_name"
        case addedbyUser
    }
}
