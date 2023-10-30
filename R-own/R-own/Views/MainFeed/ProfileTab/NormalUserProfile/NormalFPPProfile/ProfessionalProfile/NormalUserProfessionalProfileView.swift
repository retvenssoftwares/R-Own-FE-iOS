//
//  NormalUserProfessionalProfileView.swift
//  R-own
//
//  Created by Aman Sharma on 14/07/23.
//

import SwiftUI
import AlertToast

struct NormalUserProfessionalProfileView: View {
    
    @StateObject var loginData: LoginViewModel
    @State var userID: String
    
    @State var role: String
    @State var mainUser: Bool
    
    @StateObject var userService = MainUserService()
    
    @State var openAddHotelierJobBottomSheet: Bool = false
    @State var openAddNormalJobBottomSheet: Bool = false
    @State var openAddEducationBottomSheet: Bool = false
    
    @State var alertProfileNotCompleted: Bool = false
    @State var isLoading: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    //Navbar
                    HStack{
                        //button
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "arrow.backward.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                .foregroundColor(greenUi)
                        })
                        Spacer()
                        //text
                        Text("Professional Profile")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(greenUi)
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .padding(.vertical, UIScreen.screenHeight/70)
                    .background(jobsDarkBlue)
                    .border(width: 1, edges: [.bottom], color: .black)
                }
                if isLoading {
                    ScrollView{
                        VStack{
                            VStack{
                                ProfilePictureView(profilePic: loginData.userData.profilePic, verified: loginData.userData.verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/8, width: UIScreen.screenHeight/8)
                                Text(loginData.userData.fullName)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                if loginData.userData.userName != "" {
                                    Text(loginData.userData.userName)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                        .padding(.vertical, UIScreen.screenHeight/90)
                                        .padding(.horizontal, UIScreen.screenWidth/50)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(lineWidth: 1)
                                                .foregroundColor(.black)
                                        }
                                }
                            }
                            .shadow(color: .black.opacity(0.12), radius: 5, x: 2, y: 2)
                            
                            if loginData.userData.userBio != "" {
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("Bio")
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                        Text(loginData.userData.userBio)
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding(.top, UIScreen.screenHeight/70)
                                    Spacer()
                                }
                            }
                            
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Experience")
                                        .font(.body)
                                        .fontWeight(.regular)
                                    
                                    Spacer()
                                    
                                    if mainUser {
                                        Button(action: {
                                            if loginData.profileCompletionPercentage != "100" {
                                                alertProfileNotCompleted = true
                                            } else {
                                                if loginData.userData.role == "Normal User" {
                                                    openAddNormalJobBottomSheet.toggle()
                                                } else {
                                                    openAddHotelierJobBottomSheet.toggle()
                                                }
                                            }
                                            
                                            
                                        }, label: {
                                            HStack(spacing: 3){
                                                Image(systemName: "plus.circle")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                                    .foregroundColor(.black)
                                                Text("Add New")
                                                    .font(.body)
                                                    .fontWeight(.thin)
                                                    .foregroundColor(.black)
                                            }
                                            .padding(.vertical, UIScreen.screenHeight/100)
                                            .padding(.horizontal, UIScreen.screenWidth/50)
                                            .overlay{
                                                RoundedRectangle(cornerRadius: 15)
                                                    .stroke(lineWidth: 1)
                                                    .foregroundColor(.black)
                                            }
                                        })
                                        .sheet(isPresented: $openAddNormalJobBottomSheet, content: {
                                            ProfessionalProfileAddJobsBottomSheet(loginData: loginData, openAddEducationBottomSheet: $openAddNormalJobBottomSheet, globalVM: globalVM)
                                        })
                                        .sheet(isPresented: $openAddHotelierJobBottomSheet, content: {
                                            ProfessionalProfileAddHotelierJobsBottomSheet(loginData: loginData, openAddEducationBottomSheet: $openAddHotelierJobBottomSheet, globalVM: globalVM)
                                        })
                                    }
                                }
                                if loginData.userData.role == "Normal User" {
                                    if loginData.userData.normalUserInfo.count > 0 {
                                        ForEach(0..<loginData.userData.normalUserInfo.count, id: \.self) { id in
                                            ProfessionalProfileJobsTab(loginData: loginData, id: id, mainUser: mainUser, globalVM: globalVM)
                                        }
                                    }
                                } else {
                                    if loginData.userData.hospitalityExpertInfo.count > 0 {
                                        ForEach(0..<loginData.userData.hospitalityExpertInfo.count, id: \.self) { id in
                                            ProfessionProfileHotelierJobTab(loginData: loginData, id: id, mainUser: mainUser, globalVM: globalVM)
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, UIScreen.screenHeight/70)
                            
                            VStack{
                                HStack{
                                    Text("Education")
                                        .font(.body)
                                        .fontWeight(.regular)
                                    
                                    Spacer()
                                    
                                    if mainUser {
                                        Button(action: {
                                            if loginData.profileCompletionPercentage != "100" {
                                                alertProfileNotCompleted = true
                                            } else {
                                                openAddEducationBottomSheet.toggle()
                                            }
                                        }, label: {
                                            HStack(spacing: 3){
                                                Image(systemName: "plus.circle")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                                    .foregroundColor(.black)
                                                Text("Add New")
                                                    .font(.body)
                                                    .fontWeight(.thin)
                                                    .foregroundColor(.black)
                                            }
                                            .padding(.vertical, UIScreen.screenHeight/100)
                                            .padding(.horizontal, UIScreen.screenWidth/50)
                                            .overlay{
                                                RoundedRectangle(cornerRadius: 15)
                                                    .stroke(lineWidth: 1)
                                                    .foregroundColor(.black)
                                            }
                                        })
                                        .sheet(isPresented: $openAddEducationBottomSheet, content: {
                                            ProfessionalProfileAddEducationBottomSheet(openAddEducationBottomSheet: $openAddEducationBottomSheet, globalVM: globalVM, loginData: loginData)
                                        })
                                    }
                                }
                                if loginData.userData.studentEducation.count > 0 {
                                    ForEach(0..<loginData.userData.studentEducation.count, id: \.self) { id in
                                        ProfessionalProfileEducationTab(loginData: loginData, id: id, mainUser: mainUser, globalVM: globalVM)
                                    }
                                }
                            }
                            .padding(.vertical, UIScreen.screenHeight/70)
                        }
                        .padding(.horizontal, UIScreen.screenWidth/10)
                        .padding(.vertical, UIScreen.screenHeight/50)
                    }
                } else {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
            .toast(isPresenting: $alertProfileNotCompleted, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Complete your profile first")
            }
        }
        .onAppear{
            loginData.showLoader = true
            loginData.userData = UserDataFromServer(hotelOwnerInfo: HotelOwnerInfo(hotelownerName: "", hotelDescription: "", hotelType: "", hotelCount: "", websiteLink: "", bookingEngineLink: "", hotelownerid: "", hotelInfo: [JSONAny]()), vendorInfo: VendorInfo(vendorImage: "", vendorName: "", vendorDescription: "", websiteLink: "", vendorServices: [JSONAny](), portfolioLink: [JSONAny]()), id: "", fullName: "", email: "", phone: "", profilePic: "", resume: "", mesiboAccount: [MesiboAccount](), interest: [Interest](), verificationStatus: "", userBio: "", createdOn: "", savedPost: [JSONAny](), likedPost: [LikedPost?](), userName: "", dob: "", location: "", profileCompletionStatus: "", role: "", deviceToken: "", studentEducation: [StudentEducation?](), normalUserInfo: [NormalUserInfoProfile?](), hospitalityExpertInfo: [HospitalityExpertInfoProfile?](), displayStatus: "", userID: "", bookmarkjob: [JSONAny](), postCount: [PostCount?](), connections: [Connection?](), pendingRequest: [Connection?](), requests: [Connection?](), v: 0, gender: "")
            Task {
                isLoading = false
                let res = await userService.getUserProfile(loginData: loginData, userID: userID)
                if res == "Success" {
                    isLoading = true
                } else {
                    isLoading = false
                    let res = await userService.getUserProfile(loginData: loginData, userID: userID)
                    if res == "Success" {
                        isLoading = true
                    } else {
                        isLoading = false
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct NormalUserProfessionalProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalUserProfessionalProfileView()
//    }
//}
