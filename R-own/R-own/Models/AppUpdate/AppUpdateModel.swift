//
//  AppUpdateModel.swift
//  R-own
//
//  Created by Aman Sharma on 15/07/23.
//


import Foundation
import SwiftUI

struct AppUpdateModel: Codable{
    let id, displayStatus, updateDescription, androidVersion: String
    let updateTitle: String
    let updateLink: String
    let updateID: String
    let v: Int
    let iOSVersion: String
    let iOSUpdateLink: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case displayStatus, updateDescription
        case androidVersion = "Android_version"
        case updateTitle, updateLink
        case updateID = "update_id"
        case v = "__v"
        case iOSVersion = "iOS_version"
        case iOSUpdateLink
    }
}
