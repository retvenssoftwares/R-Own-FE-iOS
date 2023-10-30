//
//  AdminYoutubePromoPostView.swift
//  R-own
//
//  Created by Aman Sharma on 26/07/23.
//

import SwiftUI

struct AdminYoutubePromoPostView: View {
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @State var post: NewFeedPost
    
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var showCommentSheet: Bool = false
    
    @State var likeStatus: Bool = false
    @State var saveStatus: Bool = false
    @State var likeAnimationToggle: Bool = false
    
    @State var mainFeedService = MainFeedService()
    @State var saveService = SaveElemetsIDService()
    @State var navigateToProfileView: Bool = false
    @State var navigateToHotelDetail: Bool = false
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            if post.fullName ?? "" != "" {
                if post.hotelName != "" {
                    VStack{
                        VStack{
                            HStack{
                                //profilepic
                                //profilepic
                                ProfilePictureView(profilePic: post.profilePic ?? "", verified: post.verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                                VStack(alignment: .leading) {
                                    //name
                                    Text(post.fullName!)
                                        .foregroundColor(.black)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .padding(.leading, 30)
                                        .frame(alignment: .leading)
                                        .onTapGesture {
                                            print("move to profile screen")
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
                        VStack{
                            if post.caption != "" {
                                HStack{
                                    Text(post.caption )
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                        .padding(.vertical, UIScreen.screenHeight/60)
                                    Spacer()
                                }
                            }
                            
                            if post.media.count > 0 {
                                if post.media[0].post != "" {
                                    AsyncImage(url: currentUrl) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/2.5)
                                            .clipped()
                                    } placeholder: {
                                        //put your placeholder here
                                        Rectangle()
                                            .fill(lightGreyUi)
                                            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/2.5)
                                            .cornerRadius(15)
                                            .shimmering(active: true)
                                    }
                                    .onAppear {
                                        if currentUrl == nil {
                                            DispatchQueue.main.async {
                                                currentUrl = URL(string: post.media[0].post)
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }
                        .padding(.vertical, UIScreen.screenHeight/60)
                        
                        
                        VStack(spacing: 0){
                            if post.bookingengineLink ?? "" != "" {
                                Link(destination: URL(string: validateURL(post.bookingengineLink ?? "") ?? "")!) {
                                    HStack{
                                        Text(post.eventName)
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(greenUi)
                                        Spacer()
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/70)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                    .frame(width: UIScreen.screenWidth)
                                    .background(jobsDarkBlue)
                                }
                            }
                            
                            
                        }
                    }
                    .frame(width: UIScreen.screenWidth)
                    .padding(.vertical, UIScreen.screenHeight/70)
                    .background(.white)
                    .cornerRadius(15)
                    .clipped()
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .padding(.horizontal, UIScreen.screenWidth/50)
                    .padding(.vertical, UIScreen.screenHeight/70)
                }
            }
        }
    }
}

//struct AdminYoutubePromoPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdminYoutubePromoPostView()
//    }
//}
