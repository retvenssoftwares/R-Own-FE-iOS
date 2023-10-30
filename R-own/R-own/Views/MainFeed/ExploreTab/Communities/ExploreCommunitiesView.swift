//
//  ExploreCommunitiesView.swift
//  R-own
//
//  Created by Aman Sharma on 19/08/23.
//

import SwiftUI

struct ExploreCommunitiesView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var exploreVM: ExploreViewModel
    @StateObject var communityVM: CommunityViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    
    
    var body: some View {
        VStack{
            ExploreCommunityListView(loginData: loginData, globalVM: globalVM, communityVM: communityVM, mesiboVM: mesiboVM, profileVM: profileVM)
        }
    }
}

//struct ExploreCommunitiesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreCommunitiesView()
//    }
//}
