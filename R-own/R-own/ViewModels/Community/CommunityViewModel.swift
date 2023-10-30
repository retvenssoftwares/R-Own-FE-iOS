//
//  CommunityViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 04/05/23.
//

import SwiftUI


class CommunityViewModel: ObservableObject{
    
    @Published var communityName: String = ""
    @Published var communityDescription: String = ""
    
    
    @Published var communityLocation: String = ""
    @Published var communityCountry: String = ""
    @Published var communityState: String = ""
    @Published var communityCity: String = ""
    @Published var communityLatitude: String = ""
    @Published var communityLongitude: String = ""
    
    @Published var communityJustMadeID: Int = 0
    
    
    @Published var communityType: String = ""
    
    @Published var selectedGroupMember = [Conn334]()
    
    @Published var communityImage: UIImage?
    @Published var communityImageLink: String = ""
    
    @Published var selectedCommunityTab: String = "Users"
    
    @Published var showOpenCommunityBottomSheet: Bool = false
    @Published var showCloseCommunityBottomSheet: Bool = false
    @Published var showAdminMemberSettingBottomSheet: Bool = false
    @Published var showRemoveMemberBottomSheet: Bool = false
    @Published var showRemoveCommunityBottomSheet: Bool = false
    @Published var showLeaveCommunityBottomSheet: Bool = false
    
    
    @Published var selectedGroupID: String = ""
    @Published var selectedGroupUserID: String = ""
    @Published var selectedGRoupUserAddress: String = ""
    @Published var selectedGroupUserRole: String = ""
    
    
}
