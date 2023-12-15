//
//  NewRownUsersTab.swift
//  R-own
//
//  Created by Aman Sharma on 13/07/23.
//

import SwiftUI

struct NewRownUsersTab: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @State var user: Post34
    
    @StateObject var exploreService = ExploreService()
    @StateObject var profileService = ProfileService()
    @StateObject var contactService = ContactService()
    @StateObject var contactVM = ContactsViewModel()
    
    @State var navigateToROwnProfileView: Bool = false
    @State var navigateToChat: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                ProfilePictureView(profilePic: user.profilePic, verified: user.verificationStatus == "false" ? false : true , height: UIScreen.screenHeight/10, width: UIScreen.screenHeight/10)
                Text(user.fullName)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                if user.userName != "" {
                    Text("@\(user.userName)")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
                Text(user.role)
                    .font(.body)
                    .foregroundColor(.black)
                Spacer()
                if user.connectionStatus == "Requested" {
                    CustomBlueButton(title: "Requested", width: UIScreen.screenWidth/4, action: {
                        Task {
                            print("interacting..")
                            let res = await profileService.cancelRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: user.userID)
                            if res == "Success" {
                                user.connectionStatus = "Not Connected"
                                findAndUpdateInContactsConnection(status: "Not Connected", globalVM: globalVM, selectedUserID: user.userID)
                            }
                        }
                    })
                } else if user.connectionStatus == "Connected" {
                    CustomBlueButton(title: "Interact", width: UIScreen.screenWidth/4, action: {
                        print("interacting..")
                        navigateToChat = true
                    })
                    .navigationDestination(isPresented: $navigateToChat, destination: {
                        if user.mesiboAccount.count > 0 {
                            MessageView(loginData: loginData, mesiboAddress: user.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                        }
                    })
                    NavigationLink(isActive: $navigateToChat, destination: {
                        MessageView(loginData: loginData, mesiboAddress: user.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                    }, label: {
                        Text("")
                    })
                } else if user.connectionStatus == "Confirm request" {
                    CustomBlueButton(title: "Confirm", width: UIScreen.screenWidth/4, action: {
                        Task {
                            print("confirming..")
                            let res = await profileService.acceptRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: user.userID)
                            if res == "Success"{
                                user.connectionStatus = "Connected"
                                findAndUpdateInContactsConnection(status: "Connected", globalVM: globalVM, selectedUserID: user.userID)
                            }
                        }
                    })
                } else if user.connectionStatus == "Not Connected"{
                    CustomGreenButton(title: "Connect", width: UIScreen.screenWidth/4, action: {
                        print("interacting..")
                        profileService.sendRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: user.userID)
                        user.connectionStatus = "Requested"
                        findAndUpdateInContactsConnection(status: "Requested", globalVM: globalVM, selectedUserID: user.userID)
                    })
                }
            }
            .padding(.vertical, UIScreen.screenHeight/70)
            .frame(width: UIScreen.screenWidth/2.8, height: UIScreen.screenHeight/4)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
            .onTapGesture{
                navigateToROwnProfileView = true
            }
            .navigationDestination(isPresented: $navigateToROwnProfileView, destination: {
                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: user.role, mainUser: false, userID: user.userID)
            })
            NavigationLink(isActive: $navigateToROwnProfileView, destination: {
                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: user.role, mainUser: false, userID: user.userID)
            }, label: {
                Text("")
            })
        }
        .onAppear{
            navigateToChat = false
            navigateToROwnProfileView = false
        }
    }
}

//struct NewRownUsersTab_Previews: PreviewProvider {
//    static var previews: some View {
//        NewRownUsersTab()
//    }
//}
