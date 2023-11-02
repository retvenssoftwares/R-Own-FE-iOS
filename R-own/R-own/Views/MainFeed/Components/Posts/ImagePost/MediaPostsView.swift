//
//  PostsView.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import SwiftUI

struct MediaPostsView: View {
    
    @Binding var post: NewFeedPost
    
    @State var currentIndex: Int = 0
    
    @State var navigateToPostDetailView: Bool = false
    @State var navigateToImageDetailView: Bool = false
    @State var navigateToProfileDetailView: Bool = false
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var showCommentSheet: Bool = false
    @State var navigateToProfileView: Bool = false
    
    @StateObject var saveService = SaveElemetsIDService()
    @StateObject var mainFeedService = MainFeedService()
    @StateObject var profileService = ProfileService()
    
    @State private var isExpanded = false
    @State private var totalLines: Int = 0
    
    var body: some View {
        NavigationStack{
            if post.fullName ?? "" != "" {
                
                if post.role ?? "" != "" {
                    NavigationLink(destination: PostDetailView(newComment: "", postProfilePic: post.profilePic ?? "", postUserFullName: post.fullName!, postUserName: post.userName, postUserDesignation: post.jobTitle, postUserLocation: post.location, postTime: post.dateAdded, postCaption: post.caption , media: post.media, likeCount: $post.likeCount.toUnwrapped(defaultValue: 0), commentCount: $post.commentCount.toUnwrapped(defaultValue: 0), postID: post.postID!, loginData: loginData, posterID: post.userID, globalVM: globalVM, liked: $post.like.toUnwrapped(defaultValue: "not liked"), saved: $post.isSaved.toUnwrapped(defaultValue: "not saved"), verificationStatus: post.verificationStatus ?? "false", profileVM: profileVM, role: post.role!, mesiboVM: mesiboVM), isActive: $navigateToPostDetailView, label: {
                        Text("")
                    })
                    VStack{
                        VStack{
                            NavigationLink(isActive: $navigateToProfileView, destination: {
                                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: post.role!, mainUser: false, userID: post.userID)
                            }, label: {Text("")})
                            HStack{
                                //profilepic
                                
                                
                                ProfilePictureView(profilePic: post.profilePic ?? "", verified: post.verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/18, width: UIScreen.screenHeight/18)
                                    .onTapGesture {
                                        navigateToProfileView.toggle()
                                        print("move to profile screen")
                                    }
                                    .navigationDestination(isPresented: $navigateToProfileView, destination: {
                                        ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: post.role!, mainUser: false, userID: post.userID)
                                    })
                                
                                VStack(alignment: .leading) {
                                    //name
                                    Text(post.fullName!)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .frame(alignment: .leading)
                                        .onTapGesture {
                                            navigateToProfileView.toggle()
                                            print("move to profile screen")
                                        }
                                        .navigationDestination(isPresented: $navigateToProfileView, destination: {
                                            ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: post.role!, mainUser: false, userID: post.userID)
                                        })
                                    //profile
                                    if post.jobTitle != "" {
                                        Text(post.jobTitle)
                                            .foregroundColor(.black)
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                            .frame(alignment: .leading)
                                    }
                                    //location
                                    if post.location != "" {
                                        Text(post.location)
                                            .foregroundColor(.black)
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                            .frame(alignment: .leading)
                                    }
                                }
                                Spacer()
                                //time
                                Text(relativeTime(from: post.media[0].dateAdded) ?? "")
                                    .foregroundColor(.black)
                                    .font(.footnote)
                                    .fontWeight(.thin)
                                    .padding(.leading, 30)
                                    .frame(alignment: .leading)
                            }
                            .frame(width: UIScreen.screenWidth/1.1)
                            
                            
                            NavigationLink(isActive: $navigateToImageDetailView, destination: {
                                ImagePostDetailScreen(post: $post, globalVM: globalVM, loginData: loginData)
                            }, label: {Text("")})
                            
                            NewFeedPostImageView(post: $post, currentIndex: $currentIndex, loginData: loginData, globalVM: globalVM)
                                .padding(.top, UIScreen.screenHeight/100)
                                .onTapGesture {
                                    navigateToImageDetailView.toggle()
                                }
                                .navigationDestination(isPresented: $navigateToImageDetailView, destination: {
                                    ImagePostDetailScreen(post: $post, globalVM: globalVM, loginData: loginData)
                                })
                            
                            //caption display
                            VStack{
                                HStack(spacing: 2) {
                                    if post.media.count != 1 {
                                        ForEach((0..<post.media.count), id: \.self) { index in
                                            Circle()
                                                .fill(index == currentIndex ? Color.black : Color.black.opacity(0.3))
                                                .frame(width: UIScreen.screenHeight/130, height: UIScreen.screenHeight/130)
                                        }
                                    }
                                }
                                HStack(spacing: 5){
                                    VStack{
                                        NavigationLink(destination: {
                                            ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: post.role!, mainUser: false, userID: post.userID)
                                        }, label: {
                                            Text(post.userName == "" ? post.fullName! : post.userName)
                                                .foregroundColor(.black)
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .frame(alignment: .leading)
                                        })
                                        Spacer()
                                    }
                                    if post.caption != "" {
                                        HStack{
                                            VStack(alignment: .leading, spacing: 3) {
                                                if totalLines <= 3 || isExpanded {
                                                    Text(post.caption )
                                                        .font(.body)
                                                        .foregroundColor(.black)
                                                        .multilineTextAlignment(.leading)
                                                        .lineLimit(isExpanded ? nil : 3)
                                                        .background(
                                                            GeometryReader { geometry in
                                                                Color.clear.onAppear {
                                                                    totalLines = getNumberOfLines(for: post.caption, in: geometry.size, font: .systemFont(ofSize: UIScreen.screenHeight/80))
                                                                }
                                                                .onChange(of: post.caption) { _ in
                                                                    totalLines = getNumberOfLines(for: post.caption, in: geometry.size, font: .systemFont(ofSize: UIScreen.screenHeight/80))
                                                                }
                                                            }
                                                        )
                                                } else {
                                                    VStack(alignment: .leading, spacing: 4) {
                                                        ForEach(0..<3) { index in
                                                            Text(getTextForLine(at: index))
                                                                .font(.body)
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
                                                    }
                                                }
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                    }
                                    Spacer()
                                }
                                .padding(.top, UIScreen.screenHeight/100)
                                .frame(width: UIScreen.screenWidth/1.1)
                                Divider()
                                    .frame(width: UIScreen.screenWidth/1.1)
                                VStack{
                                    HStack(spacing: UIScreen.screenWidth/30){
                                        
                                        //likebutton
                                        
                                        Button(action: {
                                            if post.postID ?? "" != "" {
                                                if post.likeCount != nil {
                                                    if post.like == "not liked" {
                                                        mainFeedService.likePost(loginData: loginData, postID: post.postID!, posterID: post.userID)
                                                        post.likeCount = post.likeCount! + 1
                                                        post.like = "liked"
                                                    } else {
                                                        mainFeedService.likePost(loginData: loginData, postID: post.postID!, posterID: post.userID)
                                                        post.likeCount = post.likeCount! - 1
                                                        post.like = "not liked"
                                                    }
                                                }
                                            }
                                        }, label: {
                                            VStack {
                                                Image(post.like == "not liked" ? "PostLikeBlack" : "PostLikedBlack" )
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                                if post.likeCount != nil {
                                                    if post.likeCount! != 0 {
                                                        Text(String(post.likeCount!))
                                                            .foregroundColor(.black)
                                                            .font(.footnote)
                                                            .fontWeight(.regular)
                                                    }
                                                }
                                                Spacer()
                                            }
                                        })
                                        //comment
                                        Button(action: {
                                            print("open comment screen")
                                            showCommentSheet = true
                                        }, label: {
                                            VStack {
                                                Image("PostCommentBlack")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                                if post.commentCount != nil {
                                                    if post.commentCount! != 0 {
                                                        Text(String(post.commentCount!))
                                                            .foregroundColor(.black)
                                                            .font(.footnote)
                                                            .fontWeight(.regular)
                                                    }
                                                }
                                                Spacer()
                                            }
                                        })
                                        .sheet(isPresented: $showCommentSheet) {
                                            if post.postID ?? "" != "" {
                                                CommentBottomSheetView(globalVM: globalVM, postID: post.postID ?? "", posterID: post.userID, loginData: loginData, commentCount: $post.commentCount.toUnwrapped(defaultValue: 0))
                                                    .presentationDetents([.medium, .large])
                                                    .presentationDragIndicator(.visible)
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            print("open share bottomsheet")
                                            globalVM.getConnectionList = [ProfileConnectionListModel]()
                                            makeAPICall(globalVM: globalVM, userID: loginData.mainUserID)
                                            globalVM.showSharePostBottomSheet.toggle()
                                        }, label: {
                                            VStack {
                                                VStack{
                                                    Image("PostShareBlack")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                                    Spacer()
                                                }
                                            }
                                        })
                                        .sheet(isPresented: $globalVM.showSharePostBottomSheet) {
                                            if post.postID ?? "" != "" {
                                                SendImagePostBottomSheet(loginData: loginData, globalVM: globalVM, postID: post.postID ?? "", firstImageLink: post.media[0].post, caption: post.caption )
                                            }
                                        }
                                        
                                        //save
                                        Button(action: {
                                            print("saved")
                                            
                                            if post.postID ?? "" != "" {
                                                if post.isSaved == "not saved"{
                                                    saveService.savePostID(loginData: loginData, postID: post.postID!)
                                                    post.isSaved = "saved"
                                                } else {
                                                    saveService.unsavePostID(loginData: loginData, postID: post.postID!)
                                                    post.isSaved = "not saved"
                                                }
                                            }
                                        }, label: {
                                            VStack{
                                                Image(post.isSaved == "not saved" ? "PostSaveBlack" : "PostSavedBlack")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                                Spacer()
                                            }
                                        })
                                        
                                    }
                                    .frame(width: UIScreen.screenWidth/1.1)
                                }
                            }
                        }
                    }
                    .padding(.top, UIScreen.screenHeight/80)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .padding(.horizontal, UIScreen.screenWidth/30)
                    .frame(width: UIScreen.screenWidth)
                    .onTapGesture {
                        navigateToPostDetailView.toggle()
                    }
                }
            }
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
        let lines = post.caption.split(separator: "\n")
        if index < lines.count {
            return String(lines[index])
        } else {
            return ""
        }
    }
}

//struct PostsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostsView()
//    }
//}
