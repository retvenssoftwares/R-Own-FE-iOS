//
//  HotelOwnerFPPViewFirstHalf.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import SwiftUI

struct HotelOwnerFPPViewFirstHalf: View {
    
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
    @State var navigateTOCHatView: Bool = false
    
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                if mainUser {
                    ProfileNavbarView(loginData: loginData, globalVM: globalVM, navigateToBottomSheet: $profileVM.showHotelOwnerProfileEditBottomSheet, role: "Hotel Owner", mprofile: mainUser ? "mainUser" : "")
                        .padding(.top, UIScreen.screenHeight/30)
                } else {
                    ProfileNavbarView(loginData: loginData, globalVM: globalVM, navigateToBottomSheet: $profileVM.showHotelOwnerProfileEditBottomSheet, role: "Hotel Owner", mprofile: mainUser ? "mainUser" : "")
                        .padding(.top, UIScreen.screenHeight/70)
                }
                VStack(alignment: .leading){
                    HStack{
                        if globalVM.getHotelOwnerProfileHeader.profile.verificationStatus == "true" {
                            ProfilePictureView(profilePic: mainUser ? loginData.mainUserProfilePic : globalVM.getHotelOwnerProfileHeader.profiledata.profilePic , verified: true , height: UIScreen.screenHeight/10, width: UIScreen.screenHeight/10)
                                .onLongPressGesture(perform: {
                                    loginData.selectedProfilePicMax = mainUser ? loginData.mainUserProfilePic : globalVM.getHotelOwnerProfileHeader.profiledata.profilePic
                                    print("showing profile max")
                                    loginData.showProfileMax = true
                                })
                        } else if globalVM.getHotelOwnerProfileHeader.profile.verificationStatus == "false" {
                            ProfilePictureView(profilePic: mainUser ? loginData.mainUserProfilePic : globalVM.getHotelOwnerProfileHeader.profiledata.profilePic , verified: false , height: UIScreen.screenHeight/10, width: UIScreen.screenHeight/10)
                                .onLongPressGesture(perform: {
                                    loginData.selectedProfilePicMax = mainUser ? loginData.mainUserProfilePic : globalVM.getHotelOwnerProfileHeader.profiledata.profilePic
                                    print("showing profile max")
                                    loginData.showProfileMax = true
                                })
                        }
                        
                        Spacer()
                        
                        VStack{
                            Text(String(globalVM.getHotelOwnerProfileHeader.postCount))
                                .font(.footnote)
                                .fontWeight(.bold)
                            
                            Text("Posts")
                                .font(.footnote)
                                .fontWeight(.regular)
                        }
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        
                        Spacer()
                        
                        VStack{
                            Text(String(globalVM.getHotelOwnerProfileHeader.connectionCount))
                                .font(.footnote)
                                .fontWeight(.bold)
                            Text("Connections")
                                .font(.footnote)
                                .fontWeight(.regular)
                        }
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        .onTapGesture {
                            if globalVM.getHotelOwnerProfileHeader.connectionStatus == "Connected" || mainUser {
                                print("showing connections list")
                                navigateToConnectionString.toggle()
                            }
                        }
                        .navigationDestination(isPresented: $navigateToConnectionString, destination: {
                            ConnectionsProfileListView(connectionOwnerName: mainUser ? "My" : globalVM.getHotelOwnerProfileHeader.profiledata.fullName, loginData: loginData, globalVM: globalVM, mainUser: mainUser, profileVM: profileVM, mesiboVM: mesiboVM)
                        })
                        
                        Spacer()
                        
                        if mainUser{
                            VStack{
                                Text(String(globalVM.getHotelOwnerProfileHeader.requestsCount))
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                Text("Request")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                            }
                            .padding(.horizontal, UIScreen.screenWidth/40)
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
                        VStack(alignment: .leading, spacing: 4){
                            VStack(alignment: .leading){
                                VStack(alignment: .leading){
                                    Text(globalVM.getHotelOwnerProfileHeader.profiledata.fullName)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Hotel Owner")
                                        .font(.body)
                                        .fontWeight(.light)
                                }
                                .padding(.vertical, UIScreen.screenHeight/80)
                                
                                if globalVM.getHotelOwnerProfileHeader.profiledata.userBio != "" {
                                    Text(globalVM.getHotelOwnerProfileHeader.profiledata.userBio)
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .multilineTextAlignment(.leading)
                                }
                                
                            }
                            if globalVM.getHotelOwnerProfileHeader.profile.hotelOwnerInfo.websiteLink != "" {
                                HStack(spacing: 2){
                                    Text("Check us out: ")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                    Text(globalVM.getHotelOwnerProfileHeader.profile.hotelOwnerInfo.websiteLink)
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, UIScreen.screenWidth/10)
                
                VStack{
                    
                    if !mainUser{
                        HStack{
                            Spacer()
                            
                            if globalVM.getHotelOwnerProfileHeader.connectionStatus == "Connected"{
                                Button(action: {
                                    profileService.removeConnection(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                    globalVM.getHotelOwnerProfileHeader.connectionStatus = "Not connected"
                                }, label: {
                                    Text("REMOVE")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .foregroundColor(jobsDarkBlue)
                                        .background(greenUi)
                                        .cornerRadius(10)
                                        .padding()
                                })
                            } else if globalVM.getHotelOwnerProfileHeader.connectionStatus == "Not connected"{
                                Button(action: {
                                    profileService.sendRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                    globalVM.getHotelOwnerProfileHeader.connectionStatus = "Requested"
                                }, label: {
                                    Text("CONNECT")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .foregroundColor(jobsDarkBlue)
                                        .background(greenUi)
                                        .cornerRadius(10)
                                        .padding()
                                })
                            } else if globalVM.getHotelOwnerProfileHeader.connectionStatus == "Requested"{
                                Button(action: {
                                    Task {
                                        let res = await profileService.cancelRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                        globalVM.getHotelOwnerProfileHeader.connectionStatus = "Not connected"
                                    }
                                }, label: {
                                    Text("Requested")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(greenUi)
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .foregroundColor(jobsDarkBlue)
                                        .background(greenUi)
                                        .cornerRadius(10)
                                        .padding()
                                })
                            } else if globalVM.getHotelOwnerProfileHeader.connectionStatus == "Confirm request"{
                                Button(action: {
                                    Task {
                                        let res = await profileService.acceptRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                        globalVM.getHotelOwnerProfileHeader.connectionStatus = "Connected"
                                    }
                                }, label: {
                                    Text("Confirm Request")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .foregroundColor(jobsDarkBlue)
                                        .background(greenUi)
                                        .cornerRadius(10)
                                        .padding()
                                })
                            }
                            
                            
                            Spacer()
                            
                            if globalVM.getHotelOwnerProfileHeader.connectionStatus == "Connected"{
                                Button(action: {
                                    navigateTOCHatView.toggle()
                                }, label: {
                                    Text("INTERACT")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/100)
                                        .foregroundColor(jobsDarkBlue)
                                        .background(greenUi)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 1)
                                        }
                                })
                                .navigationDestination(isPresented: $navigateTOCHatView, destination: {
                                    MessageView(loginData: loginData, mesiboAddress: globalVM.getHotelOwnerProfileHeader.profiledata.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                                })
                                Spacer()
                            }
                            
                            //                                Button(action: {
                            //                                    navigateToVendorBrand.toggle()
                            //                                }, label: {
                            //                                    Text("VENDOR'S BRAND")
                            //                                        .font(.system(size: UIScreen.screenHeight/70))
                            //                                        .fontWeight(.thin)
                            //                                        .foregroundColor(.black)
                            //                                        .padding(.horizontal, UIScreen.screenWidth/20)
                            //                                        .padding(.vertical, UIScreen.screenHeight/100)
                            //                                        .overlay{
                            //                                            RoundedRectangle(cornerRadius: 10)
                            //                                                .stroke(Color.black, lineWidth: 1)
                            //                                        }
                            //                                })
                            //                                .navigationDestination(isPresented: $navigateToVendorBrand, destination: {
                            //                                    BrandProfileView(loginData: loginData, globalVM: globalVM, userID: userID, profileVM: profileVM, mesiboVM: mesiboVM, mainUserCheck: true)
                            //                                })
                        }
                    }
                }
            }
        }
        .onAppear{
        }
    }
}
//
//struct HotelOwnerFPPViewFirstHalf_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelOwnerFPPViewFirstHalf()
//    }
//}
