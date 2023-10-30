//
//  NormalProfileFPPMediaTabView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI

struct NormalProfileFPPMediaTabView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @State var profileVM: ProfileViewModel
    @State var mesiboVM: MesiboViewModel
    @State var userID: String
    @State var role: String
    @State var mainUser: Bool
    
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        ScrollView{
            VStack{
                MediaProfileListView(globalVM: globalVM, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM, role: role, mainUser: mainUser)
            }
        }
        .onAppear{
            profileService.getMediaPosts(loginData: loginData, globalVM: globalVM, userID: userID)
        }
    }
}

//struct NormalProfileFPPMediaTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileFPPMediaTabView()
//    }
//}
