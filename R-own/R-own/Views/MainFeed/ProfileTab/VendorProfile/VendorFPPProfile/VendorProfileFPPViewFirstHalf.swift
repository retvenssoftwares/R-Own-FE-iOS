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
                        .padding(.top, UIScreen.screenHeight/30)
                } else {
                    ProfileNavbarView(loginData: loginData, globalVM: globalVM, navigateToBottomSheet: $profileVM.showVendorProfileEditBottomSheet, role: "Business Vendor / Freelancer", mprofile: mainUser ? "mainUser" : "")
                        .padding(.top, UIScreen.screenHeight/70)
                }
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
                                navigateToConnectionString.toggle()
                            }
                        }
                        .navigationDestination(isPresented: $navigateToConnectionString, destination: {
                            ConnectionsProfileListView(connectionOwnerName: mainUser ? "My" : globalVM.getVendorProfileHeader.roleDetails.fullName, loginData: loginData, globalVM: globalVM, mainUser: mainUser, profileVM: profileVM, mesiboVM: mesiboVM)
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
                                    .padding(.vertical, UIScreen.screenHeight/70)
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
                                .padding(.bottom, UIScreen.screenHeight/80)
                            }
                            
                            Spacer()
                            VStack{
                                HStack{
                                    
                                    Spacer()
                                    if !mainUser{
                                        if globalVM.getVendorProfileHeader.connectionStatus == "Connected"{
                                            
                                            Button(action: {
                                                profileService.removeConnection(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                                globalVM.getVendorProfileHeader.connectionStatus = "Not Connected"
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
                                            
                                            Spacer()
                                        } else if globalVM.getVendorProfileHeader.connectionStatus == "Not connected"{
                                            Button(action: {
                                                profileService.sendRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: userID)
                                                globalVM.getVendorProfileHeader.connectionStatus = "Requested"
                                            }, label: {
                                                Text("CONNECT")
                                                    .font(.body)
                                                    .fontWeight(.semibold)
                                                    .padding(.horizontal, UIScreen.screenWidth/20)
                                                    .padding(.vertical, UIScreen.screenHeight/100)
                                                    .foregroundColor(jobsDarkBlue)
                                                    .background(greenUi)
                                                    .background(jobsDarkBlue)
                                                    .cornerRadius(10)
                                                    .padding()
                                            })
                                            Spacer()
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
                                                    .padding(.horizontal, UIScreen.screenWidth/20)
                                                    .padding(.vertical, UIScreen.screenHeight/100)
                                                    .foregroundColor(jobsDarkBlue)
                                                    .background(greenUi)
                                                    .cornerRadius(10)
                                                    .padding()
                                            })
                                            Spacer()
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
                                                    .padding(.horizontal, UIScreen.screenWidth/20)
                                                    .padding(.vertical, UIScreen.screenHeight/100)
                                                    .foregroundColor(jobsDarkBlue)
                                                    .background(greenUi)
                                                    .cornerRadius(10)
                                                    .padding()
                                            })
                                            Spacer()
                                        }
                                        
                                        
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
                                            if globalVM.getVendorProfileHeader.roleDetails.mesiboAccount.count > 0 {
                                                MessageView(loginData: loginData, mesiboAddress: globalVM.getVendorProfileHeader.roleDetails.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                                            }
                                        })
                                        
                                    }
                                    
                                    
                                    Spacer()
                                    
                                }
                                
                                HStack{
                                    Spacer()
                                    
                                    Button(action: {
                                        navigateToVendorBrand.toggle()
                                    }, label: {
                                        Text("VENDOR'S BRAND")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(jobsDarkBlue)
                                            .frame(width: UIScreen.screenWidth/1.2)
                                            .padding(.vertical, UIScreen.screenHeight/100)
                                            .overlay{
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.black, lineWidth: 1)
                                            }
                                    })
                                    .navigationDestination(isPresented: $navigateToVendorBrand, destination: {
                                        BrandProfileView(loginData: loginData, globalVM: globalVM, userID: userID, profileVM: profileVM, mesiboVM: mesiboVM, mainUser: mainUser)
                                    })
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, UIScreen.screenWidth/10)
                
            }
            .padding(.leading, UIScreen.screenWidth/20)
        }
    }
}

//struct VendorProfileFPPViewFirstHalf_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorProfileFPPViewFirstHalf()
//    }
//}
