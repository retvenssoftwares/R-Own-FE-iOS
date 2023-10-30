//
//  HotelOwnerFPPProfileView.swift
//  R-own
//
//  Created by Aman Sharma on 15/05/23.
//

import SwiftUI

struct HotelOwnerFPPProfileView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM:  ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var profileService = ProfileService()
    
    @State var role: String
    @State var mainUser: Bool
    @State var userID: String
    @State var profileTabSelected: String = "Media"
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var islaodingData: Bool = false
    
    var body: some View {
        NavigationStack{
            if islaodingData {
                ZStack{
                    ScrollView{
                        VStack(alignment: .leading){
                            VStack{
                                HotelOwnerFPPViewFirstHalf(loginData: loginData, profileVM: profileVM, globalVM: globalVM, role: role, mainUser: mainUser, userID: userID, mesiboVM: mesiboVM)
                                
                                //Posts
                                HotelOwnerProfileFPPTabBarView(profileTabSelected: $profileTabSelected, loginData: loginData, globalVM: globalVM)
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
                                    
                                    if profileTabSelected == "Hotels"{
                                        HotelOwnerHotelsTabView(loginData: loginData, globalVM: globalVM, role: role, mainUser: mainUser, userID: userID)
                                            .ignoresSafeArea(.all, edges: .all)
                                            .tag("Hotels")
                                    }
                                    
                                    if profileTabSelected == "Events"{
                                        if loginData.isHiddenKPI{
                                            HotelOwnerEventsTabView(globalVM: globalVM, loginData: loginData, userID: userID, role: role, mainUser: mainUser)
                                                .ignoresSafeArea(.all, edges: .all)
                                                .tag("Events")
                                        }
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
                    TPPUserSettingBottomSheet(loginData: loginData, profileVM: profileVM, userRole: "Hotel Owner", globalVM: globalVM, mesiboVM: mesiboVM)
                }
            } else {
                ProgressView()
            }
        }
        .refreshable {
            islaodingData = false
            globalVM.getHotelOwnerProfileHeader = HotelOwnerProfileHeaderModel(profiledata: Profiledata3433(id: "", fullName: "", profilePic: "", mesiboAccount: [MesiboAccount](), userBio: "", userName: "", postCount: [PostCount3433]()), hotellogo: Hotellogo3433(id: "", hotelLogoURL: ""), connectionCount: 0, requestsCount: 0, postCount: 0, profile: Profile3433(hotelOwnerInfo: HotelOwnerInfo3433(hotelDescription: "", websiteLink: ""), id: "", verificationStatus: "", createdOn: "", location: ""), connectionStatus: "")
            
            Task{
                let res = await profileService.getHotelOwnerProfileHeader(globalVM: globalVM, userID: userID, connectionUserID: loginData.mainUserID)
                if res == "Success" {
                    islaodingData = true
                } else {
                    let res = await profileService.getHotelOwnerProfileHeader(globalVM: globalVM, userID: userID, connectionUserID: loginData.mainUserID)
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
            globalVM.viewingUserRole = "Hotel Owner"
            globalVM.viewingHotelOwnerUserID = userID
            globalVM.getHotelOwnerProfileHeader = HotelOwnerProfileHeaderModel(profiledata: Profiledata3433(id: "", fullName: "", profilePic: "", mesiboAccount: [MesiboAccount](), userBio: "", userName: "", postCount: [PostCount3433]()), hotellogo: Hotellogo3433(id: "", hotelLogoURL: ""), connectionCount: 0, requestsCount: 0, postCount: 0, profile: Profile3433(hotelOwnerInfo: HotelOwnerInfo3433(hotelDescription: "", websiteLink: ""), id: "", verificationStatus: "", createdOn: "", location: ""), connectionStatus: "")
        
            Task{
                let res = await profileService.getHotelOwnerProfileHeader(globalVM: globalVM, userID: userID, connectionUserID: loginData.mainUserID)
                if res == "Success" {
                    islaodingData = true
                } else {
                    let res = await profileService.getHotelOwnerProfileHeader(globalVM: globalVM, userID: userID, connectionUserID: loginData.mainUserID)
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

//struct HotelOwnerFPPProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelOwnerFPPProfileView()
//    }
//}
