//
//  NormalProfileFPPStatusTabView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct NormalProfileFPPStatusTabView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var userID: String
    @State var role: String
    @State var mainUser: Bool
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        NavigationStack{
            ScrollView{
                StatusProfileListView(loginData: loginData, globalVM: globalVM, role: role, mainUser: mainUser, userID: userID)
            }
        }
        .onAppear{
            globalVM.getStatusPostList = [ProfileStatusPostModel(page: 0, pageSize: 0, posts: [Post583]())]
            profileService.getStatusPosts(globalVM: globalVM, userID: userID, loginData: loginData, page: "1")
        }
    }
}

//struct NormalProfileFPPStatusTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileFPPStatusTabView()
//    }
//}
