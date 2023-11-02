//
//  GroupMessageView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI
import mesibo

struct GroupMessageView: View {
    
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var groupID: String
    @State var communityName: String
    @State var communityPic: String
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var keyboardVisibility: Bool = false
    
    // MARK: User Var
    
    @State var image: UIImage?
    @State var showSelectedImagePreview: Bool = false
    @State var showSelectedVideoPreview: Bool = false
    @State var showSelectedDocumentPreview: Bool = false
    @State var selectedVideoURL: URL?
    @State var selectedDocumentURL: URL?
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    GroupMessageFirstHalfView(loginData:loginData, communityVM: communityVM, mesiboVM: mesiboVM, communityName: communityName, communityPic: communityPic, groupID: groupID, globalVM: globalVM, profileVM: profileVM)
                        .padding(.top, UIScreen.screenHeight/70)
                        .background(.white)
                        .border(width: 1, edges: [.bottom], color: greenUi)
                    MessageViewSecondHalf(loginData: loginData, mesiboVM: mesiboVM, profileVM: profileVM, globalVM: globalVM, keyboardVisibility: $keyboardVisibility)
                    MessageViewThirdHalf(image: $image, showSelectedImagePreview: $showSelectedImagePreview, selectedVideoURL: $selectedVideoURL, showSelectedVideoPreview: $showSelectedVideoPreview, selectedDocumentURL: $selectedDocumentURL, showSelectedDocumentPreview: $showSelectedDocumentPreview, loginData:loginData, mesiboVM: mesiboVM, keyboardVisibility: $keyboardVisibility, globalVM: globalVM)
//                    GroupMessageSecondHalfView(loginData:loginData, communityVM: communityVM, mesiboVM: mesiboVM)
//                    GroupMessageThirdHalfView(loginData:loginData, communityVM: communityVM, mesiboVM: mesiboVM)
                        .padding(.vertical, 15)
                }
                .background(
                    Image("DefaultChatBG")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                )
                if image != nil {
                    if showSelectedImagePreview {
                        SelectedMessageImagePreview(image: $image, mesiboVM: mesiboVM, loginData: loginData, showSelectedImagePreview: $showSelectedImagePreview, globalVM: globalVM)
                    }
                }
                
                if selectedVideoURL != nil {
                    if showSelectedVideoPreview {
                        SelectedMessageVideoPreview(url: selectedVideoURL!, showSelectedVideoPreview: $showSelectedVideoPreview, loginData: loginData, mesiboVM: mesiboVM, globalVM: globalVM)
                    }
                }
                
                if selectedDocumentURL != nil {
                    if showSelectedDocumentPreview {
                        SelectedMessageDocumentPreview(url: selectedDocumentURL!, showSelectedDocumentPreview: $showSelectedDocumentPreview, loginData: loginData, mesiboVM: mesiboVM, globalVM: globalVM)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear{
//            loginData.showLoader = true
//            mesiboData.mesiboSetTPPUser(user.mesiboAccount[0].token, address: user.mesiboAccount[0].address)
            mesiboVM.chatMessageList = [MessageListModel]()
            mesiboVM.mesiboGroupSet(UInt32(groupID)!)
            mesiboVM.messageType = "MessageList"
            mesiboVM.mesiboMessageScreenInit(loginData: loginData)
        }
        .onDisappear{
//            mesiboData.messages = [MesiboMessage]()
//            print(mesiboData.messages)
        }
    }
}

//struct GroupMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupMessageView()
//    }
//}
