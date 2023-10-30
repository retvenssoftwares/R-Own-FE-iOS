//
//  AdminAnnouncements.swift
//  R-own
//
//  Created by Aman Sharma on 26/07/23.
//

import SwiftUI

struct AdminAnnouncementsView: View {
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
    
    var body: some View {
        VStack{
            if post.fullName ?? "" != "" {
                VStack{
                    HStack{
                        //profilepic
                        //profilepic
                        ProfilePictureView(profilePic: post.profilePic ?? "", verified: post.verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                        VStack(alignment: .leading) {
                            //name
                            if post.userName == "" {
                                Text(post.fullName!)
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                            } else{
                                Text(post.userName)
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .fontWeight(.bold)
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
                    VStack{
                        HStack{
                            Text(post.caption )
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .padding(.vertical, UIScreen.screenHeight/60)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
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

//struct AdminAnnouncementsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdminAnnouncements()
//    }
//}
