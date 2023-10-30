//
//  ProfilePostImageViewWithoutComment.swift
//  R-own
//
//  Created by Aman Sharma on 11/06/23.
//

import SwiftUI
import Shimmer

struct ProfilePostImageViewWithoutComment: View {
    
    @State var media: [Media643]
    @Binding var likeCount: Int
    @State var postID: String
    @State var loginData: LoginViewModel
    @State var posterID: String
    @State var liked: String
    @State var saved: String
    @StateObject var saveService = SaveElemetsIDService()
    
    @StateObject var mainFeedService = MainFeedService()
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffet: CGFloat = 0
    @State var showCommentSheet: Bool = false
    
    @State private var currentUrl1: URL?
    @State private var currentUrl2: URL?
    
    var body: some View {
        VStack{
            if media.count == 1 {
                ZStack{
                    ForEach(0..<media.count, id: \.self){ index in
                        AsyncImage(url: currentUrl1) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: UIScreen.screenHeight/2.5, alignment: .bottom)
                                .cornerRadius(15)
                                .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
                                .opacity(currentIndex == index ? 1.0 : 0)
                                .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                                .offset(x: CGFloat(index - currentIndex) * 300 + dragOffet, y: 0)
                        } placeholder: {
                            //put your placeholder here
                            Rectangle()
                                .fill(lightGreyUi)
                                .frame(height: UIScreen.screenHeight/2.5, alignment: .bottom)
                                .shimmering(active: true)
                        }
                        .onAppear {
                            if currentUrl1 == nil {
                                DispatchQueue.main.async {
                                    currentUrl1 = URL(string: media[index].post)
                                }
                            }
                        }
                    }
                    VStack (spacing: 0){
                        HStack{
                            //likebutton
                            
                                Button(action: {
                                    if liked == "not liked" {
                                        mainFeedService.likePost(loginData: loginData, postID: postID, posterID: posterID)
                                        likeCount += 1
                                        liked = "liked"
                                    } else {
                                        mainFeedService.likePost(loginData: loginData, postID: postID, posterID: posterID)
                                        likeCount += 1
                                        liked = "not liked"
                                    }
                                }, label: {
                                    VStack {
                                        Image(liked == "not liked" ? "PostLike" : "PostLiked" )
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                        Text(String(likeCount))
                                            .foregroundColor(.white)
                                            .font(.body)
                                            .fontWeight(.regular)
                                    }
                                })
                            //save
                            Button(action: {
                                print("saved")
                                if saved == "not saved"{
                                    saveService.savePostID(loginData: loginData, postID: postID)
                                    saved = "saved"
                                } else {
                                    saveService.unsavePostID(loginData: loginData, postID:postID)
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
                    }
                    .padding(.vertical, UIScreen.screenWidth/70)
                    .frame(width: UIScreen.screenWidth/1.04)
                    .background(.black.opacity(0.5))
                    .cornerRadius(15, corners: .bottomLeft)
                    .cornerRadius(15, corners: .bottomRight)
                    .offset(x:0, y: UIScreen.screenHeight/5.2)
                }
            } else {
                ZStack{
                    ForEach(0..<media.count, id: \.self){ index in
                        AsyncImage(url: currentUrl2) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: UIScreen.screenHeight/2.5, alignment: .bottom)
                                .cornerRadius(15)
                                .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
                                .opacity(currentIndex == index ? 1.0 : 0)
                                .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                                .offset(x: CGFloat(index - currentIndex) * 300 + dragOffet, y: 0)
                        } placeholder: {
                            //put your placeholder here
                            Rectangle()
                                .fill(lightGreyUi)
                                .frame(height: UIScreen.screenHeight/2.5, alignment: .bottom)
                                .shimmering(active: true)
                        }
                        .onAppear {
                            if currentUrl2 == nil {
                                DispatchQueue.main.async {
                                    currentUrl2 = URL(string: media[index].post)
                                }
                            }
                        }
                    }
                    VStack (spacing: 0){
                        HStack{
                            //likebutton
                            
                                Button(action: {
                                    if liked == "not liked" {
                                        mainFeedService.likePost(loginData: loginData, postID: postID, posterID: posterID)
                                        likeCount += 1
                                        liked = "liked"
                                    } else {
                                        mainFeedService.likePost(loginData: loginData, postID: postID, posterID: posterID)
                                        likeCount += 1
                                        liked = "not liked"
                                    }
                                }, label: {
                                    VStack {
                                        Image(liked == "not liked" ? "PostLike" : "PostLiked" )
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                        Text(String(likeCount))
                                            .foregroundColor(.white)
                                            .font(.body)
                                            .fontWeight(.regular)
                                    }
                                })
                            
                            //save
                            Button(action: {
                                print("saved")
                                if saved == "not saved"{
                                    saveService.savePostID(loginData: loginData, postID: postID)
                                    saved = "saved"
                                } else {
                                    saveService.unsavePostID(loginData: loginData, postID:postID)
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
                    }
                    .padding(.vertical, UIScreen.screenWidth/70)
                    .frame(width: UIScreen.screenWidth/1.04)
                    .background(.black.opacity(0.5))
                    .cornerRadius(15, corners: .bottomLeft)
                    .cornerRadius(15, corners: .bottomRight)
                    .offset(x:0, y: UIScreen.screenHeight/5.2)
                }
                .gesture(
                DragGesture()
                    .onEnded({ value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation{
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation{
                                currentIndex = min(media.count - 1, currentIndex + 1)
                            }
                        }
                    })
                )}
        }
    }
}

//struct ProfilePostImageViewWithoutComment_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfilePostImageViewWithoutComment()
//    }
//}
