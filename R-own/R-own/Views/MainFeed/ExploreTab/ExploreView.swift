//
//  ExploreView.swift
//  R-own
//
//  Created by Aman Sharma on 11/04/23.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var exploreVM: ExploreViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var communityVM: CommunityViewModel
    
    @StateObject var exploreService = ExploreService()
    
    var body: some View {
        VStack{
            ExploreViewFirstHalfView(exploreVM: exploreVM, loginData: loginData)
            ExploreViewSecondHalfView(loginData: loginData, globalVM: globalVM, exploreVM: exploreVM)
            VStack{
                
                if exploreVM.exploreCategorySelected == "Posts"{
                    ExplorePostsView(globalVM: globalVM, loginData: loginData, profileVM: profileVM, exploreVM: exploreVM, mesiboVM: mesiboVM)
                        .ignoresSafeArea(.all, edges: .all)
                }
                
                if exploreVM.exploreCategorySelected == "Jobs"{
                    if loginData.isHiddenKPI{
                        ExploreJobsView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                            .ignoresSafeArea(.all, edges: .all)
                    }
                }
            
                
                if exploreVM.exploreCategorySelected == "People"{
                    ExplorePeopleView(globalVM: globalVM, loginData: loginData, profileVM: profileVM, exploreVM: exploreVM, mesiboVM: mesiboVM)
                        .ignoresSafeArea(.all, edges: .all)
                }
                
                
                if exploreVM.exploreCategorySelected == "Blogs"{
                    ExploreBlogsView(globalVM: globalVM, loginData: loginData, exploreVM: exploreVM)
                        .ignoresSafeArea(.all, edges: .all)
                }
                
                
                if exploreVM.exploreCategorySelected == "Events"{
                    if loginData.isHiddenKPI{
                        ExploreEventsView(loginData: loginData, globalVM: globalVM)
                            .ignoresSafeArea(.all, edges: .all)
                    }
                }
                
                if exploreVM.exploreCategorySelected == "Hotels"{
                    ExploreHotelsView(loginData: loginData, globalVM: globalVM, exploreVM: exploreVM)
                        .ignoresSafeArea(.all, edges: .all)
                }
            
                
                if exploreVM.exploreCategorySelected == "Services"{
                    ExploreServicesView(loginData: loginData, globalVM: globalVM, exploreVM: exploreVM, profileVM: profileVM, mesiboVM: mesiboVM)
                        .ignoresSafeArea(.all, edges: .all)
                }
                
                if exploreVM.exploreCategorySelected == "Communities"{
                    ExploreCommunitiesView(globalVM: globalVM, loginData: loginData, exploreVM: exploreVM, communityVM: communityVM, mesiboVM: mesiboVM, profileVM: profileVM)
                        .ignoresSafeArea(.all, edges: .all)
                }
            }
            Spacer()
        }
        .onAppear{
//            exploreService.getExplorePosts(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: "1")
        }
    }
}

//struct ExploreView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreView()
//    }
//}
