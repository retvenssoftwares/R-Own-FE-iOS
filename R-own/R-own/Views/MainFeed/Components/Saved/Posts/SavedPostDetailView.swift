//
//  SavedPostDetailView.swift
//  R-own
//
//  Created by Aman Sharma on 19/06/23.
//

import SwiftUI

struct SavedPostDetailView: View {
    
    @State var navigateToLikedUserListScreen: Bool = false
    @State var postID: String
    @State var newComment: String = ""
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var mainfeedService = MainFeedService()
    @State var navigateToProfileView: Bool = false
    
    @FocusState private var isKeyboardShowing: Bool
    
    
    @StateObject var profileService = ProfileService()
    @StateObject var saveService = SaveElemetsIDService()
    
    @State var showCommentSheet: Bool = false
    @State var currentIndex: Int = 0
    
    @State var isLoading: Bool = false
    
    
    
    var body: some View {
        NavigationStack{
            if isLoading {
                VStack {
                    BasicNavbarView(navbarTitle: "Post Details")
                    ScrollView{
                        HStack{
                            //profilepic
                            Button(action: {
                                navigateToProfileView.toggle()
                                print("move to profile screen")
                            }, label: {
                                ProfilePictureView(profilePic: globalVM.postDetails[0].profilePic, verified: globalVM.postDetails[0].verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                            })
                            .navigationDestination(isPresented: $navigateToProfileView, destination: {
                                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: globalVM.postDetails[0].role, mainUser: false, userID: loginData.mainUserID)
                            })
                            VStack(alignment: .leading) {
                                //name
                                Button(action: {
                                    navigateToProfileView.toggle()
                                    print("move to profile screen")
                                }, label: {
                                    Text(globalVM.postDetails[0].fullName)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .frame(alignment: .leading)
                                })
                                //profile
                                if globalVM.postDetails[0].jobTitle != "" {
                                    Text(globalVM.postDetails[0].jobTitle)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .fontWeight(.thin)
                                        .frame(alignment: .leading)
                                }
                                //location
                                if globalVM.postDetails[0].location != "" {
                                    Text(globalVM.postDetails[0].location)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .fontWeight(.thin)
                                        .frame(alignment: .leading)
                                }
                            }
                            
                            Spacer()
                            //time
                            Text(relativeTime(from: globalVM.postDetails[0].dateAdded) ?? "")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.thin)
                                .frame(alignment: .leading)
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .padding(.vertical, UIScreen.screenHeight/70)
                        
                        PostImageWithoutBottomNav(media: globalVM.postDetails[0].media, likeCount: $globalVM.postDetails[0].likeCount, postID: globalVM.postDetails[0].postID, loginData: loginData, posterID: globalVM.postDetails[0].userID, liked: $globalVM.postDetails[0].liked, saved: $globalVM.postDetails[0].saved, commentCount: $globalVM.postDetails[0].commentCount, globalVM: globalVM, currentIndex: $currentIndex)
                        
                        VStack (spacing: 0){
                            
                            HStack(spacing: 2) {
                                if globalVM.postDetails[0].media.count != 1 {
                                    ForEach((0..<globalVM.postDetails[0].media.count), id: \.self) { index in
                                        Circle()
                                            .fill(index == currentIndex ? Color.black : Color.black.opacity(0.3))
                                            .frame(width: UIScreen.screenHeight/130, height: UIScreen.screenHeight/130)
                                    }
                                }
                            }
                            HStack{
                                //likebutton
                                
                                Button(action: {
                                    if globalVM.postDetails[0].liked == "not liked" {
                                        mainfeedService.likePost(loginData: loginData, postID: globalVM.postDetails[0].postID, posterID: loginData.mainUserID)
                                        globalVM.postDetails[0].likeCount = globalVM.postDetails[0].likeCount + 1
                                        globalVM.postDetails[0].liked = "liked"
                                    } else {
                                        mainfeedService.likePost(loginData: loginData, postID: globalVM.postDetails[0].postID, posterID: loginData.mainUserID)
                                        globalVM.postDetails[0].likeCount = globalVM.postDetails[0].likeCount - 1
                                        globalVM.postDetails[0].liked = "not liked"
                                    }
                                }, label: {
                                    VStack {
                                        Image(globalVM.postDetails[0].liked == "not liked" ? "PostLikeBlack" : "PostLikedBlack" )
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                        if globalVM.postDetails[0].likeCount != 0 {
                                            Text(String(globalVM.postDetails[0].likeCount))
                                                .foregroundColor(.black)
                                                .font(.body)
                                                .fontWeight(.regular)
                                                .onTapGesture {
                                                    navigateToLikedUserListScreen.toggle()
                                                }
                                            
                                        }
                                        Spacer()
                                    }
                                })
                                
                                //comment
                                Button(action: {
                                    print("open comment screen")
                                    globalVM.commentList = CommentServiceModel(post: Post5355(id: "", userID: "", postID: "", comments: [Comment5355](), v: 0), commentCount: 0)
                                    mainfeedService.getCommentPost(globalVM: globalVM, postID: globalVM.postDetails[0].postID)
                                    showCommentSheet = true
                                }, label: {
                                    VStack {
                                        Image("PostCommentBlack")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                        if globalVM.postDetails[0].commentCount != 0 {
                                            Text(String(globalVM.postDetails[0].commentCount))
                                                .foregroundColor(.black)
                                                .font(.body)
                                                .fontWeight(.regular)
                                        }
                                        Spacer()
                                    }
                                })
                                .sheet(isPresented: $showCommentSheet) {
                                    CommentBottomSheetView(globalVM: globalVM, postID: globalVM.postDetails[0].postID, posterID: loginData.mainUserID, loginData: loginData, commentCount: $globalVM.postDetails[0].commentCount)
                                        .presentationDetents([.medium])
                                        .presentationDragIndicator(.visible)
                                }
                                Button(action: {
                                    print("open share bottomsheet")
                                    globalVM.getConnectionList = [ProfileConnectionListModel]()
                                    makeAPICall(globalVM: globalVM, userID:loginData.mainUserID)
                                    globalVM.showSharePostBottomSheet.toggle()
                                }, label: {
                                    VStack {
                                        Image("PostShareBlack")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                        Spacer()
                                    }
                                })
                                .sheet(isPresented: $globalVM.showSharePostBottomSheet) {
                                    SendImagePostBottomSheet(loginData: loginData, globalVM: globalVM, postID: globalVM.postDetails[0].postID, firstImageLink: globalVM.postDetails[0].media[0].post, caption: globalVM.postDetails[0].caption )
                                }
                                //save
                                Button(action: {
                                    print("saved")
                                    if globalVM.postDetails[0].saved == "not saved"{
                                        saveService.savePostID(loginData: loginData, postID: globalVM.postDetails[0].postID)
                                        globalVM.postDetails[0].saved = "saved"
                                    } else {
                                        saveService.unsavePostID(loginData: loginData, postID:globalVM.postDetails[0].postID)
                                        globalVM.postDetails[0].saved = "not saved"
                                    }
                                }, label: {
                                    VStack{
                                        Image(globalVM.postDetails[0].saved == "not saved" ? "PostSaveBlack" : "PostSavedBlack")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                            .padding(.bottom, UIScreen.screenHeight/100)
                                        Spacer()
                                    }
                                })
                                Spacer()
                            }
                        }
                        .frame(height: UIScreen.screenHeight/40)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .padding(.vertical, UIScreen.screenHeight/70)
                        //caption display
                        HStack{
                            VStack{
                                if globalVM.postDetails[0].userName != "" {
                                    Text(globalVM.postDetails[0].userName)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .frame(alignment: .leading)
                                } else {
                                    Text(globalVM.postDetails[0].fullName)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .frame(alignment: .leading)
                                }
                                Spacer()
                            }
                            VStack{
                                Text(globalVM.postDetails[0].caption)
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .frame(alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            Spacer()
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        
                        VStack{
                            VStack{
                                HStack{
                                    Text("Liked By")
                                        .font(.body)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                HStack{
                                    Text("\(globalVM.postDetails[0].likeCount) people have liked this.")
                                        .font(.body)
                                        .fontWeight(.medium)
                                    Spacer()
                                }
                            }
                            .padding(.vertical, UIScreen.screenHeight/70)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .onTapGesture {
                                navigateToLikedUserListScreen.toggle()
                            }
                            .navigationDestination(isPresented: $navigateToLikedUserListScreen, destination: {
                                LikedUserListView(globalVM: globalVM, postID: globalVM.postDetails[0].postID, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM)
                            })
                            Spacer()
                        }
                    }
                }
            } else {
                VStack{
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            makepostDEtailCall(globalVM: globalVM, userID: loginData.mainUserID, postID: postID)
            mainfeedService.getCommentPost(globalVM: globalVM, postID: loginData.notificationUserpostID)
        }
    }
    func makeAPICall(globalVM: GlobalViewModel, userID: String){
        
            Task{
                loginData.showLoader = true
                let res = await profileService.getConnectionsList(globalVM: globalVM, userID: userID)
                if res == "Success" {
                    loginData.showLoader = false
                } else {
                    makeAPICall(globalVM: globalVM, userID: userID)
                }
            }
    }
    func makepostDEtailCall(globalVM: GlobalViewModel, userID: String, postID: String){
        
            Task{
                isLoading = false
                let res = await profileService.getPostByID(globalVM: globalVM, userID: userID, postID: postID)
                if res == "Success" {
                    isLoading = true
                } else {
                    makeAPICall(globalVM: globalVM, userID: userID)
                }
            }
    }
}

//struct SavedPostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedPostDetailView()
//    }
//}
