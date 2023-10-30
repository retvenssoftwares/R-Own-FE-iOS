//
//  DepartmentModel.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//

import Foundation


struct DepartmentModel: Codable, Hashable {
    let id, department, displayStatus, departmentID: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case department
        case displayStatus = "display_status"
        case departmentID = "department_id"
        case v = "__v"
    }
}
