//
//  SavedPostListView.swift
//  R-own
//
//  Created by Aman Sharma on 19/06/23.
//

import SwiftUI

struct SavedPostListView: View {
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var saveService = SaveElemetsIDService()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var counter: Int = 1
    
    var body: some View {
        ScrollView {
            if globalVM.getSavePostList[0].posts.count > 0 {
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0..<globalVM.getSavePostList[0].posts.count, id: \.self) { id in
                        SavedPostsCardView(post: globalVM.getSavePostList[0].posts[id], loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                            .onAppear{
                                if id == globalVM.getSavePostList[0].posts.count - 2 {
                                    counter = counter + 1
                                    saveService.getSavePost(globalVM: globalVM, userID: loginData.mainUserID, pageNo: counter)
                                }
                            }
                    }
                }
                .padding(.horizontal, UIScreen.screenWidth/30)
            } else {
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Image("NothingToSeeHereIllustration")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .onAppear{
            globalVM.getSavePostList = [GetSavePostModel(posts: [PostSave](), page: 0, pageSize: 0)]
            saveService.getSavePost(globalVM: globalVM, userID: loginData.mainUserID, pageNo: 1)
        }
    }
}

//struct SavedPostListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedPostListView()
//    }
//}
