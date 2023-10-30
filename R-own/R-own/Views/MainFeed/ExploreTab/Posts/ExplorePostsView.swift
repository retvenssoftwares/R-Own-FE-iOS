//
//  ExplorePostsView.swift
//  R-own
//
//  Created by Aman Sharma on 29/04/23.
//

import SwiftUI
import AlertToast

struct ExplorePostsView: View {
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var exploreVM: ExploreViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var exploreService = ExploreService()
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        VStack{
            TextField("Search", text: $exploreVM.explorePostSearchText )
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
                            .padding(.trailing, UIScreen.screenWidth/20)
                    }
                }
                .onChange(of: exploreVM.explorePostSearchText) { newValue in
                    if newValue.count >= 2 {
                        searchPost()
                    }
                }
                .focused($isKeyboardShowing)
            ExplorePostListView(globalVM: globalVM, loginData: loginData, profileVM: profileVM, exploreVM: exploreVM, mesiboVM: mesiboVM)
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
//        .toast(isPresenting: $globalVM.toastSearchLoading, tapToDismiss: true){
//            AlertToast(type: .loading, title: "Loading Post")
//        }
        .onAppear{
            exploreVM.explorePostSearchText = ""
            globalVM.exploreSearchPostList = [ExplorePostModel(page: 0, pageSize: 0, posts: [ExplorePost]()) ]
            globalVM.explorePostList = [ExplorePostModel(page: 0, pageSize: 0, posts: [ExplorePost]()) ]
            Task{
                exploreVM.explorePostLoading = false
                let res  = await exploreService.getExplorePosts(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: "1")
                if res == "Success"{
                    exploreVM.explorePostLoading = true
                } else {
                    exploreVM.explorePostLoading = false
                    let res  = await exploreService.getExplorePosts(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: "1")
                    if res == "Success"{
                        exploreVM.explorePostLoading = true
                    } else {
                        exploreVM.explorePostLoading = false
                    }
                }
            }
        }
    }
    func searchPost() {
        exploreService.getExplorePostsBySearch(globalVM: globalVM, userID: loginData.mainUserID, keyword: exploreVM.explorePostSearchText, pageNumber: String(1))
    }
}

//struct ExplorePostsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExplorePostsView()
//    }
//}
