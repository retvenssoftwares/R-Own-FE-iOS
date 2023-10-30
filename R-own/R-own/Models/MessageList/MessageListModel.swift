//
//  MessageListModel.swift
//  R-own
//
//  Created by Aman Sharma on 22/07/23.
//


import Foundation
import SwiftUI
import mesibo

struct MessageListModel: Identifiable, Equatable, Hashable {
    var id: Int
    var mMessage: MesiboMessage

    // Implement the == operator to compare two MessageListModel instances
    static func ==(lhs: MessageListModel, rhs: MessageListModel) -> Bool {
        return lhs.id == rhs.id
    }

    // Implement hash(into:) method for Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
