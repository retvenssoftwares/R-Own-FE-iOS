//
//  NewConnectionUsersTab.swift
//  R-own
//
//  Created by Aman Sharma on 13/07/23.
//

import SwiftUI

struct NewConnectionUsersTab: View {
    
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @State var user: MatchedContact
    
    
    
    @StateObject var exploreService = ExploreService()
    @StateObject var profileService = ProfileService()
    @StateObject var contactService = ContactService()
    @StateObject var contactVM = ContactsViewModel()
    
    @State var navigateToProfileView: Bool = false
    @State var navigateToChat: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                if user.matchedNumber.userID != loginData.mainUserID {
                    VStack{
                        ProfilePictureView(profilePic: user.matchedNumber.profilePic, verified: user.matchedNumber.verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/10, width: UIScreen.screenHeight/10)
                        Text(user.matchedNumber.fullName)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Text(user.matchedNumber.role)
                            .font(.body)
                            .foregroundColor(.black)
                        Spacer()
                        if user.connectionStatus == "Requested" {
                            CustomBlueButton(title: "Requested", width: UIScreen.screenWidth/4, action: {
                                Task {
                                    print("interacting..")
                                    let  res = await profileService.cancelRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: user.matchedNumber.userID)
                                    user.connectionStatus = "Not Connected"
                                    findAndUpdateInRownConnection(status: "Not Connected", globalVM: globalVM, selectedUserID: user.matchedNumber.userID)
                                }
                            })
                        } else if user.connectionStatus == "Connected" {
                            CustomBlueButton(title: "Interact", width: UIScreen.screenWidth/4, action: {
                                navigateToChat = true
                            })
                            .navigationDestination(isPresented: $navigateToChat, destination: {
                                if user.matchedNumber.mesiboAccount.count > 0 {
                                    MessageView(loginData: loginData, mesiboAddress: user.matchedNumber.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                                }
                            })
                            NavigationLink(isActive: $navigateToChat, destination: {
                                MessageView(loginData: loginData, mesiboAddress: user.matchedNumber.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                            }, label: {
                                Text("")
                            })
                        } else if user.connectionStatus == "Confirm request" {
                            CustomBlueButton(title: "Confirm", width: UIScreen.screenWidth/4, action: {
                                Task {
                                    print("confirming..")
                                    let res = await profileService.acceptRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: user.matchedNumber.userID)
                                    user.connectionStatus = "Connected"
                                    findAndUpdateInRownConnection(status: "Connected", globalVM: globalVM, selectedUserID: user.matchedNumber.userID)
                                }
                            })
                        } else if user.connectionStatus == "Not Connected"{
                            CustomGreenButton(title: "Connect", width: UIScreen.screenWidth/4,action: {
                                print("interacting..")
                                profileService.sendRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: user.matchedNumber.userID)
                                user.connectionStatus = "Requested"
                                findAndUpdateInRownConnection(status: "Requested", globalVM: globalVM, selectedUserID: user.matchedNumber.userID)
                            })
                        }
                    }
                    .padding(.vertical, UIScreen.screenHeight/70)
                    .frame(width: UIScreen.screenWidth/2.8, height: UIScreen.screenHeight/4)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .onTapGesture{
                        navigateToProfileView = true
                    }
                    .navigationDestination(isPresented: $navigateToProfileView, destination: {
                        ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: user.matchedNumber.role, mainUser: false, userID: user.matchedNumber.userID)
                    })
                    NavigationLink(isActive: $navigateToProfileView, destination: {
                        ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: user.matchedNumber.role, mainUser: false, userID: user.matchedNumber.userID)
                    }, label: {
                        Text("")
                    })
                }
            }
        }
        .onAppear{
            navigateToChat = false
            navigateToProfileView = false
        }
    }
}

//struct NewConnectionUsersTab_Previews: PreviewProvider {
//    static var previews: some View {
//        NewConnectionUsersTab()
//    }
//}
