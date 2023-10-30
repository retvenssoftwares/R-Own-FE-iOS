//
//  NormalStatusHomeFeedView.swift
//  R-own
//
//  Created by Aman Sharma on 11/06/23.
//

import SwiftUI

struct NormalStatusHomeFeedView: View {
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @State var post: NewFeedPost
    @StateObject var mesiboVM: MesiboViewModel
    @State var showCommentSheet: Bool = false
    
    @State var likeStatus: Bool = false
    @State var saveStatus: Bool = false
    
    @State var mainFeedService = MainFeedService()
    @State var profileService = ProfileService()
    @State var saveService = SaveElemetsIDService()
    @State var navigateToProfileView: Bool = false
    
    @State private var isExpanded = false
    @State private var totalLines: Int = 0
    
    var body: some View {
        VStack{
            if post.fullName ?? "" != "" {
                
                if post.role ?? "" != "" {
                    VStack{
                        HStack{
                            //profilepic
                            NavigationLink(destination: {
                                
                                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: post.role!, mainUser: false, userID: post.userID)
                            }, label: {
                                ProfilePictureView(profilePic: post.profilePic ?? "", verified: post.verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                            })
                            VStack(alignment: .leading) {
                                //name
                                Text(post.fullName!)
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                                    .onTapGesture {
                                        navigateToProfileView.toggle()
                                        print("move to profile screen")
                                    }
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
                            Text(relativeTime(from: post.dateAdded) ?? "")
                                .foregroundColor(.black)
                                .font(.footnote)
                                .fontWeight(.thin)
                                .padding(.leading, 30)
                                .frame(alignment: .leading)
                        }
                        .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
                        
                    }
                    if post.caption != "" {
                        HStack{
                            VStack(alignment: .leading, spacing: 3) {
                                if totalLines <= 3 || isExpanded {
                                    Text(post.caption)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(isExpanded ? nil : 3)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                        .background(
                                            GeometryReader { geometry in
                                                Color.clear.onAppear {
                                                    totalLines = getNumberOfLines(for: post.caption, in: geometry.size, font: .systemFont(ofSize: UIScreen.screenHeight/70))
                                                }
                                                .onChange(of: post.caption) { _ in
                                                    totalLines = getNumberOfLines(for: post.caption, in: geometry.size, font: .systemFont(ofSize: UIScreen.screenHeight/70))
                                                }
                                            }
                                        )
                                        .frame(width: UIScreen.screenWidth/1.2)
                                } else {
                                    VStack(alignment: .leading, spacing: 4) {
                                        ForEach(0..<2) { index in
                                            Text(getTextForLine(at: index))
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding(.horizontal, UIScreen.screenWidth/30)
                                                .frame(width: UIScreen.screenWidth/1.2)
                                                .multilineTextAlignment(.leading)
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
                    
                    Divider()
                        .frame(width: UIScreen.screenWidth/1.3)
                    
                    VStack{
                        HStack(spacing: UIScreen.screenWidth/30){
                            
                            //likebutton
                            VStack{
                                Button(action: {
                                    if post.postID ?? "" != "" {
                                        if post.likeCount != nil {
                                            if post.like == "not liked" {
                                                mainFeedService.likePost(loginData: loginData, postID: post.postID!, posterID: post.userID)
                                                post.likeCount = post.likeCount! + 1
                                                post.like = "Liked"
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
                                        if post.likeCount! != 0 {
                                            Text(String(post.likeCount!))
                                                .foregroundColor(.black)
                                                .font(.footnote)
                                                .fontWeight(.regular)
                                        }
                                        Spacer()
                                    }
                                })
                            }
                            
                            //comment
                            Button(action: {
                                print("open comment screen")
                                if post.postID ?? "" != "" {
                                    globalVM.commentList = CommentServiceModel(post: Post5355(id: "", userID: "", postID: "", comments: [Comment5355](), v: 0), commentCount: 0)
                                    mainFeedService.getCommentPost(globalVM: globalVM, postID: post.postID!)
                                    showCommentSheet = true
                                }
                            }, label: {
                                VStack {
                                    Image("PostCommentBlack")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                    if post.commentCount != 0 {
                                        Text(String(post.commentCount!))
                                            .foregroundColor(.black)
                                            .font(.footnote)
                                            .fontWeight(.regular)
                                    }
                                    Spacer()
                                }
                            })
                            .sheet(isPresented: $showCommentSheet) {
                                CommentBottomSheetView(globalVM: globalVM, postID: post.postID!, posterID: post.userID, loginData: loginData, commentCount: $post.commentCount.toUnwrapped(defaultValue: 0))
                                    .presentationDetents([.medium])
                                    .presentationDragIndicator(.visible)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    }
                }
            }
        }
        .padding(.vertical, UIScreen.screenHeight/70)
        .background(.white)
        .cornerRadius(15)
        .clipped()
        .shadow(color: .black.opacity(0.2), radius: 2)
        .padding(.vertical, UIScreen.screenHeight/70)
        .frame(width: UIScreen.screenWidth)
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

//struct NormalStatusHomeFeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalStatusHomeFeedView()
//    }
//}
