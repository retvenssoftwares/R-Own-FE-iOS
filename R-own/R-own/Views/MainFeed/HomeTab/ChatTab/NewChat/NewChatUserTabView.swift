//
//  NewChatUserTabView.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import SwiftUI
import mesibo

struct NewChatUserTabView: View {
    
    @State var user: Conn334
    @State var navigateToChatView: Bool = false
    
    @StateObject var loginData: LoginViewModel
    
    //Mesibo Var
    @StateObject var mesiboData: MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var onlineMode: Bool = false
    
    var body: some View {
        NavigationStack{
            HStack(spacing: 0){
                
                ProfilePictureView(profilePic: user.profilePic, verified: user.verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                    .padding(.horizontal, UIScreen.screenWidth/20)
                
                VStack(alignment: .leading){
                    Text(user.fullName)
                        .foregroundColor(.black)
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(alignment: .leading)
                    Text(user.role)
                        .foregroundColor(.gray)
                        .font(.body)
                        .fontWeight(.light)
                        .frame(alignment: .leading)
                }
                Spacer()
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(.white.opacity(0.1))
            .frame(width: UIScreen.screenWidth)
            .onTapGesture {
                mesiboData.messageList = [MessageListModel]()
                navigateToChatView = true
            }
            .navigationDestination(isPresented: $navigateToChatView, destination: {
                if user.mesiboAccount.count > 0{
                    MessageView(loginData: loginData, mesiboAddress: user.mesiboAccount[0].address, mesiboData: mesiboData, profileVM: profileVM, globalVM: globalVM)
                }
            })
            NavigationLink(isActive: $navigateToChatView, destination: {
                MessageView(loginData: loginData, mesiboAddress: user.mesiboAccount[0].address, mesiboData: mesiboData, profileVM: profileVM, globalVM: globalVM)
            }, label: {
                Text("")
            })
        }
        .onAppear{
            navigateToChatView = false
        }
    }
}

//struct NewChatUserTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewChatUserTabView()
//    }
//}
