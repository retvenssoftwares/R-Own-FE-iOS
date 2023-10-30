//
//  DesignationModel.swift
//  R-own
//
//  Created by Aman Sharma on 06/06/23.
//

import Foundation


struct DesignationnModel: Codable{
    let id, designationName, addedbyUser, userid: String
    let showStatus, designationID: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case designationName = "designation_name"
        case addedbyUser, userid, showStatus
        case designationID = "designation_id"
        case v = "__v"
    }
}
