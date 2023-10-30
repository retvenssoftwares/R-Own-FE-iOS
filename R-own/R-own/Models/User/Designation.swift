//
//  DesignationModel.swift
//  R-own
//
//  Created by Aman Sharma on 24/05/23.
//

import Foundation


struct Designation: Codable, Hashable {
    let id, designationName, displayStatus, addedbyUser: String
    let designationID: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case designationName = "designation_name"
        case displayStatus = "display_status"
        case addedbyUser
        case designationID = "designation_id"
    }
}
