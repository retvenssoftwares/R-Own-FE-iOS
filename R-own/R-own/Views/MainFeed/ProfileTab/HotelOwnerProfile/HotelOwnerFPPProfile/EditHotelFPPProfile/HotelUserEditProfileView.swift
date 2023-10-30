//
//  HotelUserEditProfileView.swift
//  R-own
//
//  Created by Aman Sharma on 12/06/23.
//

import SwiftUI

struct HotelUserEditProfileView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State private var newProfilePic: UIImage?
    @StateObject var hotelService = HotelService()
    @StateObject var mainUserService = MainUserService()
    
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack{
            if isLoading {
                if loginData.profileCompletionPercentage == "100" {
                    ScrollView {
                        ZStack{
                            VStack{
                                //nav
                                BasicNavbarView(navbarTitle: "Edit Your Profile")
                                
                                //profile picture
                                EditFPPProfilePicView(loginData: loginData, globalVM: globalVM, newHotelLogo: $newProfilePic,  currentLogoURL: loginData.userData.profilePic)
                                
                                //Details
                                HotelUserEditFPPProfileDetailsView(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
                                
                                //Save button
                                Button(action: {
                                    hotelService.updateHotelOwnerProfileData(loginData: loginData, userBio: loginData.userData.userBio, userIdentity: loginData.userData.gender ?? "", profileImage: newProfilePic)
                                }, label: {
                                    Text("SAVE")
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(jobsDarkBlue)
                                        .frame(width: UIScreen.screenWidth/1.3)
                                        .padding(.vertical, UIScreen.screenHeight/60)
                                        .background(greenUi)
                                        .cornerRadius(5)
                                        .padding()
                                })
                            }
                        }
                    }
                } else {
                    Spacer()
                    Image("ProfileNotCompletedIllustration")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/1.5)
                    Spacer()
                }
            } else {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            
            loginData.userData = UserDataFromServer(hotelOwnerInfo: HotelOwnerInfo(hotelownerName: "", hotelDescription: "", hotelType: "", hotelCount: "", websiteLink: "", bookingEngineLink: "", hotelownerid: "", hotelInfo: [JSONAny]()), vendorInfo: VendorInfo(vendorImage: "", vendorName: "", vendorDescription: "", websiteLink: "", vendorServices: [JSONAny](), portfolioLink: [JSONAny]()), id: "", fullName: "", email: "", phone: "", profilePic: "", resume: "", mesiboAccount: [MesiboAccount](), interest: [Interest](), verificationStatus: "", userBio: "", createdOn: "", savedPost: [JSONAny](), likedPost: [LikedPost?](), userName: "", dob: "", location: "", profileCompletionStatus: "", role: "", deviceToken: "", studentEducation: [StudentEducation?](), normalUserInfo: [NormalUserInfoProfile?](), hospitalityExpertInfo: [HospitalityExpertInfoProfile?](), displayStatus: "", userID: "", bookmarkjob: [JSONAny](), postCount: [PostCount?](), connections: [Connection?](), pendingRequest: [Connection?](), requests: [Connection?](), v: 0, gender: "")
            
            Task {
                isLoading = false
                let res = await mainUserService.getUserProfile(loginData: loginData, userID: loginData.mainUserID)
                if res == "Success" {
                    isLoading = true
                } else {
                    isLoading = false
                    let res = await mainUserService.getUserProfile(loginData: loginData, userID: loginData.mainUserID)
                    if res == "Success" {
                        isLoading = true
                    } else {
                        isLoading = false
                    }
                }
            }
            
        }
    }
}
