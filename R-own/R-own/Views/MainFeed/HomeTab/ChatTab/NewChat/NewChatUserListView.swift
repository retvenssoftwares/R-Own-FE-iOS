//
//  NewChatUserListView.swift
//  R-own
//
//  Created by Aman Sharma on 11/04/23.
//

import SwiftUI

struct NewChatUserListView: View {
    
    //user var
    @StateObject var loginData: LoginViewModel
    
    @StateObject var userVM = UserViewModel()
    
    //Mesibo Var
    @StateObject var mesiboData: MesiboViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var profileService = ProfileService()
    @StateObject var mainUS = MainUserService()
    @State var isLoading: Bool = false
    
    @State var searchChat: String = ""
    @FocusState private var isKeyboardShowing: Bool
    
    var filteredChat: [Conn334] {
        if searchChat.isEmpty {
            return globalVM.getConnectionList[0].conns
        } else {
            return globalVM.getConnectionList[0].conns.filter { name in
                name.fullName.localizedCaseInsensitiveContains(searchChat)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    BasicNavbarView(navbarTitle: "New Message")
                        .padding(.top, UIScreen.screenHeight/50)
                    ScrollView {
                        VStack{
                            TextField("Search..", text: $searchChat)
                                .font(.body)
                                .frame(width: UIScreen.screenWidth/1.2)
                                .overlay(alignment: .trailing, content: {
                                    if searchChat == "" {
                                        Image(systemName: "magnifyingglass")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                    } else {
                                        Button(action: {
                                            searchChat = ""
                                        }, label: {
                                            Image(systemName: "xmark.circle")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                                .foregroundColor(.black)
                                        })
                                        
                                    }
                                })
                                .focused($isKeyboardShowing)
                                .padding()
                                .overlay{
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lineWidth: 1)
                                        .foregroundColor(lightGreyUi)
                                }
                            
                            if globalVM.getConnectionList.count > 0 {
                                if globalVM.getConnectionList[0].conns.count > 0 {
                                    ForEach(filteredChat) { chat in
                                        if chat.userID != loginData.mainUserID{
                                            NewChatUserTabView(user: chat, loginData: loginData, mesiboData: mesiboData, profileVM: profileVM, globalVM: globalVM)
                                            Divider()
                                        }
                                    }
                                } else {
                                    VStack{
                                        Image("NewChatIllustration")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth/1.2)
                                            .overlay{
                                                HStack{
                                                    VStack{
                                                        Text(loginData.mainUserFullName)
                                                            .font(.body)
                                                            .fontWeight(.medium)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: UIScreen.screenWidth/2.5)
                                                            .offset(x: UIScreen.screenWidth/10, y: UIScreen.screenHeight/15)
                                                        Spacer()
                                                    }
                                                    Spacer()
                                                }
                                            }
                                            .overlay{
                                                if isLoading {
                                                    HStack{
                                                        VStack{
                                                            Text("Connect with \(globalVM.totalUsersInRown.count)+ hoteliers on R-Own and engage with a vibrant community!")
                                                                .font(.body)
                                                                .fontWeight(.medium)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width: UIScreen.screenWidth/2)
                                                                .offset(x: UIScreen.screenWidth/9, y: UIScreen.screenHeight/6.5)
                                                            Spacer()
                                                        }
                                                        Spacer()
                                                    }
                                                }
                                            }
                                    }
                                    .onAppear{
                                        Task{
                                            let res = await mainUS.getTotalUserCount(globalVM: globalVM)
                                            if res == "Success"{
                                                isLoading = true
                                            } else {
                                                isLoading = false
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
                RownLoaderView(loginData: loginData)
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            globalVM.getConnectionList = [ProfileConnectionListModel]()
            makeAPICall(globalVM: globalVM, userID: loginData.mainUserID)
        }
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

//struct NewChatUserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewChatUserListView()
//    }
//}
