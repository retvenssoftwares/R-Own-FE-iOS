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
    
    @Binding var islaodingData: Bool
    
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                if mainUser {
                    ProfileNavbarView(loginData: loginData, globalVM: globalVM, navigateToBottomSheet: $profileVM.showNormalProfileEditBottomSheet, role: role, mprofile: mainUser ? "mainUser" : "")
                } else {
                    ProfileNavbarView(loginData: loginData, globalVM: globalVM, navigateToBottomSheet: $profileVM.showNormalProfileEditBottomSheet, role: role, mprofile: mainUser ? "mainUser" : "")
                }
                VStack(alignment: .leading){
                    HStack{
                        ProfilePictureView(profilePic: mainUser ? loginData.mainUserProfilePic : globalVM.getNormalProfileHeader.data.profile.profilePic , verified: mainUser ? (loginData.mainUserVerificationStatus == "true" ? true : false) : (globalVM.getNormalProfileHeader.data.profile.verificationStatus == "true" ? true : false) , height: UIScreen.screenHeight/10, width: UIScreen.screenHeight/10)
                            .onLongPressGesture(perform: {
                                if globalVM.getNormalProfileHeader.data.profile.profilePic != ""{
                                    loginData.selectedProfilePicMax = mainUser ? loginData.mainUserProfilePic : globalVM.getNormalProfileHeader.data.profile.profilePic
                                    print("showing profile max")
                                    loginData.showProfileMax = true
                                }
                            })
                        
                        Spacer()
                        
                        VStack{
                            Text(String(globalVM.getNormalProfileHeader.data.postCountLength))
                                .font(.footnote)
                                .fontWeight(.bold)
                            
                            Text("Posts")
                                .font(.footnote)
                                .fontWeight(.regular)
                        }
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        
                        Spacer()
                        
                        NavigationLink(isActive: $navigateToConnectionString, destination: {
                            ConnectionsProfileListView(connectionOwnerName: mainUser ? "My" : globalVM.getNormalProfileHeader.data.profile.fullName, loginData: loginData, globalVM: globalVM, mainUser: mainUser, profileVM: profileVM, mesiboVM: mesiboVM)
                        }, label: {Text("")})
                        VStack{
                            Text(String(globalVM.getNormalProfileHeader.data.connCountLength))
                                .font(.footnote)
                                .fontWeight(.bold)
                            Text("Connections")
                                .font(.footnote)
                                .fontWeight(.regular)
                        }
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        .onTapGesture {
                            if globalVM.getNormalProfileHeader.data.connectionStatus == "Connected" || mainUser {
                                print("showing connections list")
                                navigateToConnectionString = true
                            }
                        }
                        .navigationDestination(isPresented: $navigateToConnectionString, destination: {
                            ConnectionsProfileListView(connectionOwnerName: mainUser ? "My" : globalVM.getNormalProfileHeader.data.profile.fullName, loginData: loginData, globalVM: globalVM, mainUser: mainUser, profileVM: profileVM, mesiboVM: mesiboVM)
                        })
                        
                        Spacer()
                        
                        if mainUser{
                            NavigationLink(isActive: $navigateToRequestString, destination: {
                                RequestProfileListView(loginData: loginData, globalVM: globalVM, mainUser: mainUser, profileVM: profileVM, mesiboVM: mesiboVM)
                            }, label: {Text("")})
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
                                navigateToRequestString = true
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
                .padding(.horizontal, UIScreen.screenWidth/30)
                
                VStack{
                    
                    if !mainUser{
                        HStack{
                            
                            if globalVM.getNormalProfileHeader.data.connectionStatus == "Connected"{
                                Button(action: {
                                    profileService.removeConnection(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                    globalVM.getNormalProfileHeader.data.connectionStatus = "Not connected"
                                }, label: {
                                    Text("REMOVE")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .frame(maxWidth: UIScreen.screenWidth)
                                        .foregroundColor(greenUi)
                                        .background(jobsDarkBlue)
                                        .cornerRadius(8)
                                })
                            } else if globalVM.getNormalProfileHeader.data.connectionStatus == "Not connected"{
                                Button(action: {
                                    profileService.sendRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                    globalVM.getNormalProfileHeader.data.connectionStatus = "Requested"
                                }, label: {
                                    Text("CONNECT")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .frame(maxWidth: UIScreen.screenWidth)
                                        .foregroundColor(greenUi)
                                        .background(jobsDarkBlue)
                                        .cornerRadius(8)
                                })
                            } else if globalVM.getNormalProfileHeader.data.connectionStatus == "Requested"{
                                Button(action: {
                                    Task {
                                        islaodingData = true
                                        let res = await profileService.cancelRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                        if res == "Success"{
                                            globalVM.getNormalProfileHeader.data.connectionStatus = "Not connected"
                                            islaodingData = true
                                        } else {
                                            islaodingData = true
                                        }
                                    }
                                }, label: {
                                    Text("REQUESTED")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .frame(maxWidth: UIScreen.screenWidth)
                                        .foregroundColor(greenUi)
                                        .background(jobsDarkBlue)
                                        .cornerRadius(8)
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
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .frame(maxWidth: UIScreen.screenWidth)
                                        .foregroundColor(greenUi)
                                        .background(jobsDarkBlue)
                                        .cornerRadius(8)
                                })
                            }
                            
                            
                            
                            if globalVM.getNormalProfileHeader.data.connectionStatus == "Connected"{
                                
                                NavigationLink(isActive: $navigateTOCHatView, destination: {
                                    MessageView(loginData: loginData, mesiboAddress: globalVM.getNormalProfileHeader.data.profile.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                                }, label: {Text("")})
                                
                                Button(action: {
                                    navigateTOCHatView = true
                                }, label: {
                                    Text("INTERACT")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .frame(maxWidth: UIScreen.screenWidth)
                                        .foregroundColor(greenUi)
                                        .background(jobsDarkBlue)
                                        .cornerRadius(8)
                                })
                                .navigationDestination(isPresented: $navigateTOCHatView, destination: {
                                    if globalVM.getNormalProfileHeader.data.profile.mesiboAccount.count > 0 {
                                        MessageView(loginData: loginData, mesiboAddress: globalVM.getNormalProfileHeader.data.profile.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                                    }
                                })
                                NavigationLink(isActive: $navigateTOCHatView, destination: {
                                    MessageView(loginData: loginData, mesiboAddress: globalVM.getNormalProfileHeader.data.profile.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                                }, label: {
                                    Text("")
                                })
                            }
                            if globalVM.getNormalProfileHeader.data.connectionStatus != "Connected" {
                                Text("PROFESSIONAL PROFILE")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .padding(.vertical, UIScreen.screenHeight/100)
                                    .frame(maxWidth: UIScreen.screenWidth)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.black, lineWidth: 1)
                                    }
                                    .onTapGesture {
                                        navigateToProfessionalProfile1 = true
                                    }
                            }
                            
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    }
                    
                        
                    if mainUser || globalVM.getNormalProfileHeader.data.connectionStatus == "Connected"{
                        
                        HStack{
                            
                            Text("PROFESSIONAL PROFILE")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .padding(.vertical, UIScreen.screenHeight/100)
                                .frame(maxWidth: UIScreen.screenWidth)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1)
                                }
                                .onTapGesture {
                                    navigateToProfessionalProfile1 = true
                                }
                            
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .padding(.vertical, UIScreen.screenHeight/110)
                    }
                    NavigationLink(isActive: $navigateToProfessionalProfile1, destination: {
                        NormalUserProfessionalProfileView(loginData: loginData, userID: userID, role: role, mainUser: mainUser, globalVM: globalVM)
                    }, label: {
                        Text("")
                    })
                }
            }
        }
        .onAppear{
            navigateTOCHatView = false
            navigateToRequestString = false
            navigateToConnectionString = false
            navigateToProfessionalProfile1 = false
            navigateToProfessionalProfile2 = false
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
