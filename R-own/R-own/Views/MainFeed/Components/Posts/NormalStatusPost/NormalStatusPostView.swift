//
//  NormalStatusPostView.swift
//  R-own
//
//  Created by Aman Sharma on 31/05/23.
//

import SwiftUI

struct NormalStatusPostView: View {
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @State var post: Post583
    @State var showCommentSheet: Bool = false
    
    @State var likeStatus: Bool = false
    @State var saveStatus: Bool = false
    @State var mainFeedService = MainFeedService()
    @State var saveService = SaveElemetsIDService()
    @State var liked: String = "not liked"
    @State var saved: String = "not saved"
    @State var showEditPost: Bool = false
    @State var showEditSheet: Bool = false
    @State var showDeletePost: Bool = false
    @StateObject var postService = PostsService()
    @FocusState private var isKeyboardShowing: Bool
    @State var mainUser: Bool
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    //profilepic
                    
                    ProfilePictureView(profilePic: post.profilePic, verified: post.verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/30, width: UIScreen.screenHeight/30)
                    VStack(alignment: .leading) {
                        //name
                        Text(post.fullName)
                            .foregroundColor(.black)
                            .font(.body)
                            .fontWeight(.bold)
                            .frame(alignment: .leading)
                            .onTapGesture {
                                print("move to profile screen")
                            }
                        //profile
                        if post.jobTitle != "" {
                            Text(post.jobTitle)
                                .foregroundColor(.black)
                                .font(.subheadline)
                                .fontWeight(.thin)
                                .frame(alignment: .leading)
                        }
                        //location
                        if post.location != "" {
                            Text(post.location)
                                .foregroundColor(.black)
                                .font(.subheadline)
                                .fontWeight(.thin)
                                .frame(alignment: .leading)
                        }
                    }
                    Spacer()
                    //time
                    Text(relativeTime(from: post.dateAdded) ?? "")
                        .foregroundColor(.black)
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .padding(.leading, 30)
                        .frame(alignment: .leading)
                }
                .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
                    
                
                

            }
            VStack{
                if post.caption ?? "" != "" {
                    HStack{
                        Text(post.caption ?? "")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
                            .padding(.vertical, UIScreen.screenHeight/60)
                        Spacer()
                    }
                }
            }
            VStack{
                HStack{
                    //likebutton
                        Button(action: {
                            if liked == "not liked" {
                                mainFeedService.likePost(loginData: loginData, postID: post.postID, posterID: post.userID)
                                post.likeCount = post.likeCount + 1
                                liked = "Liked"
                            } else {
                                mainFeedService.likePost(loginData: loginData, postID: post.postID, posterID: post.userID)
                                post.likeCount = post.likeCount - 1
                                liked = "not liked"
                            }
                        }, label: {
                            VStack {
                                Image(liked == "not liked" ? "PostLikeBlack" : "PostLikedBlack" )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                if post.likeCount > 0 {
                                    Text(String(post.likeCount))
                                        .foregroundColor(.white)
                                        .font(.footnote)
                                        .fontWeight(.regular)
                                }
                            }
                        })
                    //comment
                    Button(action: {
                        print("open comment screen")
                        mainFeedService.getCommentPost(globalVM: globalVM, postID: post.postID)
                        showCommentSheet = true
                    }, label: {
                        VStack {
                            Image("PostCommentBlack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            if post.commentCount > 0 {
                                Text(String(post.commentCount))
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                            }
                        }
                    })
                    .sheet(isPresented: $showCommentSheet) {
                        CommentBottomSheetView(globalVM: globalVM, postID: post.postID, posterID: post.userID, loginData: loginData, commentCount: $post.commentCount)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                    }
                    Spacer()
                }
                .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
            }
        }
        .padding(.vertical, UIScreen.screenHeight/70)
        .background(.white)
        .cornerRadius(15)
        .clipped()
        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
        .padding(.vertical, UIScreen.screenHeight/70)
        .padding(.horizontal, UIScreen.screenWidth/30)
        .frame(width: UIScreen.screenWidth)
        .onLongPressGesture(perform: {
            if mainUser {
                showEditSheet = true
            }
        })
        .sheet(isPresented: $showEditSheet, content: {
            VStack{
                Button(action: {
                    showEditPost = true
                }, label: {
                    HStack{
                        Image("CommunityEditIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                        Text("Edit Post")
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                    }
                })
                .sheet(isPresented: $showEditPost, content: {
                    VStack{
                        Text("Edit your post")
                        VStack{
                            //                                VStack(alignment: .leading){
                            //                                    Text(loginData.mainUserFullName)
                            //                                        .font(.system(size: UIScreen.screenHeight/60))
                            //                                        .fontWeight(.bold)
                            //                                    HStack{
                            //                                        HStack{
                            //                                            Image("PostsCanSeeIcon")
                            //                                                .resizable()
                            //                                                .scaledToFit()
                            //                                                .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                            //
                            //                                            if canSeeAudienceName == "" {
                            //                                                Text("Can See")
                            //                                                    .font(.system(size: UIScreen.screenHeight/90))
                            //                                            } else {
                            //                                                Text(canSeeAudienceName)
                            //                                                    .font(.system(size: UIScreen.screenHeight/90))
                            //                                            }
                            //
                            //                                            Image(systemName: "chevron.down")
                            //                                                .resizable()
                            //                                                .scaledToFit()
                            //                                                .frame(width: UIScreen.screenHeight/100, height: UIScreen.screenHeight/100)
                            //                                        }
                            //                                        .padding(5)
                            //                                        .background(.white)
                            //                                        .cornerRadius(5)
                            //                                        .overlay(RoundedRectangle(cornerRadius: 10)
                            //                                            .stroke(.black, lineWidth: 1))
                            //                                        .onTapGesture {
                            //                                            createPostVM.canSeeAudienceBottomSheet.toggle()
                            //                                        }
                            //                                        HStack{
                            //                                            Image("PostsCanCommentIcon")
                            //                                                .resizable()
                            //                                                .scaledToFit()
                            //                                                .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                            //
                            //
                            //                                            if canCommentAudienceName == "" {
                            //                                                Text("Can Comment")
                            //                                                    .font(.system(size: UIScreen.screenHeight/90))
                            //                                            } else {
                            //                                                Text(canCommentAudienceName)
                            //                                                    .font(.system(size: UIScreen.screenHeight/90))
                            //                                            }
                            //
                            //                                            Image(systemName: "chevron.down")
                            //                                                .resizable()
                            //                                                .scaledToFit()
                            //                                                .frame(width: UIScreen.screenHeight/100, height: UIScreen.screenHeight/100)
                            //                                        }
                            //                                        .padding(5)
                            //                                        .background(.white)
                            //                                        .cornerRadius(5)
                            //                                        .overlay(RoundedRectangle(cornerRadius: 10)
                            //                                            .stroke(.black, lineWidth: 1))
                            //                                        .onTapGesture {
                            //                                            createPostVM.canCommentAudienceBottomSheet.toggle()
                            //                                        }
                            //                                    }
                            //                                }
                            
        //                                        AutoFetchLocationTab(autoLocation: $post.location, loginData: loginData, globalVM: globalVM, width: UIScreen.screenWidth/1.2)
                            
                            TextEditor(text: Binding(
                                get: { post.caption ?? "" },
                                set: { post.caption = $0 }
                            ))
                                .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenWidth/5)
                                .lineLimit(nil) // Allow multiple lines
                                .focused($isKeyboardShowing)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        
                                        Button("Done") {
                                            
                                            isKeyboardShowing = false
                                            globalVM.keyboardVisibility = false
                                        }
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.black.opacity(0.5), lineWidth: 1)
                                ) // Add border
                                .overlay{
                                    VStack{
                                        HStack{
                                            if post.caption == "" {
                                                Text("What do you want to share today?")
                                                    .foregroundColor(.black.opacity(0.5))
                                                    .padding()
                                            }
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                }
                                .onChange(of: post.caption) { newText in
                                    // Limit text to maxCharacterLimit
                                    if (post.caption ?? "").count > 6000 {
                                        post.caption = String((post.caption ?? "").prefix(6000))
                                    }
                                }
                            
                            Button(action: {
                                Task{
                                    loginData.showLoader = true
                                    let res = await postService.editPost(postID: post.postID, caption: (post.caption ?? ""), location: post.location, canSee: post.canSee ?? "Can See", Can_comment: (post.canComment ?? "Can Comment"))
                                    if res == "Success"{
                                        showEditPost = false
                                        showEditSheet = false
                                        globalVM.getStatusPostList = [ProfileStatusPostModel(page: 0, pageSize: 0, posts: [Post583]())]
                                        profileService.getStatusPosts(globalVM: globalVM, userID: loginData.mainUserID, loginData: loginData, page: "1")
                                        loginData.showLoader = false
                                    }
                                }
                            }, label: {
                                Text("Update")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                    .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/30)
                                    .background(greenUi)
                                    .cornerRadius(10)
                            })
                        }
                    }
                })
                
                
                Divider()
                
                Button(action: {
                    showDeletePost = true
                }, label: {
                    HStack{
                        Image("CommunityDeleteIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                        Text("Delete Post")
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                    }
                })
                .sheet(isPresented: $showDeletePost, content: {
                    VStack{
                        Text("Do you really want to delete this post?")
                            .font(.body)
                            .fontWeight(.medium)
                        
                        VStack{
                            Button(action: {
                                Task{
                                    loginData.showLoader = true
                                    let res = await postService.deletePost(postID: post.postID, display_status: "0")
                                    if res == "Success"{
                                        showEditSheet = false
                                        showDeletePost = false
                                        globalVM.getStatusPostList = [ProfileStatusPostModel(page: 0, pageSize: 0, posts: [Post583]())]
                                        profileService.getStatusPosts(globalVM: globalVM, userID: loginData.mainUserID, loginData: loginData, page: "1")
                                        loginData.showLoader = false
                                    }
                                }
                            }, label: {
                                Text("Yes, I'm sure")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                    .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/30)
                                    .background(greenUi)
                                    .cornerRadius(10)
                            })
                            
                            Button(action: {
                                showDeletePost = false
                            }, label: {
                                Text("No")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(greenUi)
                                    .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/30)
                                    .background(jobsDarkBlue)
                                    .cornerRadius(10)
                            })
                            
                            
                        }
                    }
                })
            }
        })

    }
}

//struct NormalStatusPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalStatusPostView()
//    }
//}
