//
//  VendorProfileFPPViewFirstHalf.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import SwiftUI

struct VendorProfileFPPViewFirstHalf: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM:  ProfileViewModel
    @StateObject var globalVM:  GlobalViewModel
    @State var role: String
    @State var mainUser: Bool
    @State var userID: String
    
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var profileService = ProfileService()
    
    @State var navigateToConnectionString: Bool = false
    @State var navigateToRequestString: Bool = false
    @State var navigateToVendorBrand: Bool = false
    @State var navigateTOCHatView: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                if mainUser {
                    ProfileNavbarView(loginData: loginData, globalVM: globalVM, navigateToBottomSheet: $profileVM.showVendorProfileEditBottomSheet, role: "Business Vendor / Freelancer", mprofile: mainUser ? "mainUser" : "")
                } else {
                    ProfileNavbarView(loginData: loginData, globalVM: globalVM, navigateToBottomSheet: $profileVM.showVendorProfileEditBottomSheet, role: "Business Vendor / Freelancer", mprofile: mainUser ? "mainUser" : "")
                }
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        HStack{
                            
                            ProfilePictureView(profilePic: mainUser ? loginData.mainUserProfilePic : globalVM.getVendorProfileHeader.roleDetails.profilePic, verified: globalVM.getVendorProfileHeader.roleDetails.verificationStatus == "true" ? true : false , height: UIScreen.screenHeight/10, width: UIScreen.screenHeight/10)
                                .onLongPressGesture(perform: {
                                    loginData.showProfileMax = true
                                    loginData.selectedProfilePicMax = mainUser ? loginData.mainUserProfilePic : globalVM.getVendorProfileHeader.roleDetails.profilePic
                                    print("showing profile max")
                                })
                            
                            Spacer()
                            
                            VStack{
                                Text(String(globalVM.getVendorProfileHeader.postcount))
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                
                                Text("Posts")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                            }
                            .padding(.horizontal, UIScreen.screenWidth/40)
                            
                            Spacer()
                            
                            
                            VStack{
                                Text(String(globalVM.getVendorProfileHeader.connectioncount))
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                Text("Connections")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                            }
                            .onTapGesture {
                                if globalVM.getVendorProfileHeader.connectionStatus == "Connected" || mainUser {
                                    print("showing connections list")
                                    navigateToConnectionString = true
                                }
                            }
                            .navigationDestination(isPresented: $navigateToConnectionString, destination: {
                                ConnectionsProfileListView(connectionOwnerName: mainUser ? "My" : globalVM.getVendorProfileHeader.roleDetails.fullName, loginData: loginData, globalVM: globalVM, mainUser: mainUser, profileVM: profileVM, mesiboVM: mesiboVM)
                            })
                            NavigationLink(isActive: $navigateToConnectionString, destination: {
                                ConnectionsProfileListView(connectionOwnerName: mainUser ? "My" : globalVM.getVendorProfileHeader.roleDetails.fullName, loginData: loginData, globalVM: globalVM, mainUser: mainUser, profileVM: profileVM, mesiboVM: mesiboVM)
                            }, label: {
                                Text("")
                            })
                            
                            Spacer()
                            if mainUser{
                                VStack{
                                    Text(String(globalVM.getVendorProfileHeader.requestcount))
                                        .font(.footnote)
                                        .fontWeight(.bold)
                                    Text("Request")
                                        .font(.footnote)
                                        .fontWeight(.regular)
                                }
                                .padding(.horizontal, UIScreen.screenWidth/40)
                                .onTapGesture {
                                    print("showing request list")
                                    navigateToRequestString = true
                                }
                                .navigationDestination(isPresented: $navigateToRequestString, destination: {
                                    RequestProfileListView(loginData: loginData, globalVM: globalVM, mainUser: mainUser, profileVM: profileVM, mesiboVM: mesiboVM)
                                })
                                NavigationLink(isActive: $navigateToRequestString, destination: {
                                    RequestProfileListView(loginData: loginData, globalVM: globalVM, mainUser: mainUser, profileVM: profileVM, mesiboVM: mesiboVM)
                                }, label: {
                                    Text("")
                                })
                                Spacer()
                            }
                        }
                        HStack{
                            VStack(alignment: .leading){
                                VStack(alignment: .leading){
                                    Text(globalVM.getVendorProfileHeader.roleDetails.fullName)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Vendor")
                                        .font(.body)
                                        .fontWeight(.light)
                                }
                                .padding(.top, UIScreen.screenHeight/60)
                                
                                if globalVM.getVendorProfileHeader.roleDetails.userBio != "" {
                                    Text(globalVM.getVendorProfileHeader.roleDetails.userBio)
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .multilineTextAlignment(.leading)
                                }
                                if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.websiteLink != "" {
                                    HStack(spacing: 2){
                                        Text("Check us out: ")
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.leading)
                                        Text(globalVM.getVendorProfileHeader.roleDetails.vendorInfo.websiteLink)
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(.horizontal, UIScreen.screenWidth/30)
                    
                    VStack(alignment: .leading){
                        HStack{
                            
                            if !mainUser{
                                if globalVM.getVendorProfileHeader.connectionStatus == "Connected"{
                                    
                                    Button(action: {
                                        profileService.removeConnection(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                        globalVM.getVendorProfileHeader.connectionStatus = "Not Connected"
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
                                    
                                } else if globalVM.getVendorProfileHeader.connectionStatus == "Not connected"{
                                    Button(action: {
                                        profileService.sendRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                        globalVM.getVendorProfileHeader.connectionStatus = "Requested"
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
                                } else if globalVM.getVendorProfileHeader.connectionStatus == "Requested"{
                                    Button(action: {
                                        Task {
                                            let res = await profileService.cancelRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                            globalVM.getVendorProfileHeader.connectionStatus = "Not Connected"
                                        }
                                    }, label: {
                                        Text("Requested")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(greenUi)
                                            .padding(.vertical, UIScreen.screenHeight/100)
                                            .frame(maxWidth: UIScreen.screenWidth)
                                            .foregroundColor(greenUi)
                                            .background(jobsDarkBlue)
                                            .cornerRadius(8)
                                    })
                                } else if globalVM.getVendorProfileHeader.connectionStatus == "Confirm request"{
                                    Button(action: {
                                        Task {
                                            let res = await profileService.acceptRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                            globalVM.getVendorProfileHeader.connectionStatus = "Connected"
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
                                
                                if globalVM.getVendorProfileHeader.roleDetails.mesiboAccount.count != 0 {
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
                                        if globalVM.getVendorProfileHeader.roleDetails.mesiboAccount.count > 0 {
                                            MessageView(loginData: loginData, mesiboAddress: globalVM.getVendorProfileHeader.roleDetails.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                                        }
                                    })
                                    NavigationLink(isActive: $navigateTOCHatView, destination: {
                                        MessageView(loginData: loginData, mesiboAddress: globalVM.getVendorProfileHeader.roleDetails.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                                    }, label: {
                                        Text("")
                                    })
                                }
                                
                            }
                            
                            
                            Spacer()
                            
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        
                        HStack{
                            
                            Button(action: {
                                navigateToVendorBrand = true
                            }, label: {
                                Text("VENDOR'S BRAND")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(jobsDarkBlue)
                                    .padding(.vertical, UIScreen.screenHeight/100)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.black, lineWidth: 1)
                                            .frame(minWidth: (UIScreen.screenWidth - UIScreen.screenWidth/15))
                                    }
                                    .frame(maxWidth: (UIScreen.screenWidth - UIScreen.screenWidth/15))
                                    
                            })
                            .navigationDestination(isPresented: $navigateToVendorBrand, destination: {
                                BrandProfileView(loginData: loginData, globalVM: globalVM, userID: userID, profileVM: profileVM, mesiboVM: mesiboVM, mainUser: mainUser)
                            })
                            NavigationLink(isActive: $navigateToVendorBrand, destination: {
                                BrandProfileView(loginData: loginData, globalVM: globalVM, userID: userID, profileVM: profileVM, mesiboVM: mesiboVM, mainUser: mainUser)
                            }, label: {
                                Text("")
                            })
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .padding(.vertical, UIScreen.screenHeight/110)
                    }
                }
                
            }
        }
        .onAppear{
            navigateToConnectionString = false
            navigateToRequestString = false
            navigateToVendorBrand = false
            navigateTOCHatView = false
        }
    }
}

//struct VendorProfileFPPViewFirstHalf_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorProfileFPPViewFirstHalf()
//    }
//}
