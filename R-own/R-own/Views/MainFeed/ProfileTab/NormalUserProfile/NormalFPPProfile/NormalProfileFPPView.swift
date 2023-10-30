//
//  NormalProfileFPPView.swift
//  R-own
//
//  Created by Aman Sharma on 12/05/23.
//

import SwiftUI

struct NormalProfileFPPView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM:  ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var profileService = ProfileService()
    
    @State var role: String
    @State var mainUser: Bool
    @State var userID: String
    
    @State var profileTabSelected: String = "Media"
    @State var islaodingData: Bool = false
    
    var body: some View {
        NavigationStack{
            if islaodingData {
                ZStack{
                    ScrollView{
                        VStack(alignment: .leading){
                            VStack{
                                NormalProfileFPPViewFirstHalf(loginData: loginData, profileVM: profileVM, globalVM: globalVM, role: role, mainUser: mainUser, userID: userID, mesiboVM: mesiboVM)
                                
                                
                                //Posts
                                NormalProfileFPPTabBarView(profileTabSelected: $profileTabSelected, loginData: loginData, globalVM: globalVM)
                                    .background(profilePostBG)
                            }
                            //tabs content
                            VStack{
                                HStack{
                                    if profileTabSelected == "Media"{
                                        NormalProfileFPPMediaTabView(globalVM: globalVM, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM, userID: userID, role: role, mainUser: mainUser)
                                            .ignoresSafeArea(.all, edges: .all)
                                            .tag("Media")
                                    }
                                    
                                    if profileTabSelected == "Polls"{
                                        NormalProfileFPPPollsTabView(loginData: loginData, globalVM: globalVM, role: role, mainUser: mainUser, userID: userID, profileVM: profileVM, mesiboVM: mesiboVM)
                                            .ignoresSafeArea(.all, edges: .all)
                                            .tag("Polls")
                                    }
                                    
                                    if profileTabSelected == "Status"{
                                        NormalProfileFPPStatusTabView(loginData: loginData, globalVM: globalVM, userID: userID, role: role, mainUser: mainUser)
                                            .ignoresSafeArea(.all, edges: .all)
                                            .tag("Status")
                                    }
                                }
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                if mainUser {
                                    Spacer(minLength: UIScreen.screenHeight/50)
                                }
                            }
                            .frame( height: UIScreen.screenHeight/1.3)
                        }
                    }
                    TPPUserSettingBottomSheet(loginData: loginData, profileVM: profileVM, userRole: "Normal User", globalVM: globalVM, mesiboVM: mesiboVM)
                }
            } else {
                ProgressView()
            }
        }
        .refreshable {
            islaodingData = false
            globalVM.getNormalProfileHeader = NormalProfileHeaderModel(data: DataClass543(profile: Profile543(id: "", fullName: "", profilePic: "", verificationStatus: "", userBio: "", userName: "", location: "", normalUserInfo: [NormalUserInfo543](), mesiboAccount: [MesiboAccount](), userID: "", postCount: [PostCount543](), createdOn: ""), postCountLength: 0, connCountLength: 0, reqsCountLength: 0, connectionStatus: ""))
            Task{
                let res = await profileService.getNormalProfileHeader(loginData: loginData, globalVM: globalVM, userID: userID, connectionUserID: loginData.mainUserID)
                if res == "Success" {
                    islaodingData = true
                } else {
                    let res = await profileService.getNormalProfileHeader(loginData: loginData, globalVM: globalVM, userID: userID, connectionUserID: loginData.mainUserID)
                    if res == "Success" {
                        islaodingData = true
                    } else {
                        islaodingData = true
                    }
                }
            }
        }
        .onAppear{
            islaodingData = false
            globalVM.viewingUserRole = "Normal User"
            globalVM.viewingNormalUserID = userID
            globalVM.getNormalProfileHeader = NormalProfileHeaderModel(data: DataClass543(profile: Profile543(id: "", fullName: "", profilePic: "", verificationStatus: "", userBio: "", userName: "", location: "", normalUserInfo: [NormalUserInfo543](), mesiboAccount: [MesiboAccount](), userID: "", postCount: [PostCount543](), createdOn: ""), postCountLength: 0, connCountLength: 0, reqsCountLength: 0, connectionStatus: ""))
            Task{
                let res = await profileService.getNormalProfileHeader(loginData: loginData, globalVM: globalVM, userID: userID, connectionUserID: loginData.mainUserID)
                if res == "Success" {
                    islaodingData = true
                } else {
                    let res = await profileService.getNormalProfileHeader(loginData: loginData, globalVM: globalVM, userID: userID, connectionUserID: loginData.mainUserID)
                    if res == "Success" {
                        islaodingData = true
                    } else {
                        islaodingData = true
                    }
                }
            }
        }
    }
}



//struct NormalProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileFPPView()
//    }
//}
