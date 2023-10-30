//
//  ExplorePostCardView.swift
//  R-own
//
//  Created by Aman Sharma on 31/05/23.
//

import SwiftUI
import Shimmer

struct ExplorePostCardView: View {
    
    @State var post: ExplorePost
    
    @State var imgData: [Media535]
    
    @State var navigateToImagePostDetailScreen: Bool = false
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            AsyncImage(url: currentUrl) { image in
                image
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth/3.4, height: (UIScreen.screenWidth/3.4)*1.33)
                .clipped()
                .onTapGesture {
                    print("imagePost is tapped")
                    navigateToImagePostDetailScreen.toggle()
                    print(post.liked)
                    print(post.likeCount)
                }
                .navigationDestination(isPresented: $navigateToImagePostDetailScreen, destination: {
                    PostDetailView(newComment: "", postProfilePic: post.profilePic ?? "", postUserFullName: post.fullName ?? "", postUserName: post.userName ?? "", postUserDesignation: "", postUserLocation: post.location, postTime: post.media[0].dateAdded, postCaption: post.caption ?? "", media: post.media, likeCount: $post.likeCount, commentCount: $post.commentCount, postID: post.postID, loginData: loginData, posterID: post.userID, globalVM: globalVM, liked: $post.liked, saved: $post.saved, verificationStatus: post.verificationStatus, profileVM: profileVM, role: "", mesiboVM: mesiboVM)
                })
            } placeholder: {
                Rectangle()
                    .fill(lightGreyUi)
                    .frame(width: UIScreen.screenWidth/3.4, height: (UIScreen.screenWidth/3.4)*1.33)
                    .shimmering(active: true)
            }
            .onAppear {
                if currentUrl == nil {
                    DispatchQueue.main.async {
                        currentUrl = URL(string: imgData[0].post)
                    }
                }
            }
        }
        .onAppear {
            if currentUrl == nil {
                DispatchQueue.main.async {
                    currentUrl = URL(string: imgData[0].post)
                }
            }
        }
    }
}

//struct ExplorePostCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExplorePostCardView()
//    }
//}
