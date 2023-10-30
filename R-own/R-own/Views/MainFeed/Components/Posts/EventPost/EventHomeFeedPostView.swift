//
//  EventHomeFeedPostView.swift
//  R-own
//
//  Created by Aman Sharma on 11/06/23.
//

import SwiftUI

struct EventHomeFeedPostView: View {
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    
    @State var post: Post535
    @State var showCommentSheet: Bool = false
    
    @State var likeStatus: Bool = false
    @State var saveStatus: Bool = false
    @State var likeAnimationToggle: Bool = false
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var mainFeedService = MainFeedService()
    @State var saveService = SaveElemetsIDService()
    @State var navigateToProfileView: Bool = false
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    //profilepic
                    ProfilePictureView(profilePic: post.profilePic, verified: post.verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/30, width: UIScreen.screenHeight/30)
                        .onTapGesture {
                            navigateToProfileView.toggle()
                            print("move to profile screen")
                        }
                        .navigationDestination(isPresented: $navigateToProfileView, destination: {
                            ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: post.role, mainUser: false, userID: post.userID)
                        })
                    VStack(alignment: .leading) {
                        //name
                        Text(post.fullName)
                            .foregroundColor(.black)
                            .font(.system(size: UIScreen.screenHeight/80))
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                            .frame(alignment: .leading)
                            .onTapGesture {
                                print("move to profile screen")
                            }
                        //profile
                        Text("Designation")
                            .foregroundColor(.black)
                            .font(.system(size: UIScreen.screenHeight/110))
                            .fontWeight(.thin)
                            .padding(.leading, 30)
                            .frame(alignment: .leading)
                        //location
                        Text(post.location)
                            .foregroundColor(.black)
                            .font(.system(size: UIScreen.screenHeight/120))
                            .fontWeight(.thin)
                            .padding(.leading, 30)
                            .frame(alignment: .leading)
                    }
                    Spacer()
                    //time
                    Text(relativeTime(from: post.dateAdded) ?? "")
                        .foregroundColor(.black)
                        .font(.system(size: UIScreen.screenHeight/110))
                        .fontWeight(.thin)
                        .padding(.leading, 30)
                        .frame(alignment: .leading)
                }
                .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
                    
                
                

            }
            VStack{
                
                Text("Hello all, I am going to \(post.eventName) on \(post.eventStartDate).")
                    .font(.system(size: UIScreen.screenHeight/70))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, UIScreen.screenWidth/30)
                    .padding(.vertical, UIScreen.screenHeight/60)
                
                
                AsyncImage(url: URL(string: post.eventThumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/5)
                        .onTapGesture {
                            print("move to profile screen")
                        }
                } placeholder: {
                    //put your placeholder here
                    Rectangle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/5)
                        .cornerRadius(15)
                        .shimmering(active: true)
                }
                
                
                HStack{
                    Text(post.eventName)
                        .font(.system(size: UIScreen.screenHeight/60))
                        .fontWeight(.bold)
                    Spacer()
                    Text(post.price)
                        .font(.system(size: UIScreen.screenHeight/60))
                        .fontWeight(.light)
                        .foregroundColor(greenUi)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(lightGreyUi)
                        .cornerRadius(15)
                }
                .frame(width: UIScreen.screenWidth/1.5)
            }
            .padding(.vertical, UIScreen.screenHeight/60)
            .overlay{
                if likeAnimationToggle {
                    Image("PostLiked")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                }
            }
            .onTapGesture (count: 2){
                
                if post.like == "not liked" {
                    mainFeedService.likePost(loginData: loginData, postID: post.postID, posterID: post.userID)
                    post.likeCount = post.likeCount + 1
                    post.like = "Liked"
                    withAnimation(.easeInOut(duration: 0.5)){
                        likeAnimationToggle = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        print("animation turned off")
                        
                        withAnimation(.easeInOut(duration: 0.3)){
                            likeAnimationToggle = false
                        }
                    }
                } else {
                    withAnimation(.easeInOut(duration: 0.5)){
                        likeAnimationToggle = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        print("animation turned off")
                        
                        withAnimation(.easeInOut(duration: 0.3)){
                            likeAnimationToggle = false
                        }
                    }
                }
            }
            
            
            VStack(spacing: 0){
                HStack{
                    Text("Book Now")
                        .font(.system(size: UIScreen.screenHeight/70))
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        
                }
                .padding(.vertical, UIScreen.screenHeight/70)
                .frame(width: UIScreen.screenWidth)
                .background(jobsDarkBlue)
                .onTapGesture {
                    print("Book now")
                }
                HStack{
                    //likebutton
                    
                        Button(action: {
                            if post.like == "not liked" {
                                mainFeedService.likePost(loginData: loginData, postID: post.postID, posterID: post.userID)
                                post.likeCount = post.likeCount + 1
                                post.like = "Liked"
                            } else {
                                mainFeedService.likePost(loginData: loginData, postID: post.postID, posterID: post.userID)
                                post.likeCount = post.likeCount - 1
                                post.like = "not liked"
                            }
                        }, label: {
                            VStack {
                                Image(post.like == "not liked" ? "PostLike" : "PostLiked" )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                Text(String(post.likeCount))
                                    .foregroundColor(.white)
                                    .font(.system(size: UIScreen.screenHeight/110))
                                    .fontWeight(.regular)
                            }
                        })
                    //comment
                    Button(action: {
                        print("open comment screen")
                        showCommentSheet = true
                    }, label: {
                        VStack {
                            Image("PostComment")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            Text("\(post.commentCount)")
                                .foregroundColor(.white)
                                .font(.system(size: UIScreen.screenHeight/110))
                                .fontWeight(.regular)
                        }
                    })
                    .sheet(isPresented: $showCommentSheet) {
                        CommentBottomSheetView(globalVM: globalVM, postID: post.postID, posterID: post.userID, loginData: loginData, commentCount: $post.commentCount)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                    }
                    //save
                    Button(action: {
                        print("saved")
                        if post.isSaved == "not saved"{
                            saveService.savePostID(loginData: loginData, postID: post.postID)
                            post.isSaved = "saved"
                        } else {
                            saveService.unsavePostID(loginData: loginData, postID: post.postID)
                            post.isSaved = "not saved"
                        }
                    }, label: {
                        Image(post.isSaved == "not saved" ? "PostSave" : "PostSaved")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .padding(.bottom, UIScreen.screenHeight/100)
                    })
                }
                .padding(.vertical, UIScreen.screenHeight/70)
                .frame(width: UIScreen.screenWidth)
                .background(.black.opacity(0.3))
                .cornerRadius(15, corners: .bottomLeft)
                .cornerRadius(15, corners: .bottomRight)
            }
            VStack{
                HStack{
                    Text(post.userName)
                        .font(.system(size: UIScreen.screenHeight/80))
                        .fontWeight(.bold)
                    Text(post.caption ?? "")
                        .font(.system(size: UIScreen.screenHeight/80))
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.horizontal, UIScreen.screenWidth/40)
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

//struct EventHomeFeedPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventHomeFeedPostView()
//    }
//}
