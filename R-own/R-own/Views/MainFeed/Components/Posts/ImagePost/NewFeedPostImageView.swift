//
//  NewFeedPostImageView.swift
//  R-own
//
//  Created by Aman Sharma on 28/07/23.
//

import SwiftUI
import Shimmer

struct NewFeedPostImageView: View {
    
    @Binding var post: NewFeedPost
    
    @Binding var currentIndex: Int
    @GestureState private var dragOffet: CGFloat = 0
    @State var showCommentSheet: Bool = false
    
    @State var likeStatus: Bool = false
    @State var saveStatus: Bool = false
    @StateObject var mainFeedService = MainFeedService()
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var saveService = SaveElemetsIDService()
    
    @State var likeAnimationToggle: Bool = false
    
    @State private var currentUrl1: URL?
    @State private var currentUrl2: URL?
    
    var body: some View {
        VStack{
            if post.media.count == 1 {
                ZStack{
                    ForEach(0..<post.media.count, id: \.self){ index in
                        AsyncImage(url: currentUrl1) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.screenWidth, height: (UIScreen.screenWidth)*1.33)
                                .cornerRadius(15)
                                .clipped()
                                .overlay{
                                    if likeAnimationToggle {
                                        Image("PostLiked")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                    }
                                }
                        } placeholder: {
                            //put your placeholder here
                            Rectangle()
                                .fill(lightGreyUi)
                                .frame(width: UIScreen.screenWidth, height: (UIScreen.screenWidth)*1.33)
                                .shimmering(active: true)
                        }
                        .onAppear {
                            if currentUrl1 == nil {
                                DispatchQueue.main.async {
                                    currentUrl1 = URL(string: post.media[index].post.replacingOccurrences(of: " ", with: "%20"))
                                }
                            }
                        }
                    }
                    .onTapGesture (count: 2){
                        if post.postID ?? "" != "" {
                            if post.likeCount != nil {
                                if post.like == "not liked" {
                                    mainFeedService.likePost(loginData: loginData, postID: post.postID!, posterID: post.userID)
                                    post.likeCount = post.likeCount! + 1
                                    post.like = "liked"
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
                        }
                    }
                }
            } else {
                ZStack{
                    ForEach(0..<post.media.count, id: \.self){ index in
                        AsyncImage(url: currentUrl2) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.screenWidth, height: (UIScreen.screenWidth)*1.33)
                                .cornerRadius(15)
                                .clipped()
                                .opacity(currentIndex == index ? 1.0 : 0)
                                .scaleEffect(currentIndex == index ? 1 : 0.6)
                                .offset(x: CGFloat(index - currentIndex) * 300 + dragOffet, y: 0)
                                .overlay{
                                    if likeAnimationToggle {
                                        Image("PostLiked")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                    }
                                }
                        } placeholder: {
                            //put your placeholder here
                            Rectangle()
                                .fill(lightGreyUi)
                                .frame(width: UIScreen.screenWidth, height: (UIScreen.screenWidth)*1.33)
                                .shimmering(active: true)
                        }
                        .onAppear {
                            if currentUrl2 == nil {
                                DispatchQueue.main.async {
                                    currentUrl2 = URL(string: post.media[index].post.replacingOccurrences(of: " ", with: "%20"))
                                }
                            }
                        }
                    }
                    .onTapGesture (count: 2){
                        if post.postID ?? "" != "" {
                            if post.likeCount != nil {
                                if post.like == "not liked" {
                                    mainFeedService.likePost(loginData: loginData, postID: post.postID!, posterID: post.userID)
                                    post.likeCount = post.likeCount! + 1
                                    post.like = "liked"
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
                        }
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
                                        currentIndex = min(post.media.count - 1, currentIndex + 1)
                                    }
                                }
                            })
                    )
                }
            }
        }
    }
}

//struct NewFeedPostImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFeedPostImageView()
//    }
//}
