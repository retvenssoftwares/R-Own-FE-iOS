//
//  ChatListView.swift
//  R-own
//
//  Created by Aman Sharma on 11/04/23.
//

import SwiftUI
import mesibo

struct ChatListView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    //Mesibo Var
    @StateObject var mesiboData: MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var communityVM: CommunityViewModel
    
    @StateObject var userVM = UserViewModel()
    
    @StateObject var mainUS = MainUserService()
    
    @State var isLoading: Bool = false
    @State var searchChat: String = ""
    @FocusState private var isKeyboardShowing: Bool
    @Environment(\.dismiss) private var dismiss
    
    var filteredMessages: [MessageListModel] {
        if searchChat.isEmpty {
            return mesiboData.chatListMessageList
        } else {
            return mesiboData.chatListMessageList.filter { message in
                message.mMessage.profile?.getName()!.localizedCaseInsensitiveContains(searchChat) ?? false
            }
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack{
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
                            
                    }
                    .padding(.vertical, UIScreen.screenHeight/50)
                    
                    
                    VStack{
                        
                        if filteredMessages.count > 0 {
                            ForEach(filteredMessages.reversed()) { message in
                                if message.mMessage.isGroupMessage() {
                                    if (message.mMessage.groupProfile?.getName() ?? "") != "" {
                                        ChatTabView(message: message.mMessage, address: (message.mMessage.profile!.getAddress())!, loginData: loginData, mesiboData: mesiboData, profileVM: profileVM, globalVM: globalVM, communityVM: communityVM)
                                        Divider()
                                            .frame(width: UIScreen.screenWidth/1.2)
                                    }
                                } else {
                                    if (message.mMessage.profile?.getName() ?? "") != "" {
                                        VStack{
                                            if ((!(message.mMessage.profile?.isBlocked() ?? false))) {
                                                ChatTabView(message: message.mMessage, address: (message.mMessage.profile!.getAddress())!, loginData: loginData, mesiboData: mesiboData, profileVM: profileVM, globalVM: globalVM, communityVM: communityVM)
                                            }
                                            Divider()
                                                .frame(width: UIScreen.screenWidth/1.2)
                                        }
                                    }
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
//                    ForEach( mesiboData.messages, id: \.self){ text in
//                        if (text.isIncoming()) {
//                            Text(text.message ?? "Fetching..")
//                        }else{
//                            Text(text.message ?? "Fetching..")
//                        }
//
//                    }
                }
                .frame(width: UIScreen.screenWidth)
            }
            RownLoaderView(loginData: loginData)
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation {
                        if loginData.selectedMainFeedTab == "Home" {
                            let translationX = value.translation.width
                            if translationX > 0 {
                                print("vneirb")
                            } else {
                                print("jnvr")
                            }
                        }
                    }
                }
                .onEnded { value in
                    withAnimation {
                        if loginData.selectedMainFeedTab == "Home"{
                            if value.translation.width > 0 {
                                dismiss()
                            } else {
                                print("nvnihbvti")
                            }
                        }
                    }
                }
        )
    }
}

//struct ChatListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatListView()
//    }
//}
