//
//  normalMessageResponseMoodel.swift
//  R-own
//
//  Created by Aman Sharma on 21/04/23.
//

import Foundation
import SwiftUI

struct NormalMessageResponse: Codable{
    let message: String

    enum CodingKeys: String, CodingKey {
        case message
    }
}
