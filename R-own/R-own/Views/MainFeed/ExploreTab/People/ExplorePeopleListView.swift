//
//  ExplorePeopleListView.swift
//  R-own
//
//  Created by Aman Sharma on 30/05/23.
//

import SwiftUI

struct ExplorePeopleListView: View {
    @State var loginData: LoginViewModel
    @State var people: Post34
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var profileService = ProfileService()
    
    @State var switchToProfile: Bool = false
    @State var navigateToChat: Bool = false
    
    var body: some View {
        NavigationStack{
            HStack{
                VStack{
                    ProfilePictureView(profilePic: people.profilePic, verified: people.verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                }
                .onTapGesture {
                    print("switching to profile view")
                    switchToProfile = true
                }
                
                VStack(alignment: .leading){
                    Text(people.fullName)
                        .font(.body)
                        .fontWeight(.bold)
                    Text(people.role)
                        .font(.footnote)
                        .fontWeight(.regular)
                }
                .padding(.horizontal, UIScreen.screenWidth/30)
                .onTapGesture {
                    print("switching to profile view")
                    switchToProfile = true
                }
                Spacer()
                VStack{
                    if people.connectionStatus == "Requested" {
                        Button(action: {
                            Task {
                                print("requested..")
                                let res = await profileService.cancelRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: people.userID)
                                people.connectionStatus = "Not Connected"
                            }
                        }, label: {
                            Text("REQUESTED")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(jobsDarkBlue)
                                .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/35)
                                .background(greenUi)
                                .cornerRadius(5)
                        })
                    } else if people.connectionStatus == "Connected" {
                        Button(action: {
                            navigateToChat = true
                        }, label: {
                            Text("INTERACT")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(jobsDarkBlue)
                                .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/35)
                                .background(greenUi)
                                .cornerRadius(5)
                        })
                        .navigationDestination(isPresented: $navigateToChat, destination: {
                            if people.mesiboAccount.count > 0 {
                                MessageView(loginData: loginData, mesiboAddress: people.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                            }
                        })
                        NavigationLink(isActive: $navigateToChat, destination: {
                            MessageView(loginData: loginData, mesiboAddress: people.mesiboAccount[0].address, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                        }, label: {
                            Text("")
                        })
                    } else if people.connectionStatus == "Confirm Request" {
                        Button(action: {
                            Task {
                                print("confirming..")
                                let res = await profileService.acceptRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: people.userID)
                                people.connectionStatus = "Connected"
                            }
                        }, label: {
                            Text("CONFIRM")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(jobsDarkBlue)
                                .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/35)
                                .background(greenUi)
                                .cornerRadius(5)
                        })
                    } else if people.connectionStatus == "Not Connected"{
                        Button(action: {
                            print("interacting..")
                            profileService.sendRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: people.userID)
                            people.connectionStatus = "Requested"
                        }, label: {
                            Text("CONNECT")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(jobsDarkBlue)
                                .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/35)
                                .background(greenUi)
                                .cornerRadius(5)
                        })
                    }
                    
                    Button(action: {
                        print("View..")
                        switchToProfile = true
                    }, label: {
                        Text("VIEW")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(greenUi)
                            .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/35)
                            .background(jobsDarkBlue)
                            .cornerRadius(5)
                    })
                    .navigationDestination(isPresented: $switchToProfile, destination: {
                        ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: people.role, mainUser: false, userID: people.userID)
                    })
                    NavigationLink(isActive: $switchToProfile, destination: {
                        ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: people.role, mainUser: false, userID: people.userID)
                    }, label: {
                        Text("")
                    })
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/20)
            .padding(.vertical, UIScreen.screenHeight/60)
        }
        .onAppear{
            navigateToChat = false
            switchToProfile = false
        }
    }
}
//struct ExplorePeopleListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExplorePeopleListView()
//    }
//}
