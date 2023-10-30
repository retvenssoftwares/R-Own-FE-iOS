//
//  BlogCommentBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 24/07/23.
//

import SwiftUI

struct BlogCommentBottomSheetView: View {
    
    @StateObject var globalVM: GlobalViewModel
    
    @State var newComment: String = ""
    @StateObject var loginData: LoginViewModel
    @State var replySelected: Bool = false
    @State var selectedProfilePic: String = ""
    @State var selectedCommentID: String = ""
    @State var selectedComment: String = ""
    @State var selectedCommentUserID: String = ""
    @State var selectedCommentUserName: String = ""
    @State var selectedCommentFullName: String = ""
    @State var replyCount: Int = 0
    @State var blogID: String
    @StateObject var blogService = BlogsService()
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Comments")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.vertical, UIScreen.screenHeight/60)
            ScrollView{
                VStack(alignment: .leading){
                    if globalVM.blogByBlogID[0].comments.count > 0 {
                        ForEach(0..<globalVM.blogByBlogID[0].comments.count, id: \.self){ count in
                            if globalVM.blogByBlogID[0].comments[count].displayStatus == "1"{
                                CommentTabView(comment: globalVM.blogByBlogID[0].comments[count], replySelected: $replySelected, selectedCommentID: $selectedCommentID, selectedCommentUserName: $selectedCommentUserName, newComment: $newComment, replyCount: $replyCount, selectedComment: $selectedComment, selectedCommentFullName: $selectedCommentFullName, count: count)
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
                }
                .padding(.horizontal, UIScreen.screenWidth/40)
            }
            if replySelected {
                VStack(spacing: 0){
                    HStack{
                        Text("You are now replying to \(selectedCommentUserName != "" ? selectedCommentUserName : selectedCommentFullName)")
                            .font(.body)
                        Spacer()
                        Button(action: {
                            replySelected = false
                            newComment = ""
                        }, label: {
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(greenUi)
                                .frame(width: UIScreen.screenHeight/70, height:  UIScreen.screenHeight/70)
                        })
                    }
                    .padding(.horizontal, UIScreen.screenWidth/20)
                    .frame(height: UIScreen.screenHeight/20)
                    .background(.black.opacity(0.4))
                    HStack{
                        ProfilePictureView(profilePic: loginData.mainUserProfilePic, verified: false, height: UIScreen.screenHeight/30, width: UIScreen.screenHeight/30)
                        TextField("Add your thoughts about this...", text: $newComment)
                            .focused($isKeyboardShowing)
                            .font(.body)
                            
                        Button(action: {
                            print("Post reply")
                            if newComment != "" {
                                
                                blogService.replycommentBlogs(loginData: loginData, blogID: globalVM.blogByBlogID[0].blogID, comment: newComment, commentID: selectedCommentID)
                                globalVM.blogByBlogID[0].comments[replyCount].replies!.append(Reply5355(userID: loginData.mainUserID, comment: newComment, commentID: "", parentCommentID: "", dateAdded: "few seconds ago", displayStatus: "1", profilePic: loginData.mainUserProfilePic, userName: loginData.mainUserUserName, fullName: loginData.mainUserFullName, id: ""))
                                print(globalVM.blogByBlogID[0].comments[replyCount].replies!)
                                newComment = ""
                                replySelected = false
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
                    .clipped()
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                }
            } else {
                HStack{
                    ProfilePictureView(profilePic: loginData.mainUserProfilePic, verified: false, height: UIScreen.screenHeight/45, width: UIScreen.screenHeight/45)
                    TextField("Add your thoughts about this...", text: $newComment)
                        .focused($isKeyboardShowing)
                        .font(.body)
                    Button(action: {
                        print("Post comment")
                        if newComment != "" {
                            blogService.commentBlogs(loginData: loginData, blogID: globalVM.blogByBlogID[0].blogID, comment: newComment)
                            globalVM.blogByBlogID[0].comments.append(Comment5355(userID: loginData.mainUserID, comment: newComment, commentID: "", dateAdded: "few seconds ago", profilePic: loginData.mainUserProfilePic, userName: loginData.mainUserUserName, fullName: loginData.mainUserFullName, verificationStatus: "", role: "", displayStatus: "1", id: "", replies: [Reply5355]()))
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
                .clipped()
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
            }
        }
        .padding(.horizontal, UIScreen.screenWidth/30)
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
    }
}

//struct BlogCommentBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        BlogCommentBottomSheetView()
//    }
//}
