//
//  ExplorePeopleSearchListView.swift
//  R-own
//
//  Created by Aman Sharma on 11/07/23.
//

import SwiftUI

struct ExplorePeopleSearchListView: View {
    @State var loginData: LoginViewModel
    @State var people: Post344
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var profileService = ProfileService()
    
    @State var switchToProfile: Bool = false
    
    var body: some View {
        NavigationStack{
            HStack{
                VStack{
                    ProfilePictureView(profilePic: people.profilePic, verified: people.verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                }
                .onTapGesture {
                    print("switching to profile view")
                    switchToProfile.toggle()
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
                    switchToProfile.toggle()
                }
                Spacer()
                VStack{
                    if people.connectionStatus == "Requested" {
                        Button(action: {
                            Task {
                                print("interacting..")
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
                            print("interacting..")
                            profileService.removeConnection(loginData: loginData, senderID: loginData.mainUserID, receiverID: people.userID)
                            people.connectionStatus = "Not Connected"
                        }, label: {
                            Text("REMOVE")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(jobsDarkBlue)
                                .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/35)
                                .background(greenUi)
                                .cornerRadius(5)
                        })
                    } else {
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
                        switchToProfile.toggle()
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
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/10)
            .padding(.vertical, UIScreen.screenHeight/60)
        }
    }
}

//struct ExplorePeopleSearchListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExplorePeopleSearchListView()
//    }
//}
