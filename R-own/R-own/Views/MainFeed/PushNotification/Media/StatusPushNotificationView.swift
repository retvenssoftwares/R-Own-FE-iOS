//
//  StatusPushNotificationView.swift
//  R-own
//
//  Created by Aman Sharma on 14/07/23.
//

import SwiftUI

struct StatusPushNotificationView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var navigateToLikedUserListScreen: Bool = false
    @StateObject var mainfeedService = MainFeedService()
    @StateObject var profileService = ProfileService()
    @StateObject var saveService = SaveElemetsIDService()
    
    @State var showCommentSheet: Bool = false
    @State var navigateToProfileView: Bool = false
    
    @State var currentIndex: Int = 0
    
    @State var isLoading: Bool = false
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State private var isExpanded = false
    @State private var totalLines: Int = 0
    
    @State var mainFeedService = MainFeedService()
    @State var isPushNotification: Bool
    @State var postID: String
    
    //back button var
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack{
            if isLoading {
                VStack {
                    VStack{
                        HStack{
                            Button(action: {
                                if isPushNotification{
                                    loginData.notificationNormalPostPostView.toggle()
                                } else {
                                    presentationMode.wrappedValue.dismiss()
                                }
                                
                            }, label: {
                                Image(systemName: "arrow.backward.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                    .foregroundColor(.black)
                            })
                            Spacer()
                        }
                        .border(width: 1, edges: [.bottom], color: .black)
                    }
                    ScrollView{
                        VStack{
                            if globalVM.postDetails[0].fullName != "" {
                                VStack{
                                    HStack{
                                        //profilepic
                                        ProfilePictureView(profilePic: globalVM.postDetails[0].profilePic, verified: globalVM.postDetails[0].verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/30, width: UIScreen.screenHeight/30)
                                            .onTapGesture {
                                                navigateToProfileView.toggle()
                                                print("move to profile screen")
                                            }
                                            .navigationDestination(isPresented: $navigateToProfileView, destination: {
                                                if globalVM.postDetails[0].role != "" {
                                                    ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: globalVM.postDetails[0].role, mainUser: false, userID: globalVM.postDetails[0].userID)
                                                }
                                            })
                                        VStack(alignment: .leading) {
                                            //name
                                            Text(globalVM.postDetails[0].fullName)
                                                .foregroundColor(.black)
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .frame(alignment: .leading)
                                                .onTapGesture {
                                                    navigateToProfileView.toggle()
                                                    print("move to profile screen")
                                                }
                                            //profile
                                            if globalVM.postDetails[0].jobTitle != "" {
                                                Text(globalVM.postDetails[0].jobTitle == "" ? "" : globalVM.postDetails[0].jobTitle)
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
                                            .padding(.leading, 30)
                                            .frame(alignment: .leading)
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
                                    
                                }
                                if globalVM.postDetails[0].caption != "" {
                                    HStack{
                                        VStack(alignment: .leading, spacing: 3) {
                                            if totalLines <= 3 || isExpanded {
                                                Text(globalVM.postDetails[0].caption)
                                                    .font(.body)
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.leading)
                                                    .lineLimit(isExpanded ? nil : 3)
                                                    .background(
                                                        GeometryReader { geometry in
                                                            Color.clear.onAppear {
                                                                totalLines = getNumberOfLines(for: globalVM.postDetails[0].caption, in: geometry.size, font: .systemFont(ofSize: UIScreen.screenHeight/70))
                                                            }
                                                            .onChange(of: globalVM.postDetails[0].caption) { _ in
                                                                totalLines = getNumberOfLines(for: globalVM.postDetails[0].caption, in: geometry.size, font: .systemFont(ofSize: UIScreen.screenHeight/70))
                                                            }
                                                        }
                                                    )
                                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                                    .padding(.vertical, UIScreen.screenHeight/30)
                                                    .frame(width: UIScreen.screenWidth/1.2)
                                            } else {
                                                VStack(alignment: .leading, spacing: 4) {
                                                    ForEach(0..<3) { index in
                                                        Text(getTextForLine(at: index))
                                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                                            .frame(width: UIScreen.screenWidth/1.2)
                                                    }
                                                }
                                                .font(.body)
                                            }
                                            
                                            if totalLines > 3 {
                                                Button(action: {
                                                    isExpanded.toggle()
                                                }) {
                                                    Text(isExpanded ? "Read Less" : "Read More")
                                                        .font(.body)
                                                        .foregroundColor(.black)
                                                        .fontWeight(.bold)
                                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                                }
                                            }
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                }
                                VStack{
                                    HStack{
                                        
                                        //likebutton
                                        VStack{
                                            Button(action: {
                                                if globalVM.postDetails[0].postID != "" {
                                                    if globalVM.postDetails[0].likeCount != 0 {
                                                        if globalVM.postDetails[0].liked == "not liked" {
                                                            mainFeedService.likePost(loginData: loginData, postID: globalVM.postDetails[0].postID, posterID: globalVM.postDetails[0].userID)
                                                            globalVM.postDetails[0].likeCount = globalVM.postDetails[0].likeCount + 1
                                                            globalVM.postDetails[0].liked = "Liked"
                                                        } else {
                                                            mainFeedService.likePost(loginData: loginData, postID: globalVM.postDetails[0].postID, posterID: globalVM.postDetails[0].userID)
                                                            globalVM.postDetails[0].likeCount = globalVM.postDetails[0].likeCount - 1
                                                            globalVM.postDetails[0].liked = "not liked"
                                                        }
                                                    }
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
                                                    }
                                                    Spacer()
                                                }
                                            })
                                        }
                                        //comment
                                        Button(action: {
                                            print("open comment screen")
                                            if globalVM.postDetails[0].postID != "" {
                                                globalVM.commentList = CommentServiceModel(post: Post5355(id: "", userID: "", postID: "", comments: [Comment5355](), v: 0), commentCount: 0)
                                                mainFeedService.getCommentPost(globalVM: globalVM, postID: globalVM.postDetails[0].postID)
                                                showCommentSheet = true
                                            }
                                        }, label: {
                                            VStack {
                                                Image("PostCommentBlack")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
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
                                            CommentBottomSheetView(globalVM: globalVM, postID: globalVM.postDetails[0].postID, posterID: globalVM.postDetails[0].userID, loginData: loginData, commentCount: $globalVM.postDetails[0].commentCount)
                                                .presentationDetents([.medium])
                                                .presentationDragIndicator(.visible)
                                        }
                                        
                                        //                    Button(action: {
                                        //                        print("open share bottomsheet")
                                        //                        globalVM.getConnectionList = [ProfileConnectionListModel]()
                                        //                        makeAPICall(globalVM: globalVM, userID: loginData.mainUserID)
                                        //                        globalVM.showSharePostBottomSheet.toggle()
                                        //                    }, label: {
                                        //                        VStack {
                                        //                            Image("PostShareBlack")
                                        //                                .resizable()
                                        //                                .scaledToFit()
                                        //                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                        //                                .padding(.horizontal, UIScreen.screenWidth/30)
                                        //                        }
                                        //                    })
                                        //                    .sheet(isPresented: $globalVM.showSharePostBottomSheet) {
                                        //                        if post.media.count > 0 {
                                        //                            SendImagePostBottomSheet(loginData: loginData, globalVM: globalVM, postID: post.postID, firstImageLink: post.media[0].post, caption: post.caption ?? "")
                                        //                        }
                                        //                    }
                                        
                                        //save
                                        //                    Button(action: {
                                        //                        print("saved")
                                        //                        if post.isSaved == "not saved"{
                                        //                            saveService.savePostID(loginData: loginData, postID: post.postID)
                                        //                            post.isSaved = "saved"
                                        //                        } else {
                                        //                            saveService.unsavePostID(loginData: loginData, postID: post.postID)
                                        //                            post.isSaved = "not saved"
                                        //                        }
                                        //                    }, label: {
                                        //                        Image(post.isSaved == "not saved" ? "PostSaveBlack" : "PostSavedBlack")
                                        //                            .resizable()
                                        //                            .scaledToFit()
                                        //                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                        //                            .padding(.horizontal, UIScreen.screenWidth/30)
                                        //                            .padding(.bottom, UIScreen.screenHeight/100)
                                        //                    })
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                }
                            }
                        }
                        .padding(.vertical, UIScreen.screenHeight/70)
                        .background(.white)
                        .cornerRadius(15)
                        .clipped()
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .padding(.vertical, UIScreen.screenHeight/70)
                        .frame(width: UIScreen.screenWidth)
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
            makepostDEtailCall(globalVM: globalVM, userID: loginData.mainUserID, postID: isPushNotification ? loginData.notificationUserpostID : postID)
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
    // Function to get the number of lines for a given text in a given size with a specified font
    func getNumberOfLines(for text: String, in size: CGSize, font: UIFont) -> Int {
        let boundingBox = text.boundingRect(with: CGSize(width: size.width, height: .greatestFiniteMagnitude),
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        let lineHeight = font.lineHeight
        return Int(boundingBox.height / lineHeight)
    }
    
    // Function to get the text content for a specific line index
    func getTextForLine(at index: Int) -> String {
        let lines = globalVM.postDetails[0].caption.split(separator: "\n")
        if index < lines.count {
            return String(lines[index])
        } else {
            return ""
        }
    }
}

//struct StatusPushNotificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatusPushNotificationView()
//    }
//}
