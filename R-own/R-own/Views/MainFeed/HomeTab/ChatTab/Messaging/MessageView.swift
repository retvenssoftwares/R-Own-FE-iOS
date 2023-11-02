//
//  MessageView.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import SwiftUI
import mesibo

struct MessageView: View {
    
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    // MARK: User Var
    
    @State var image: UIImage?
    @State var showSelectedImagePreview: Bool = false
    @State var showSelectedVideoPreview: Bool = false
    @State var showSelectedDocumentPreview: Bool = false
    @State var selectedVideoURL: URL?
    @State var selectedDocumentURL: URL?
    
    
    @State var mesiboAddress: String
    
    
    //Mesibo Var
    @StateObject var mesiboData: MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var callStarted: Bool = false
    
    @State var keyboardVisibility: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    MessageViewFirstHalf(loginData:loginData, mesiboVM: mesiboData, callStarted: $callStarted, profileVM: profileVM, globalVM: globalVM)
                        .border(width: 1, edges: [.bottom], color: .black)
                    
                    MessageViewSecondHalf(loginData:loginData, mesiboVM: mesiboData, profileVM: profileVM, globalVM: globalVM, keyboardVisibility: $keyboardVisibility)
                    
                    MessageViewThirdHalf(image: $image, showSelectedImagePreview: $showSelectedImagePreview, selectedVideoURL: $selectedVideoURL, showSelectedVideoPreview: $showSelectedVideoPreview, selectedDocumentURL: $selectedDocumentURL, showSelectedDocumentPreview: $showSelectedDocumentPreview, loginData:loginData, mesiboVM: mesiboData, keyboardVisibility: $keyboardVisibility, globalVM: globalVM)
                }
                .background(
                    Image("DefaultChatBG")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                        .onTapGesture {
                            keyboardVisibility = false
                            print("bbhnbhn")
                        }
                )
                if image != nil {
                    if showSelectedImagePreview {
                        SelectedMessageImagePreview(image: $image, mesiboVM: mesiboData, loginData: loginData, showSelectedImagePreview: $showSelectedImagePreview, globalVM: globalVM)
                    }
                }
                
                if selectedVideoURL != nil {
                    if showSelectedVideoPreview {
                        SelectedMessageVideoPreview(url: selectedVideoURL!, showSelectedVideoPreview: $showSelectedVideoPreview, loginData: loginData, mesiboVM: mesiboData, globalVM: globalVM)
                    }
                }
                
                if selectedDocumentURL != nil {
                    if showSelectedDocumentPreview {
                        SelectedMessageDocumentPreview(url: selectedDocumentURL!, showSelectedDocumentPreview: $showSelectedDocumentPreview, loginData: loginData, mesiboVM: mesiboData, globalVM: globalVM)
                    }
                }
                
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            loginData.showLoader = true
            mesiboData.mesiboSetTPPUser(mesiboAddress)
            mesiboData.chatMessageList = []
            mesiboData.messageType = "MessageList"
            mesiboData.mesiboMessageScreenInit(loginData: loginData)
        }
//        .onDisappear{
//            mesiboData.messageList = [MessageListModel]()
//            print(mesiboData.messageList)
//        }
    }
}

//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView()
//    }
//}
