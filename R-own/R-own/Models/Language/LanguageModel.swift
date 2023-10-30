//
//  LanguageModel.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//
import Foundation
import SwiftUI

struct Language: Identifiable {
    
    var id = UUID().uuidString
    
    
    var langName: String
    var langCode: String
    var langImgW: String
    var langImgG: String
    
}
