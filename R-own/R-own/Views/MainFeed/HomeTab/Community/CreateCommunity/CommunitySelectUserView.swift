//
//  CommunitySelectUserView.swift
//  R-own
//
//  Created by Aman Sharma on 09/05/23.
//

import SwiftUI
import AlertToast

struct CommunitySelectUserView: View {
    
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
    @StateObject var profileService = ProfileService()
    @StateObject var communityService = CommunityService()
    
    
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
                        
                        //Text
                        Spacer()
                        Text("Create Community")
                            .foregroundColor(.black)
                            .font(.body)
                            .fontWeight(.bold)
                            .frame(alignment: .leading)
                        Spacer()
                    }
                    .padding(.vertical, UIScreen.screenHeight/50)
                    .overlay{
                        HStack{
                            
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
                    }
                    
                    //headingnav
                    Text("Select members")
                        .foregroundColor(communityTextGreenColorUI)
                        .font(.headline)
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
                                        ProfilePictureView(profilePic: user.profilePic, verified: user.verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
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
                        .frame(width: UIScreen.screenWidth/1.1)
                        .cornerRadius(5)
                        .overlay{
                            HStack{
                                Spacer()
                                Image("ExploreSearchIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                    .padding(.trailing, UIScreen.screenWidth/30)
                            }
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
                                        .font(.body)
                                }
                            } else {
                                Text("Server error! Working on it.")
                                    .font(.body)
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
                            if communityVM.selectedGroupMember.count < 2 {
                                userNotSelected.toggle()
                            } else {
                                navigateToUploadIconView.toggle()
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
                        .navigationDestination(isPresented: $navigateToUploadIconView, destination: {CommunityUploadIconView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, globalVM: globalVM, profileVM: profileVM)})
                    }
                }
            }
            .toast(isPresenting: $userNotSelected, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Select minimum of two member to make group", subTitle: ("Enter your community name"))
            }
            .onAppear{
                Task{
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
                    loginData.showLoader = false
                } else {
                    makeAPICall(globalVM: globalVM, userID: userID)
                }
            }
    }
}

//struct CommunitySelectUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunitySelectUserView()
//    }
//}
