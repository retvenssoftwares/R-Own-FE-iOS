//
//  VendorFPPProfileView.swift
//  R-own
//
//  Created by Aman Sharma on 15/05/23.
//

import SwiftUI

struct VendorFPPProfileView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM:  ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    
    
    @State var role: String
    @State var mainUser: Bool
    @State var userID: String
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var profileTabSelected: String = "Media"
    
    @StateObject var profileService = ProfileService()
    
    @State var islaodingData: Bool = false
    
    var body: some View {
        NavigationStack{
            if islaodingData{
                ZStack{
                    ScrollView{
                        VStack(alignment: .leading){
                            VStack{
                                VendorProfileFPPViewFirstHalf(loginData: loginData, profileVM: profileVM, globalVM: globalVM, role: role, mainUser: mainUser, userID: userID, mesiboVM: mesiboVM)
                                
                                //Posts
                                VendorProfileFPPTabBarView(profileTabSelected: $profileTabSelected)
                                    .background(profilePostBG)
                            }
                            //tabs content
                            VStack{
                                HStack{
                                    if profileTabSelected == "Media"{
                                        NormalProfileFPPMediaTabView(globalVM: globalVM, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM, userID: userID, role: role, mainUser: mainUser)
                                            .ignoresSafeArea(.all, edges: .all)
                                    }
                                    
                                    if profileTabSelected == "Polls"{
                                        NormalProfileFPPPollsTabView(loginData: loginData, globalVM: globalVM, role: role, mainUser: mainUser, userID: userID, profileVM: profileVM, mesiboVM: mesiboVM)
                                            .ignoresSafeArea(.all, edges: .all)
                                    }
                                    
                                    
                                    if profileTabSelected == "Status"{
                                        NormalProfileFPPStatusTabView(loginData: loginData, globalVM: globalVM, userID: userID, role: role, mainUser: mainUser)
                                            .ignoresSafeArea(.all, edges: .all)
                                    }
                                    
                                    if profileTabSelected == "Services"{
                                        CommonProfileFPPServicesTab(loginData: loginData, globalVM: globalVM, role: role, mainUser: mainUser, userID: userID)
                                            .ignoresSafeArea(.all, edges: .all)
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
                    TPPUserSettingBottomSheet(loginData: loginData, profileVM: profileVM, userRole: "Business Vendor / Freelancer", globalVM: globalVM, mesiboVM: mesiboVM)
                }
            } else {
                ProgressView()
            }
        }
        .refreshable {
            islaodingData = false
            globalVM.getVendorProfileHeader = VendorProfileHeaderModel(roleDetails: RoleDetails321(vendorInfo: VendorInfo321(vendorImage: "", vendorName: "", vendorDescription: "", websiteLink: "", vendorServices: [VendorService321](), portfolioLink: [PortfolioLink321]()), id: "", fullName: "", profilePic: "", mesiboAccount: [MesiboAccount](), verificationStatus: "", userBio: "", createdOn: "", userName: "", location: "", role: "", postCount: [JSONAny]()), postcount: 0, connectioncount: 0, requestcount: 0, connectionStatus: "")
            
            Task{
                let res = await profileService.getVendorProfileHeader(globalVM: globalVM, userID: userID, connectionUserID: loginData.mainUserID)
                if res == "Success" {
                    islaodingData = true
                } else {
                    let res = await profileService.getVendorProfileHeader(globalVM: globalVM, userID: userID, connectionUserID: loginData.mainUserID)
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
            globalVM.viewingUserRole = "Business Vendor / Freelancer"
            globalVM.viewingVendorUserID = userID
            globalVM.getVendorProfileHeader = VendorProfileHeaderModel(roleDetails: RoleDetails321(vendorInfo: VendorInfo321(vendorImage: "", vendorName: "", vendorDescription: "", websiteLink: "", vendorServices: [VendorService321](), portfolioLink: [PortfolioLink321]()), id: "", fullName: "", profilePic: "", mesiboAccount: [MesiboAccount](), verificationStatus: "", userBio: "", createdOn: "", userName: "", location: "", role: "", postCount: [JSONAny]()), postcount: 0, connectioncount: 0, requestcount: 0, connectionStatus: "")
            
            Task{
                let res = await profileService.getVendorProfileHeader(globalVM: globalVM, userID: userID, connectionUserID: loginData.mainUserID)
                if res == "Success" {
                    islaodingData = true
                } else {
                    let res = await profileService.getVendorProfileHeader(globalVM: globalVM, userID: userID, connectionUserID: loginData.mainUserID)
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

//struct VendorFPPProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorFPPProfileView()
//    }
//}
