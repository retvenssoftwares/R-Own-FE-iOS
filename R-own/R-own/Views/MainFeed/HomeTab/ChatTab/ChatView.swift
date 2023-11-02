//
//  ChatView.swift
//  R-own
//
//  Created by Aman Sharma on 11/04/23.
//

import SwiftUI
import mesibo

struct ChatView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Mesibo Var
    @StateObject var mesiboData: MesiboViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var communityVM: CommunityViewModel
    
    @StateObject var userVM = UserViewModel()
    @State var hideSideBarFakeLogic: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    BasicNavbarView(navbarTitle: "My Chats")
                        .padding(.top, UIScreen.screenHeight/8)
                    
                    ChatListView(loginData: loginData, mesiboData: mesiboData, profileVM: profileVM, globalVM: globalVM, communityVM: communityVM)
                        .overlay{
                            NavigationLink(destination: NewChatUserListView(loginData: loginData, mesiboData: mesiboData, globalVM: globalVM, profileVM: profileVM), label: {
                                HStack{
                                    Image("NewChat")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                        .padding(.trailing, 10)
                                    Text("New Chat")
                                        .foregroundColor(.black)
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .frame(alignment: .leading)
                                }
                                .padding(10)
                                .background(greenUi)
                                .cornerRadius(10)
                            })
                            .offset(x: UIScreen.screenWidth/3.2, y: UIScreen.screenHeight/3)
                        }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            loginData.showLoader = true
            mesiboData.messageType = "ChatTabList"
            mesiboData.chatListMessageList = [MessageListModel]()
            mesiboData.mesiboMessageListInit(loginData: loginData)
            print("=======================")
            print(mesiboData.chatListMessageList)
        }
    }
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
