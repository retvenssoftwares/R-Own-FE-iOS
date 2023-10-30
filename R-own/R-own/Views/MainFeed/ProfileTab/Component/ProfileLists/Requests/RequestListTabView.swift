//
//  RequestListTabView.swift
//  R-own
//
//  Created by Aman Sharma on 16/05/23.
//

import SwiftUI

struct RequestListTabView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @State var requestedConnection: Conn342
    @StateObject var loginData: LoginViewModel
    @State var mainUser: Bool
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var navigateToUserProfile: Bool = false
    
    @StateObject var profileService = ProfileService()
    
    @State var selectedObject: Int = 0
    @Binding var isDataLoading: Bool
    
    var body: some View {
        NavigationStack{
            HStack{
                VStack{
                    ProfilePictureView(profilePic: requestedConnection.profilePic, verified: requestedConnection.verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                }
                .onTapGesture {
                    print("switching to profile view")
                    navigateToUserProfile.toggle()
                }
                
                VStack(alignment: .leading){
                    
                    Text(requestedConnection.fullName)
                        .font(.body)
                        .fontWeight(.bold)
                    
                    if requestedConnection.normalUserInfo.count > 0{
                        Text(requestedConnection.normalUserInfo[0].jobTitle)
                            .font(.body)
                            .fontWeight(.regular)
                    }
                }
                .onTapGesture {
                    print("switching to profile view")
                    navigateToUserProfile.toggle()
                }
                .navigationDestination(isPresented: $navigateToUserProfile, destination: {
                    ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: requestedConnection.role, mainUser: false, userID: requestedConnection.userID)
                })
                
                Spacer()
                
                VStack{
                    Button(action: {
                        Task {
                            isDataLoading = false
                            let res  = await profileService.acceptRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: requestedConnection.userID)
                            if res == "Success" {
                                
                                globalVM.getRequestList = ProfileRequestListModel(conns: [Conn342]())
                                let response = await profileService.getRequestsList(globalVM: globalVM, userID: loginData.mainUserID)
                                if response == "Success" {
                                    isDataLoading = true
                                } else {
                                    let response = await profileService.getRequestsList(globalVM: globalVM, userID: loginData.mainUserID)
                                    if response == "Success" {
                                        isDataLoading = true
                                    } else {
                                        isDataLoading = true
                                    }
                                }
                            }
                        }
                        print("accepting..")
                    }, label: {
                        Text("ACCEPT")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(jobsDarkBlue)
                            .padding(.horizontal, UIScreen.screenWidth/60)
                            .padding(.vertical, UIScreen.screenHeight/70)
                            .background(greenUi)
                            .cornerRadius(5)
                    })
                    
                    Button(action: {
                        Task{
                            isDataLoading = false
                            let res = await profileService.cancelRequest(loginData: loginData, senderID: loginData.mainUserID, receiverID: requestedConnection.userID)
                            if res == "Success" {
                                
                                globalVM.getRequestList = ProfileRequestListModel(conns: [Conn342]())
                                let response = await profileService.getRequestsList(globalVM: globalVM, userID: loginData.mainUserID)
                                if response == "Success" {
                                    isDataLoading = true
                                } else {
                                    let response = await profileService.getRequestsList(globalVM: globalVM, userID: loginData.mainUserID)
                                    if response == "Success" {
                                        isDataLoading = true
                                    } else {
                                        isDataLoading = true
                                    }
                                }
                            }
                        }
                        print("Rejecting..")
                    }, label: {
                        Text("REJECT")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(greenUi)
                            .padding(.horizontal, UIScreen.screenWidth/60)
                            .padding(.vertical, UIScreen.screenHeight/70)
                            .background(jobsDarkBlue)
                            .cornerRadius(5)
                    })
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/10)
            .padding(.vertical, UIScreen.screenHeight/60)
        }
    }
    func deleteElementFromList(id: String) {
        for i in 0..<globalVM.getRequestList.conns.count {
            if globalVM.getRequestList.conns[i].id == id {
                selectedObject = i
            }
        }
        globalVM.getRequestList.conns.remove(at: selectedObject)
    }
}

//struct RequestListTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestListTabView()
//    }
//}
