//
//  GroupTabView.swift
//  R-own
//
//  Created by Aman Sharma on 15/07/23.
//

import SwiftUI
import mesibo

struct GroupTabView: View {
    
    
    @State var message: MesiboMessage
    @State var address: String
    @State var navigateToChatView: Bool = false
    
    @State var profilePic: String = ""
    @State var activityStatus: String = ""
    @State var mesiboProfile: MesiboProfile = MesiboProfile()
    
    @StateObject var loginData: LoginViewModel
    
    
    //Mesibo Var
    @StateObject var mesiboData: MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                ProfilePictureView(profilePic: message.profile?.getImageUrl() ?? "", verified: false, height: UIScreen.screenHeight/10, width: UIScreen.screenHeight/10)
                    .padding(.trailing, UIScreen.screenWidth/40)
                VStack(alignment: .leading){
                    Text(message.profile?.getName() ?? "Fetching UserName")
                        .foregroundColor(.black)
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(alignment: .leading)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(.white.opacity(0.1))
            .frame(width: UIScreen.screenWidth)
            .onTapGesture {
                navigateToChatView.toggle()
            }
            .navigationDestination(isPresented: $navigateToChatView, destination: {
                MessageView(loginData: loginData, mesiboAddress: (message.profile!.getAddress())!, mesiboData: mesiboData, profileVM: profileVM, globalVM: globalVM)
            })
        }
        .onAppear{
        }
    }
}

//struct GroupTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupTabView()
//    }
//}
