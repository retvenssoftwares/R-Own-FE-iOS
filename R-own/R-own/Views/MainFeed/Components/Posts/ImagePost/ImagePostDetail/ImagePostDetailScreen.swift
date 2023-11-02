//
//  ImagePostDetailScreen.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI
import Shimmer

struct ImagePostDetailScreen: View {
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffet: CGFloat = 0
    @State var showCommentSheet: Bool = false
    @State var navigateTolikedUserView: Bool = false
    @State var likeAnimationToggle: Bool = false
    
    @Binding var post: NewFeedPost
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var mainFeedService = MainFeedService()
    @StateObject var saveService = SaveElemetsIDService()
    @StateObject var profileService = ProfileService()
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentUrl1: URL?
    @State private var currentUrl2: URL?
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    HStack{
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                .padding(.leading, UIScreen.screenWidth/40)
                                .foregroundColor(.white)
                        })
                        Spacer()
                    }
                    .padding(.vertical, UIScreen.screenHeight/60)
                    
                    Spacer()
                    
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
                                        .frame(width: UIScreen.screenWidth, height: (UIScreen.screenWidth)*1.33)
                                        .padding(.horizontal, UIScreen.screenWidth-UIScreen.screenWidth/1.2)
                                        .shimmering(active: true)
                                }
                                .onAppear {
                                    if currentUrl1 == nil {
                                        DispatchQueue.main.async {
                                            currentUrl1 = URL(string: post.media[index].post)
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
                                }
                            }
                        }
                        .frame(width: UIScreen.screenWidth, height: (UIScreen.screenWidth/1.2)*1.33)
                        .cornerRadius(15)
                        .clipped()
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
                                        .scaleEffect(currentIndex == index ? 1 : 0.8)
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
                                        .padding(.horizontal, UIScreen.screenWidth-UIScreen.screenWidth/1.2)
                                        .shimmering(active: true)
                                }
                                .onAppear {
                                    if currentUrl2 == nil {
                                        DispatchQueue.main.async {
                                            currentUrl2 = URL(string: post.media[index].post)
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
                                }
                            }
                        }
                        .frame(width: UIScreen.screenWidth, height: (UIScreen.screenWidth/1.2)*1.33)
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
                                        currentIndex = min(post.media.count - 1, currentIndex + 1)
                                    }
                                }
                            })
                        )
                    }
                    
                    
                    Spacer()
                    if post.caption != "" {
                        HStack{
                            Text(post.caption )
                                .font(.body)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                .padding(.vertical, UIScreen.screenHeight/70)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    HStack{
                        
                        VStack{
                            //likebutton
                            
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
                                    Image(post.like == "not liked" ? "PostLike" : "PostLiked" )
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                    if post.likeCount! != 0 {
                                        Text(String(post.likeCount!))
                                            .foregroundColor(.white)
                                            .font(.footnote)
                                            .fontWeight(.regular)
                                    }
                                }
                            })
                            Spacer()
                        }
                        VStack{
                            //comment
                            Button(action: {
                                
                                if post.postID ?? "" != "" {
                                    print("open comment screen")
                                    globalVM.commentList = CommentServiceModel(post: Post5355(id: "", userID: "", postID: "", comments: [Comment5355](), v: 0), commentCount: 0)
                                    mainFeedService.getCommentPost(globalVM: globalVM, postID: post.postID!)
                                    showCommentSheet = true
                                }
                            }, label: {
                                VStack {
                                    Image("PostComment")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                    if post.commentCount! != 0 {
                                        Text(String(post.commentCount!))
                                            .foregroundColor(.white)
                                            .font(.footnote)
                                            .fontWeight(.regular)
                                    }
                                }
                            })
                            .sheet(isPresented: $showCommentSheet) {
                                if post.postID ?? "" != "" {
                                    CommentBottomSheetView(globalVM: globalVM, postID: post.postID ?? "", posterID: post.userID, loginData: loginData, commentCount: $post.commentCount.toUnwrapped(defaultValue: 0))
                                        .presentationDetents([.medium])
                                        .presentationDragIndicator(.visible)
                                }
                            }
                            Spacer()
                        }
                        Spacer()
                        VStack{
                            Button(action: {
                                print("open share bottomsheet")
                                globalVM.getConnectionList = [ProfileConnectionListModel]()
                                makeAPICall(globalVM: globalVM, userID: loginData.mainUserID)
                                globalVM.showSharePostBottomSheet.toggle()
                            }, label: {
                                VStack {
                                    Image("PostShare")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                }
                            })
                            .sheet(isPresented: $globalVM.showSharePostBottomSheet) {
                                if post.postID ?? "" != "" {
                                    SendImagePostBottomSheet(loginData: loginData, globalVM: globalVM, postID: post.postID ?? "", firstImageLink: post.media[0].post, caption: post.caption )
                                }
                            }
                            Spacer()
                        }
                        
                        VStack{
                            //save
                            Button(action: {
                                if post.postID ?? "" != "" {
                                    print("saved")
                                    if post.isSaved == "not saved"{
                                        saveService.savePostID(loginData: loginData, postID: post.postID!)
                                        post.isSaved = "saved"
                                    } else {
                                        saveService.unsavePostID(loginData: loginData, postID: post.postID!)
                                        post.isSaved = "not saved"
                                    }
                                }
                            }, label: {
                                Image(post.isSaved == "not saved" ? "PostSave" : "PostSaved")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                            })
                            Spacer()
                        }
                    }
                    .padding(.horizontal, UIScreen.screenWidth/30)
                    .frame(height: UIScreen.screenHeight/10)
                }
            }
            .background(.black)
            .navigationBarBackButtonHidden()
        }
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
}

//struct ImagePostDetailScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePostDetailScreen()
//    }
//}
