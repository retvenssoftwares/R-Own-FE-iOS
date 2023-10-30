//
//  AddUserResponseModel.swift
//  R-own
//
//  Created by Aman Sharma on 10/04/23.
//

import Foundation
import SwiftUI

struct AddUserResponse: Codable{
    let address: String
    let token: String
    let uid: Int
}
