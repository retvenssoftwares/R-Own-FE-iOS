//
//  EventPostView.swift
//  R-own
//
//  Created by Aman Sharma on 31/05/23.
//

import SwiftUI
import Shimmer

struct EventPostView: View {
    
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
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    //profilepic
                    AsyncImage(url: URL(string: post.profilePic)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                            .onTapGesture {
                                print("move to profile screen")
                            }
                    } placeholder: {
                        //put your placeholder here
                        Circle()
                            .fill(lightGreyUi)
                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                            .shimmering(active: true)
                    }
                    VStack(alignment: .leading) {
                        //name
                        Text(post.fullName)
                            .foregroundColor(.black)
                            .font(.body)
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
                    Text(post.dateAdded)
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
                                Image(liked == "not liked" ? "PostLike" : "PostLiked" )
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
                        if saved == "not saved"{
                            saveService.savePostID(loginData: loginData, postID: post.postID)
                            saved = "saved"
                        } else {
                            saveService.unsavePostID(loginData: loginData, postID: post.postID)
                            saved = "not saved"
                        }
                    }, label: {
                        Image(saved == "not saved" ? "PostSave" : "PostSaved")
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
                    if post.caption ?? "" != "" {
                        Text(post.caption ?? "")
                            .font(.system(size: UIScreen.screenHeight/80))
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                    }
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

//struct EventPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventPostView()
//    }
//}
