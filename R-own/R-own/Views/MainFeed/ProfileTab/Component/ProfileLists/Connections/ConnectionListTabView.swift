//
//  ConnectionListTabView.swift
//  R-own
//
//  Created by Aman Sharma on 16/05/23.
//

import SwiftUI

struct ConnectionListTabView: View {
    
    @State var connection: Conn334
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @State var mainUser: Bool
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @State var selectedObject: Int = 0
    
    
    @State var navigateToUserProfile: Bool = false
    
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        NavigationStack{
            HStack{
                VStack{
                    ProfilePictureView(profilePic: connection.profilePic, verified: connection.verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                }
                .onTapGesture {
                    print("switching to profile view")
                    navigateToUserProfile.toggle()
                }
                
                VStack(alignment: .leading){
                    Text(connection.fullName)
                        .font(.body)
                        .fontWeight(.bold)
                    if connection.role != "" {
                        Text(connection.role)
                            .font(.footnote)
                            .fontWeight(.semibold)
                    } else {
                        Text("Normal User")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal, UIScreen.screenWidth/30)
                .onTapGesture {
                    print("switching to profile view")
                    navigateToUserProfile.toggle()
                }
                Spacer()
                VStack{
                    Button(action: {
                        print("viewing..")
                        navigateToUserProfile.toggle()
                    }, label: {
                        Text("VIEW")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(jobsDarkBlue)
                            .frame(width: UIScreen.screenWidth/6)
                            .padding(.horizontal, UIScreen.screenWidth/17)
                            .padding(.vertical, UIScreen.screenHeight/80)
                            .background(greenUi)
                            .cornerRadius(5)
                    })
                    .navigationDestination(isPresented: $navigateToUserProfile, destination: {
                        ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: connection.role, mainUser: false, userID: connection.userID)
                    })
                    
                    if mainUser {
                        Button(action: {
                            print("remove..")
                            profileService.removeConnection(loginData: loginData, senderID: loginData.mainUserID, receiverID: connection.userID)
//                            deleteElementFromList(id: connection.id)
                        }, label: {
                            Text("REMOVE")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(greenUi)
                                .frame(width: UIScreen.screenWidth/6)
                                .padding(.horizontal, UIScreen.screenWidth/17)
                                .padding(.vertical, UIScreen.screenHeight/80)
                                .background(jobsDarkBlue)
                                .cornerRadius(5)
                        })
                    }
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/30)
        }
    }
    func deleteElementFromList(id: String) {
        for i in 0..<globalVM.getConnectionList[0].conns.count {
            if globalVM.getRequestList.conns[i].id == id {
                selectedObject = i
            }
        }
        globalVM.getRequestList.conns.remove(at: selectedObject)
    }
}

//struct ConnectionListTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConnectionListTabView()
//    }
//}
