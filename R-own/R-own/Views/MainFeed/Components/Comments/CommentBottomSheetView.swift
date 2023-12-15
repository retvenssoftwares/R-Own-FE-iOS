//
//  CommentBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 22/05/23.
//

import SwiftUI

struct CommentBottomSheetView: View {
    
    @StateObject var globalVM: GlobalViewModel
    
    @State var newComment: String = ""
    @StateObject var mainFeedService = MainFeedService()
    @State var postID: String
    @State var posterID: String
    @StateObject var loginData: LoginViewModel
    @Binding var commentCount: Int
    @State var replySelected: Bool = false
    @State var selectedProfilePic: String = ""
    @State var selectedCommentID: String = ""
    @State var selectedComment: String = ""
    @State var selectedCommentUserID: String = ""
    @State var selectedCommentUserName: String = ""
    @State var selectedCommentFullName: String = ""
    @State var replyCount: Int = 0
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var isLoadingNewComments: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Comments")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.vertical, UIScreen.screenHeight/60)
                .padding(.horizontal, UIScreen.screenWidth/30)
            ScrollView{
                VStack(alignment: .leading){
                    if isLoadingNewComments == false {
                        if globalVM.commentList.post.comments.count > 0 {
                            ForEach(0..<globalVM.commentList.post.comments.count, id: \.self){ count in
                                if globalVM.commentList.post.comments[count].displayStatus == "1"{
                                    CommentTabView(comment: globalVM.commentList.post.comments[count], replySelected: $replySelected, selectedCommentID: $selectedCommentID, selectedCommentUserName: $selectedCommentUserName, newComment: $newComment, replyCount: $replyCount, selectedComment: $selectedComment, selectedCommentFullName: $selectedCommentFullName, count: count)
                                }
                            }
                        } else {
                            HStack{
                                Spacer()
                                Text("No comment yet. Be first one to comment")
                                    .font(.body)
                                Spacer()
                            }
                        }
                    } else {
                        ProgressView()
                    }
                }
                .padding(.horizontal, UIScreen.screenWidth/40)
            }
            if replySelected {
                VStack(spacing: 0){
                    HStack{
                        Text("You are now replying to \(selectedCommentUserName != "" ? selectedCommentUserName : selectedCommentFullName)")
                            .font(.body)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Button(action: {
                            replySelected = false
                        }, label: {
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(greenUi)
                                .frame(width: UIScreen.screenHeight/60, height:  UIScreen.screenHeight/60)
                        })
                    }
                    .padding(.horizontal, UIScreen.screenWidth/20)
                    .frame(height: UIScreen.screenHeight/20)
                    .background(.black.opacity(0.4))
                    HStack(spacing: 0){
                        ProfilePictureView(profilePic: loginData.mainUserProfilePic, verified: false, height: UIScreen.screenHeight/25, width: UIScreen.screenHeight/25)
                        TextField("Add your thoughts about this...", text: $newComment)
                            .font(.body)
                            .focused($isKeyboardShowing)
                        Spacer()
                        Button(action: {
                            print("Post reply")
                            if newComment != "" {
                                
                                isLoadingNewComments = true
                                mainFeedService.replyCommentPost(loginData: loginData, postID: postID, posterID: posterID, comment: newComment, parentCommentID: selectedCommentID)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    globalVM.commentList = CommentServiceModel(post: Post5355(id: "", userID: "", postID: "", comments: [Comment5355](), v: 0), commentCount: 0)
                                    mainFeedService.getCommentPost(globalVM: globalVM, postID: postID)
                                    isLoadingNewComments = false
                                }
                                replySelected = false
                                newComment = ""
                            }
                        }, label: {
                            Text("Post")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        })
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .frame(height: UIScreen.screenHeight/20)
                }
            } else {
                HStack(spacing: 0){
                    ProfilePictureView(profilePic: loginData.mainUserProfilePic, verified: false, height: UIScreen.screenHeight/25, width: UIScreen.screenHeight/25)
                        .padding(.trailing, UIScreen.screenWidth/40)
                    TextField("Add your thoughts about this...", text: $newComment)
                        .font(.body)
                        .focused($isKeyboardShowing)
                    Spacer()
                    Button(action: {
                        print("Post comment")
                        if newComment != "" {
                            isLoadingNewComments = true
                            mainFeedService.commentPost(loginData: loginData, postID: postID, posterID: posterID, comment: newComment)
//                            globalVM.commentList.post.comments.append(Comment5355(userID: loginData.mainUserID, comment: newComment, commentID: "", dateAdded: "few seconds ago", profilePic: loginData.mainUserProfilePic, userName: loginData.mainUserUserName, fullName: loginData.mainUserFullName, verificationStatus: "", role: "", displayStatus: "1", id: "", replies: [Reply5355]()))
                            commentCount += 1
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                globalVM.commentList = CommentServiceModel(post: Post5355(id: "", userID: "", postID: "", comments: [Comment5355](), v: 0), commentCount: 0)
                                mainFeedService.getCommentPost(globalVM: globalVM, postID: postID)
                                isLoadingNewComments = false
                            }
                            newComment = ""
                        }
                    }, label: {
                        Text("Post")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    })
                }
                .padding(.horizontal, UIScreen.screenWidth/40)
                .frame(height: UIScreen.screenHeight/20)
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
        .onAppear {
            globalVM.commentList = CommentServiceModel(post: Post5355(id: "", userID: "", postID: "", comments: [Comment5355](), v: 0), commentCount: 0)
            mainFeedService.getCommentPost(globalVM: globalVM, postID: postID)
        }
    }
}

//struct CommentBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentBottomSheetView()
//    }
//}
