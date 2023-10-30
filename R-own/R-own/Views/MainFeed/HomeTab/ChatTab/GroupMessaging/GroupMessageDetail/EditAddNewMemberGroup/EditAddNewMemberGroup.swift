//
//  EditAddNewMemberGroup.swift
//  R-own
//
//  Created by Aman Sharma on 29/07/23.
//

import SwiftUI
import AlertToast

struct EditAddNewMemberGroup: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var profileVM: ProfileViewModel
    
    @State var membersSearchText: String = ""
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var navigateToUploadIconView: Bool = false
    
    @State var userNotSelected: Bool = false
    @State var userAddedSuccessfully: Bool = false
    @StateObject var profileService = ProfileService()
    @StateObject var communityService = CommunityService()
    
    @State var totalUsers: [MesiboGroupUser]
    
    
    var filteredConnections: [Conn334] {
        if membersSearchText.isEmpty {
            return globalVM.getConnectionList[0].conns
        } else {
            return globalVM.getConnectionList[0].conns.filter { connection in
                connection.fullName.lowercased().contains(membersSearchText.lowercased())
            }
        }
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    //topnav
                    HStack{
                        //BackButton
                        Button(action: {
                            dismiss()
                        }, label: {
                            Circle()
                                .strokeBorder(Color.black,lineWidth: 1)
                                .background(Circle().foregroundColor(Color.white))
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                .overlay{
                                    Image(systemName: "arrow.left")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                        .foregroundColor(.black)
                                }
                        })
                        .padding(.leading, UIScreen.screenWidth/20)
                        
                        Spacer()
                    }
                    .padding(.vertical, UIScreen.screenHeight/50)
                    
                    //headingnav
                    Text("Select members")
                        .foregroundColor(communityTextGreenColorUI)
                        .font(.body)
                        .fontWeight(.bold)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .frame(alignment: .leading)
                        .frame(width: UIScreen.screenWidth)
                        .background(communityBGBlueColorUI)
                        .border(width: 1, edges: [.bottom], color: greenUi)
                        .cornerRadius(3, corners: .bottomLeft)
                        .cornerRadius(3, corners: .bottomRight)
                    
                    if communityVM.selectedGroupMember.count != 0 {
                        VStack(alignment: .leading){
                            ScrollView(.horizontal) {
                                HStack(spacing: 5){
                                    ForEach(communityVM.selectedGroupMember, id: \.self) { user in
                                        ProfilePictureView(profilePic: user.profilePic, verified: user.verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                                    }
                                    Spacer()
                                }
                                .frame(width: UIScreen.screenWidth)
                                .padding(.vertical, UIScreen.screenHeight/60)
                            }
                            Divider()
                        }
                    }
                    
                    //search members
                    
                    TextField("Search", text: $membersSearchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.default)
                        .padding()
                        .frame(width: UIScreen.screenWidth/1.2)
                        .cornerRadius(5)
                        .overlay{
                            Image("ExploreSearchIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                .offset(x: UIScreen.screenWidth/2.9)
                        }
                        .focused($isKeyboardShowing)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                                }
                            }
                        }
                    
                    ScrollView{
                        VStack{
                            if globalVM.getConnectionList.count > 0 {
                                if filteredConnections.count > 0 {
                                    ForEach(0..<filteredConnections.count, id: \.self) { count in
                                        CommunityUserSubTabView(communityVM: communityVM, user: filteredConnections[count])
                                    }
                                } else{
                                    Text("Seems like you dont have any friends yet!")
                                }
                            } else {
                                Text("Server error! Working on it.")
                            }
                        }
                    }
                    
                }
                
                //button
                VStack{
                    Spacer()
                    
                    HStack{
                        
                        Spacer()
                        
                        Button(action: {
                            loginData.showLoader = true
                            
                            if communityVM.selectedGroupMember.count == 0 {
                                userNotSelected.toggle()
                            } else {
                                var resultArr = [String]()
                                for i in 0..<communityVM.selectedGroupMember.count{
                                    if communityVM.selectedGroupMember[i].mesiboAccount.count > 0 {
                                        resultArr.append(communityVM.selectedGroupMember[i].mesiboAccount[0].address)
                                    }
                                }
                                let res = convertToStringSeparatedByComma(resultArr)
                                print(res)
                                print("this is resssss")
                                print(res)
                                communityService.addMemberInMesiboGroup(loginData: loginData, groupID: communityVM.selectedGroupID, userAttribute: res)
                                
                                for i in 0..<communityVM.selectedGroupMember.count {
                                    communityService.addMemberInCommunity(communityID: communityVM.selectedGroupID, userID: communityVM.selectedGroupMember[i].userID)
                                    totalUsers.append(MesiboGroupUser(userID: communityVM.selectedGroupMember[i].userID, fullName: communityVM.selectedGroupMember[i].fullName, address: communityVM.selectedGroupMember[i].phone, uid: 0, profilePic: communityVM.selectedGroupMember[i].profilePic, verificationStatus: communityVM.selectedGroupMember[i].verificationStatus, location: "", role: communityVM.selectedGroupMember[i].role, admin: "false"))
                                }
                                
                                dismiss()
                            }
                        }, label: {
                            Circle()
                                .strokeBorder(Color.white,lineWidth: 1)
                                .background(Circle().foregroundColor(Color.green))
                                .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                .overlay{
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                        .foregroundColor(.white)
                                }
                        })
                        .padding(.trailing, UIScreen.screenWidth/30)
                        .padding(.bottom, UIScreen.screenHeight/10)
                        .navigationDestination(isPresented: $navigateToUploadIconView, destination:{
                            CommunityUploadIconView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, globalVM: globalVM, profileVM: profileVM)
                        })
                    }
                }
            }
            .toast(isPresenting: $userNotSelected, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Select minimum of two member to make group", subTitle: ("Enter your community name"))
            }
            .toast(isPresenting: $userAddedSuccessfully, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "User Added Successfully")
            }
            .onAppear{
                Task{
                    communityVM.selectedGroupMember = [Conn334]()
                    globalVM.getConnectionList = [ProfileConnectionListModel]()
                    print("getting connection")
                    makeAPICall(globalVM: globalVM, userID: loginData.mainUserID)
                    print("finished getting connections")
                }
            }
            .onDisappear{
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
    }
    func makeAPICall(globalVM: GlobalViewModel, userID: String){
        
            Task{
                loginData.showLoader = true
                let res = await profileService.getConnectionsList(globalVM: globalVM, userID: userID)
                if res == "Success" {
                    if globalVM.getConnectionList.count > 0 {
                        if globalVM.getConnectionList[0].conns.count > 0 {
                            let userIDsToRemove = Set(totalUsers.map { $0.userID })
                            globalVM.getConnectionList[0].conns = globalVM.getConnectionList[0].conns.filter { !userIDsToRemove.contains($0.userID) }
                        }
                    }
                    loginData.showLoader = false
                } else {
                    makeAPICall(globalVM: globalVM, userID: userID)
                }
            }
    }
    
    func convertToStringSeparatedByComma(_ array: [String]) -> String {
        return array.joined(separator: ", ")
    }
    
}

//struct EditAddNewMemberGroup_Previews: PreviewProvider {
//    static var previews: some View {
//        EditAddNewMemberGroup()
//    }
//}
