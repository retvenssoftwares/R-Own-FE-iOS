//
//  MainFeedViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 11/04/23.
//

import SwiftUI


class MainFeedViewModel: ObservableObject{
    
    @Published var dbUsers: [UserDataFromServer] = []
    @Published var mesiboUsers: [MesiboUserCodable] = []
    @Published var sidebarX: CGFloat = -UIScreen.screenWidth + UIScreen.screenWidth/7
    
}
