//
//  ExplorePostListView.swift
//  R-own
//
//  Created by Aman Sharma on 31/05/23.
//

import SwiftUI

struct ExplorePostListView: View {
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var exploreVM: ExploreViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @ObservedObject var exploreService = ExploreService()
    
    @State var counter1: Int = 1
    @State var counter2: Int = 1
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack{
                LazyVGrid(columns: columns) {
                    if exploreVM.explorePostSearchText == "" {
                        if globalVM.explorePostList.count > 0 {
                            ForEach(0..<globalVM.explorePostList[0].posts.count, id: \.self) { id in
                                if globalVM.explorePostList[0].posts[id].displayStatus == "1" {
                                       ExplorePostCardView(post: globalVM.explorePostList[0].posts[id], imgData: globalVM.explorePostList[0].posts[id].media, loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                                        .onAppear {
                                            if globalVM.explorePostList[0].posts.count > 8 {
                                                if id == globalVM.explorePostList[0].posts.count - 2 {
                                                    counter1 = counter1 + 1
                                                    
                                                    Task{
                                                        exploreVM.explorePostLoading = false
                                                        let res  = await exploreService.getExplorePosts(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(counter1))
                                                        if res == "Success"{
                                                            exploreVM.explorePostLoading = true
                                                        } else {
                                                            exploreVM.explorePostLoading = false
                                                            let res  = await exploreService.getExplorePosts(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(counter1))
                                                            if res == "Success"{
                                                                exploreVM.explorePostLoading = true
                                                            } else {
                                                                exploreVM.explorePostLoading = false
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                }
                            }
                        }else {
                            VStack{
                                Spacer()
                                Image("NothingToSeeHereIllustration")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2)
                                Spacer()
                            }
                        }
                    } else {
                        if globalVM.exploreSearchPostList.count > 0 {
                            ForEach(0..<globalVM.exploreSearchPostList[0].posts.count, id: \.self) { id in
                                if globalVM.exploreSearchPostList[0].posts[id].displayStatus == "1" {
                                    ExplorePostCardView(post: globalVM.exploreSearchPostList[0].posts[id], imgData: globalVM.exploreSearchPostList[0].posts[id].media, loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                                        .onAppear{
                                            if globalVM.explorePostList[0].posts.count > 10 {
                                                if id == globalVM.explorePostList[0].posts.count - 2 {
                                                    counter2 = counter2 + 1
                                                    exploreService.getExplorePostsBySearch(globalVM: globalVM, userID: loginData.mainUserID, keyword: exploreVM.explorePostSearchText, pageNumber: String(counter2))
                                                }
                                            }
                                        }
                                }
                            }
                        }else {
                            VStack{
                            }
                        }
                    }
                }
                .padding(.horizontal)
                if !exploreVM.explorePostLoading {
                    ProgressView()
                }
                Rectangle()
                    .fill(.white)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/12)
            }
        }
    }
}

//struct ExplorePostListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExplorePostListView()
//    }
//}
