//
//  LikedUserListView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct LikedUserListView: View {
    @StateObject var globalVM: GlobalViewModel
    @State var postID: String
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var onDataLoad: Bool = false
    @StateObject var mainfeedService = MainFeedService()
    @State var navigateToProfile: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                BasicNavbarView(navbarTitle: "Likes")
                ScrollView{
                    if onDataLoad {
                        VStack{
                            if globalVM.likesList.post.likes.count > 0 {
                                ForEach(0..<globalVM.likesList.post.likes.count, id: \.self){ count in
                                    if globalVM.likesList.post.likes[count].displayStatus == "1" {
                                        LikedUserTabView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, likedUser: globalVM.likesList.post.likes[count])
                                    }
                                    Divider()
                                }
                            } else  {
                                HStack{
                                    Spacer()
                                    Text("No likes yet")
                                        .font(.body)
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                    } else {
                        VStack{
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/40)
            .onAppear{
                Task{
                    globalVM.likesList = LikesModel(post: Post0343(id: "", postID: "", userID: "", likes: [Like0343](), v: 0), likeCount: 0)
                    let res = await mainfeedService.getLikesPost(globalVM: globalVM, postID: postID)
                    if res == "Success"{
                        onDataLoad.toggle()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct LikedUserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LikedUserListView()
//    }
//}
