//
//  ExploreViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 29/04/23.
//

import SwiftUI


class ExploreViewModel: ObservableObject{
    
    @Published var explorePostSearchText: String = ""
    @Published var explorePeopleSearchText: String = ""
    @Published var exploreBlogsSearchText: String = ""
    @Published var exploreHotelsSearchText: String = ""
    @Published var exploreServicesSearchText: String = ""
    @Published var exploreCategorySelected: String = "Posts"
    
    @Published var explorePostLoading: Bool = false
}

