//
//  ProfileViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 12/05/23.
//

import Foundation


class ProfileViewModel: ObservableObject{
    
    
    @Published var mainUserBio: String = ""
    @Published var mainUserDesignation: String = ""
    @Published var mainUserGender: String = ""
    @Published var mainUserResume: String = ""
    
    @Published var showNormalProfileEditBottomSheet: Bool = false
    @Published var showVendorProfileEditBottomSheet: Bool = false
    @Published var showHotelOwnerProfileEditBottomSheet: Bool = false
}
