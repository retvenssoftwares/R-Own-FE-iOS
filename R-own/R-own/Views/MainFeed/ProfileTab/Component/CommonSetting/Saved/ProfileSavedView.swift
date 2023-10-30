//
//  ProfileSavedView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct ProfileSavedView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var savedCategorySelected: String = "Posts"
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Saved")
                    .padding(.bottom, UIScreen.screenHeight/50)
                VStack{
                    ProfileSavedTabsView(savedCategorySelected: $savedCategorySelected, loginData: loginData)
                    
                    ZStack{
                        TabView(selection: $savedCategorySelected){
                                
                            SavedPostsView(globalVM: globalVM, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM)
                                .ignoresSafeArea(.all, edges: .all)
                                .tag("Posts")
//                            if loginData.isHiddenKPI{
//                                SavedJobsView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, profileVM: profileVM)
//                                    .ignoresSafeArea(.all, edges: .all)
//                                    .tag("Jobs")
//                            }
                            SavedBlogsView(loginData: loginData, globalVM: globalVM)
                                .ignoresSafeArea(.all, edges: .all)
                                .tag("Blogs")
                            
//                            if loginData.isHiddenKPI{
//                                SavedEventsView(loginData: loginData, globalVM: globalVM)
//                                    .ignoresSafeArea(.all, edges: .all)
//                                    .tag("Events")
//                            }
                        
                            SavedHotelView(loginData: loginData, globalVM: globalVM)
                                .ignoresSafeArea(.all, edges: .all)
                                .tag("Hotels")
                            
//                            if loginData.isHiddenKPI{
//                                SavedServicesView(loginData: loginData, globalVM: globalVM)
//                                    .ignoresSafeArea(.all, edges: .all)
//                                    .tag("Services")
//                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct ProfileSavedView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileSavedView()
//    }
//}
