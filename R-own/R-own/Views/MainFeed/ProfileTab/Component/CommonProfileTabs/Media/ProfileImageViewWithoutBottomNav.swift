//
//  ProfileImageViewWithoutBottomNav.swift
//  R-own
//
//  Created by Aman Sharma on 13/07/23.
//

import SwiftUI
import Shimmer

struct ProfileImageViewWithoutBottomNav: View {
    
    
    @State var media: [Media643]
    @Binding var likeCount: Int
    @State var postID: String
    @State var loginData: LoginViewModel
    @State var posterID: String
    @Binding var liked: String
    @Binding var saved: String
    @Binding var commentCount: Int
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var saveService = SaveElemetsIDService()
    
    @StateObject var mainFeedService = MainFeedService()
    
    @Binding var currentIndex: Int
    @GestureState private var dragOffet: CGFloat = 0
    let images: [String] = ["PostSamplePic3", "PostSamplePic4", "PostSamplePic3", "PostSamplePic4", "PostSamplePic1", "PostSamplePic2", "PostSamplePic3", "PostSamplePic4", "PostSamplePic1", "PostSamplePic2"]
    @State var showCommentSheet: Bool = false
    @State var likeAnimationToggle: Bool = false
    
    
    @State private var currentUrl1: URL?
    @State private var currentUrl2: URL?
    
    var body: some View {
        VStack{
            if media.count < 2 {
                ZStack{
                    ForEach(0..<media.count, id: \.self){ index in
                        AsyncImage(url: currentUrl1) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.screenWidth/1.2, height: (UIScreen.screenWidth/1.2)*1.33)
                                .cornerRadius(15)
                                .clipped()
                                .padding(.horizontal, UIScreen.screenWidth-UIScreen.screenWidth/1.2)
                                .opacity(currentIndex == index ? 1.0 : 0)
                                .scaleEffect(currentIndex == index ? 1.2 : 0.8)
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
                                .frame(width: UIScreen.screenWidth/1.2, height: (UIScreen.screenWidth/1.2)*1.33)
                                .padding(.horizontal, UIScreen.screenWidth-UIScreen.screenWidth/1.2)
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
                    .onTapGesture (count: 2){
                        
                        if liked == "not liked" {
                            mainFeedService.likePost(loginData: loginData, postID: postID, posterID: posterID)
                            likeCount = likeCount + 1
                            liked = "liked"
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
                .frame(width: UIScreen.screenWidth/1.2, height: (UIScreen.screenWidth/1.2)*1.33)
                .cornerRadius(15)
                .clipped()
            } else {
                ZStack{
                    ForEach(0..<media.count, id: \.self){ index in
                        AsyncImage(url: currentUrl2) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.screenWidth/1.2, height: (UIScreen.screenWidth/1.2)*1.33)
                                .cornerRadius(15)
                                .clipped()
                                .padding(.horizontal, UIScreen.screenWidth-UIScreen.screenWidth/1.2)
                                .opacity(currentIndex == index ? 1.0 : 0)
                                .scaleEffect(currentIndex == index ? 1.2 : 0.8)
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
                                .frame(width: UIScreen.screenWidth/1.2, height: (UIScreen.screenWidth/1.2)*1.33)
                                .padding(.horizontal, UIScreen.screenWidth-UIScreen.screenWidth/1.2)
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
                    .onTapGesture (count: 2){
                        
                        if liked == "not liked" {
                            mainFeedService.likePost(loginData: loginData, postID: postID, posterID: posterID)
                            likeCount = likeCount + 1
                            liked = "liked"
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
                .frame(width: UIScreen.screenWidth/1.2, height: (UIScreen.screenWidth/1.2)*1.33)
                .cornerRadius(15)
                .clipped()
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
                                currentIndex = min(images.count - 1, currentIndex + 1)
                            }
                        }
                    })
                )}
        }
        .onAppear{
            print("width")
            print(UIScreen.screenWidth/1.2)
            print("height")
            print((UIScreen.screenWidth/1.2)*1.33)
        }
    }
}

//struct ProfileImageViewWithoutBottomNav_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileImageViewWithoutBottomNav()
//    }
//}
