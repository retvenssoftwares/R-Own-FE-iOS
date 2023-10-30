//
//  FeedCardView.swift
//  R-own
//
//  Created by Aman Sharma on 11/06/23.
//

import SwiftUI

struct FeedCardView: View {
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @State var posts: NewFeedPost
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    
    var body: some View {
        VStack{
            if posts.postType == "share some media" || posts.postType == "click and share" {
                MediaPostsView(post: $posts, loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
            } else if posts.postType == "Polls" {
                NewFeedPollsView(post: posts, loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
            } else if posts.postType == "Update about an event" {
                if loginData.isHiddenKPI {
//                    EventHomeFeedPostView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, post: posts, mesiboVM: mesiboVM)
                }
            } else if posts.postType == "normal status" {
                NormalStatusHomeFeedView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, post: posts, mesiboVM: mesiboVM)
            } else if posts.postType == "Check-in" {
                CheckInHomeFeedPostView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, post: posts, mesiboVM: mesiboVM)
            } else if posts.postType == "Admin Announcements" {
                AdminAnnouncementsView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, post: posts, mesiboVM: mesiboVM)
            } else if posts.postType == "Admin Informative" {
                AdminInformativePostView(post: $posts, loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
            } else if posts.postType == "Admin Advertisement" {
                AdminAdvertisementPostView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, post: posts, mesiboVM: mesiboVM)
            } else if posts.postType == "Admin Youtube Promo" {
                AdminYoutubePromoPostView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, post: posts, mesiboVM: mesiboVM)
            }
        }
    }
}

//struct FeedCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedCardView()
//    }
//}
