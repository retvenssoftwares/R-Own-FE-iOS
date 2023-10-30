//
//  BlogsDetailThirdHaldView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct BlogsDetailThirdHalfView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    
    @Binding var saved: String
    
    @State var showCommentSheet: Bool = false
    
    @StateObject var blogService = BlogsService()
    @StateObject var saveService = SaveElemetsIDService()
    var body: some View {
        HStack{
            Spacer()
            if globalVM.blogByBlogID[0].like == "not liked" {
                Button(action: {
                    blogService.likeBlogs(loginData: loginData, blogID: globalVM.blogByBlogID[0].blogID)
                    globalVM.blogByBlogID[0].like = "liked"
                }, label: {
                    Image("PostLikeBlack")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                        .padding()
                })
            } else {
                Button(action: {
                    blogService.likeBlogs(loginData: loginData, blogID: globalVM.blogByBlogID[0].blogID)
                    globalVM.blogByBlogID[0].like = "not liked"
                }, label: {
                    Image("PostLikedBlack")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                        .padding()
                })
            }
            Spacer()
            Button(action: {
                showCommentSheet.toggle()
            }, label: {
                Image("PostCommentBlack")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                    .padding()
            })
            .sheet(isPresented: $showCommentSheet) {
                BlogCommentBottomSheetView(globalVM: globalVM, loginData: loginData, blogID: globalVM.blogByBlogID[0].blogID)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
            
            Spacer()
//            Image("PostShareBlack")
//                .resizable()
//                .scaledToFit()
//                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
//                .padding()
//            Spacer()
            if globalVM.blogByBlogID[0].saved == "not saved" {
                Button(action: {
                    saveService.saveBlogID(loginData: loginData, blogID: globalVM.blogByBlogID[0].blogID)
                    globalVM.blogByBlogID[0].saved = "saved"
                }, label: {
                    Image("PostSaveBlack")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                        .padding()
                })
            } else {
                Button(action: {
                    globalVM.blogByBlogID[0].saved = "not saved"
                    saveService.unsaveBlogID(loginData: loginData, blogID: globalVM.blogByBlogID[0].blogID)
                }, label: {
                    Image("PostSavedBlack")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                        .padding()
                })
            }
            Spacer()
            
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/10)
        .background(.white)
        .border(width: 1, edges: [.top], color: greenUi)
    }
}

//struct BlogsDetailThirdHaldView_Previews: PreviewProvider {
//    static var previews: some View {
//        BlogsDetailThirdHaldView()
//    }
//}
