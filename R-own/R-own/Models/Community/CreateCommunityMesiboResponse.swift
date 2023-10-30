//
//  CreateCommunityMesiboResponse.swift
//  R-own
//
//  Created by Aman Sharma on 27/06/23.
//

import Foundation
import SwiftUI

struct CreateCommunityMesiboResponse: Codable{
    let group: MesiboGroup
    let op: String
    let result: Bool
}

// MARK: - Group
struct MesiboGroup: Codable {
    let gid: Int
}
