//
//  NormalProfileFPPViewFirstHalf.swift
//  R-own
//
//  Created by Aman Sharma on 16/05/23.
//

import SwiftUI

struct NormalProfileFPPViewFirstHalf: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM:  ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var role: String
    @State var mainUser: Bool
    @State var userID: String
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var profileService = ProfileService()
    
//    @State var profilePic: String
//    @State var postCount: String
//    @State var connectionCount: String
//    @State var requestCount: String
    
    @State var navigateToConnectionString: Bool = false
    @State var navigateToRequestString: Bool = false
    @State var navigateToProfessionalProfile1: Bool = false
    @State var navigateToProfessionalProfile2: Bool = false
    @State var navigateTOCHatView: Bool = false
    
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                if mainUser {
                    ProfileNavbarView(loginData: loginData, globalVM: globalVM, navigateToBottomSheet: $profileVM.showNormalProfileEditBottomSheet, role: role, mprofile: mainUser ? "mainUser" : "")
                        .padding(.top, UIScreen.screenHeight/30)
                } else {
                    ProfileNavbarView(loginData: loginData, globalVM: globalVM, navigateToBottomSheet: $profileVM.showNormalProfileEditBottomSheet, role: role, mprofile: mainUser ? "mainUser" : "")
                        .padding(.top, UIScreen.screenHeight/70)
                }
                VStack(alignment: .leading){
                    HStack{
                        if globalVM.getNormalProfileHeader.data.profile.verificationStatus == "true" {
                            ProfilePictureView(profilePic: mainUser ? loginData.mainUserProfilePic : globalVM.getNormalProfileHeader.data.profile.profilePic , verified: true , height: UIScreen.screenHeight/10, width: UIScreen.screenHeight/10)
                                .onLongPressGesture(perform: {
                                    if globalVM.getNormalProfileHeader.data.profile.profilePic != ""{
                                        loginData.selectedProfilePicMax = mainUser ? loginData.mainUserProfilePic : globalVM.getNormalProfileHeader.data.profile.profilePic
                                        print("showing profile max")
                                        loginData.showProfileMax = true
                                    }
                                })
                        } else if globalVM.getNormalProfileHeader.data.profile.verificationStatus == "false" {
                            ProfilePictureView(profilePic: mainUser ? loginData.mainUserProfilePic : globalVM.getNormalProfileHeader.data.profile.profilePic , verified: false , height: UIScreen.screenHeight/10, width: UIScreen.screenHeight/10)
                                .shadow(color: .black.opacity(0.12), radius: 2, x:2)
                                .onLongPressGesture(perform: {
                                    loginData.selectedProfilePicMax = mainUser ? loginData.mainUserProfilePic : globalVM.getNormalProfileHeader.data.profile.profilePic
                                    print("showing profile max")
                                    loginData.showProfileMax = true
                                })
                        }
                        
                        Spacer()
                        
                        VStack{
                            Text(String(globalVM.getNormalProfileHeader.data.postCountLength))
                                .font(.footnote)
                                .fontWeight(.bold)
                            
                            Text("Posts")
                                .font(.footnote)
                                .fontWeight(.regular)
                        }
                        
                        Spacer()
                        
                        VStack{
                            Text(String(globalVM.getNormalProfileHeader.data.connCountLength))
                                .font(.footnote)
                                .fontWeight(.bold)
                            Text("Connections")
                                .font(.footnote)
                                .fontWeight(.regular)
                        }
                        .onTapGesture {
                            if globalVM.getNormalProfileHeader.data.connectionStatus == "Connected" || mainUser {
                                print("showing connections list")
                                navigateToConnectionString.toggle()
                            }
                        }
                        .navigationDestination(isPresented: $navigateToConnectionString, destination: {
                            ConnectionsProfileListView(connectionOwnerName: mainUser ? "My" : globalVM.getNormalProfileHeader.data.profile.fullName, loginData: loginData, globalVM: globalVM, mainUser: mainUser, profileVM: profileVM, mesiboVM: mesiboVM)
                        })
                        
                        Spacer()
                        
                        if mainUser{
                            VStack{
                                Text(String(globalVM.getNormalProfileHeader.data.reqsCountLength))
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                Text("Request")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                            }
                            .onTapGesture {
                                print("showing request list")
                                navigateToRequestString.toggle()
                            }
                            .navigationDestination(isPresented: $navigateToRequestString, destination: {
                                RequestProfileListView(loginData: loginData, globalVM: globalVM, mainUser: mainUser, profileVM: profileVM, mesiboVM: mesiboVM)
                            })
                            Spacer()
                        }
                    }
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0){
                            VStack(alignment: .leading, spacing: 2){
                                Text(globalVM.getNormalProfileHeader.data.profile.fullName)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                if globalVM.getNormalProfileHeader.data.profile.normalUserInfo.count > 0 {
                                    Text(globalVM.getNormalProfileHeader.data.profile.normalUserInfo[0].jobTitle)
                                        .font(.body)
                                        .fontWeight(.light)
                                } else {
                                    Text(role)
                                        .font(.body)
                                        .fontWeight(.light)
                                }
                            }
                            .padding(.vertical, UIScreen.screenHeight/60)
                            
                            if globalVM.getNormalProfileHeader.data.profile.userBio != "" {
                                Text(globalVM.getNormalProfileHeader.data.profile.userBio)
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
                .padding(.horizontal, UIScreen.screenWidth/10)
                
                VStack{
                    
                    if !mainUser{
                        HStack{
                            Spacer()
                            
                            if globalVM.getNormalProfileHeader.data.connectionStatus == "Connected"{
                                Button(action: {
                                    profileService.removeConnection(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                    globalVM.getNormalProfileHeader.data.connectionStatus = "Not connected"
                                }, label: {
                                    Text("REMOVE")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .foregroundColor(greenUi)
                                        .background(jobsDarkBlue)
                                        .cornerRadius(10)
                                        .padding()
                                })
                            } else if globalVM.getNormalProfileHeader.data.connectionStatus == "Not connected"{
                                Button(action: {
                                    profileService.sendRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                    globalVM.getNormalProfileHeader.data.connectionStatus = "Requested"
                                }, label: {
                                    Text("CONNECT")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .foregroundColor(greenUi)
                                        .background(jobsDarkBlue)
                                        .cornerRadius(10)
                                        .padding()
                                })
                            } else if globalVM.getNormalProfileHeader.data.connectionStatus == "Requested"{
                                Button(action: {
                                    Task {
                                        let res = await profileService.cancelRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                        globalVM.getNormalProfileHeader.data.connectionStatus = "Not connected"
                                    }
                                }, label: {
                                    Text("REQUESTED")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .foregroundColor(greenUi)
                                        .background(jobsDarkBlue)
                                        .cornerRadius(10)
                                        .padding()
                                })
                            } else if globalVM.getNormalProfileHeader.data.connectionStatus == "Confirm request"{
                                Button(action: {
                                    Task {
                                        let res = await profileService.acceptRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                        globalVM.getNormalProfileHeader.data.connectionStatus = "Connected"
                                    }
                                }, label: {
                                    Text("CONFIRM REQUEST")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .foregroundColor(greenUi)
                                        .background(jobsDarkBlue)
                                        .cornerRadius(10)
                                        .padding()
                                })
                            }
                            
                            
                            Spacer()
                            
                            if globalVM.getNormalProfileHeader.data.connectionStatus == "Connected"{
                                Button(action: {
                                    navigateTOCHatView.toggle()
                                }, label: {
                                    Text("INTERACT")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .foregroundColor(greenUi)
                                        .background(jobsDarkBlue)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 1)
                                        }
                                })
                                .navigationDestination(isPresented: $navigateTOCHatView, destination: {
                                    if globalVM.getNormalProfileHeader.data.profile.mesiboAccount.count > 0 {
                                        MessageView(loginData: loginData, mesiboAddress: globalVM.getNormalProfileHeader.data.profile.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                                    }
                                })
                                Spacer()
                            }
                            if globalVM.getNormalProfileHeader.data.connectionStatus != "Connected" {
                                NavigationLink(destination: {
                                    NormalUserProfessionalProfileView(loginData: loginData, userID: userID, role: role, mainUser: mainUser, globalVM: globalVM)
                                }, label: {
                                    Text("PROFESSIONAL PROFILE")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 1)
                                        }
                                })
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .padding(.bottom, UIScreen.screenHeight/60)
                    }
                    
                        
                    if mainUser || globalVM.getNormalProfileHeader.data.connectionStatus == "Connected"{
                        
                        HStack{
                            Spacer()
                            
                            NavigationLink(destination: {
                                NormalUserProfessionalProfileView(loginData: loginData, userID: userID, role: role, mainUser: mainUser, globalVM: globalVM)
                            }, label: {
                                Text("PROFESSIONAL PROFILE")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, UIScreen.screenWidth/20)
                                    .padding(.vertical, UIScreen.screenHeight/100)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 1)
                                    }
                            })
                            
                            Spacer()
                        }
                    }
                }
            }
        }
        .onAppear{
            print(loginData.mainUserProfilePic)
            print(profileVM.showNormalProfileEditBottomSheet)
        }
    }
}

//struct NormalProfileFPPViewFirstHalf_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileFPPViewFirstHalf()
//    }
//}
