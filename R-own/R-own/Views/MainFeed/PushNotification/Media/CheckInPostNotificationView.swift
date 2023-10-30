//
//  PollsPushNotificationView.swift
//  R-own
//
//  Created by Aman Sharma on 14/07/23.
//

import SwiftUI

struct CheckInPostPushNotificationView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var navigateToLikedUserListScreen: Bool = false
    @StateObject var mainfeedService = MainFeedService()
    @StateObject var profileService = ProfileService()
    @StateObject var saveService = SaveElemetsIDService()
    
    @State var showCommentSheet: Bool = false
    @State var navigateToProfileView: Bool = false
    
    @State var currentIndex: Int = 0
    
    @State var isLoading: Bool = false
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var likeStatus: Bool = false
    @State var saveStatus: Bool = false
    @State var savedStatus: String = "not saved"
    @State var likeAnimationToggle: Bool = false
    @State private var currentUrl: URL?
    @State var navigateToHotelDetail: Bool = false
    
    @State var mainFeedService = MainFeedService()
    @State var isPushNotification: Bool
    @State var postID: String
    
    //back button var
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack{
            if isLoading {
                VStack {
                    VStack{
                        HStack{
                            Button(action: {
                                if isPushNotification{
                                    loginData.notificationCheckInPostView.toggle()
                                } else {
                                    presentationMode.wrappedValue.dismiss()
                                }
                                
                            }, label: {
                                Image(systemName: "arrow.backward.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                    .foregroundColor(.black)
                            })
                            Spacer()
                        }
                        .border(width: 1, edges: [.bottom], color: .black)
                    }
                    if globalVM.postDetails[0].fullName != "" {
                        if globalVM.postDetails[0].hotelName != "" {
                            VStack{
                                VStack{
                                    HStack{
                                        //profilepic
                                        ProfilePictureView(profilePic: globalVM.postDetails[0].profilePic, verified: globalVM.postDetails[0].verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/30, width: UIScreen.screenHeight/30)
                                            .onTapGesture {
                                                navigateToProfileView.toggle()
                                                print("move to profile screen")
                                            }
                                            .navigationDestination(isPresented: $navigateToProfileView, destination: {
                                                if globalVM.postDetails[0].role != "" {
                                                    ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: globalVM.postDetails[0].role, mainUser: false, userID: globalVM.postDetails[0].userID)
                                                }
                                            })
                                        VStack(alignment: .leading) {
                                            //name
                                            Text(globalVM.postDetails[0].fullName)
                                                .foregroundColor(.black)
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .frame(alignment: .leading)
                                                .onTapGesture {
                                                    navigateToProfileView.toggle()
                                                    print("move to profile screen")
                                                }
                                            //profile
                                            if globalVM.postDetails[0].jobTitle != "" {
                                                Text(globalVM.postDetails[0].jobTitle == "" ? "" : globalVM.postDetails[0].jobTitle)
                                                    .foregroundColor(.black)
                                                    .font(.body)
                                                    .fontWeight(.thin)
                                                    .frame(alignment: .leading)
                                            }
                                            //location
                                            if globalVM.postDetails[0].location != "" {
                                                Text(globalVM.postDetails[0].location)
                                                    .foregroundColor(.black)
                                                    .font(.body)
                                                    .fontWeight(.thin)
                                                    .frame(alignment: .leading)
                                            }
                                        }
                                        Spacer()
                                        //time
                                        Text(relativeTime(from: globalVM.postDetails[0].dateAdded) ?? "")
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .fontWeight(.thin)
                                            .padding(.leading, 30)
                                            .frame(alignment: .leading)
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
                                    
                                }
                                VStack{
                                    HStack{
                                        Text("Hello all, I am here at \(globalVM.postDetails[0].hotelName ?? ""). Let’s Catch Up.")
                                            .font(.body)
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.leading)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                        Spacer()
                                    }
                                    
                                    
                                    AsyncImage(url: currentUrl) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/2.5)
                                            .clipped()
                                            .cornerRadius(10)
                                            .overlay{
                                                if likeAnimationToggle {
                                                    Image("PostLiked")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                                }
                                            }
                                            .onTapGesture {
                                                print("move to hotel screen")
                                                if globalVM.postDetails[0].hotelID ?? "" != "" {
                                                    navigateToHotelDetail.toggle()
                                                }
                                            }
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
                                                currentUrl = URL(string: globalVM.postDetails[0].hotelCoverpicURL ?? "")
                                            }
                                        }
                                    }
                                    .navigationDestination(isPresented: $navigateToHotelDetail, destination: {
                                        ExploreHotelDetailView(globalVM: globalVM, hotelID: globalVM.postDetails[0].hotelID ?? "", savedStatus: $savedStatus)
                                    })
                                    
                                }
                                .padding(.vertical, UIScreen.screenHeight/60)
                                .onTapGesture (count: 2){
                                    
                                    if globalVM.postDetails[0].liked == "not liked" {
                                        if globalVM.postDetails[0].postID  != "" {
                                            mainFeedService.likePost(loginData: loginData, postID: globalVM.postDetails[0].postID, posterID: globalVM.postDetails[0].userID)
                                        }
                                        if globalVM.postDetails[0].likeCount != 0 {
                                            globalVM.postDetails[0].likeCount = globalVM.postDetails[0].likeCount + 1
                                        }
                                        globalVM.postDetails[0].liked = "Liked"
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
                                
                                
                                VStack{
                                    if globalVM.postDetails[0].bookingengineLink ?? "" != "" {
                                        Link(destination: URL(string: validateURL(globalVM.postDetails[0].bookingengineLink ?? "") ?? "")!) {
                                            HStack{
                                                Text("Book Now")
                                                    .font(.body)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(greenUi)
                                                    .padding(.vertical, UIScreen.screenHeight/60)
                                                    .padding(.leading, UIScreen.screenWidth/30)
                                                Spacer()
                                            }
                                            .background(jobsDarkBlue)
                                        }
                                    }
                                    VStack{
                                        HStack{
                                            Text(globalVM.postDetails[0].userName == "" ? globalVM.postDetails[0].fullName : globalVM.postDetails[0].userName)
                                                .font(.body)
                                                .fontWeight(.bold)
                                            if globalVM.postDetails[0].caption != "" {
                                                Text(globalVM.postDetails[0].caption )
                                                    .font(.body)
                                                    .fontWeight(.light)
                                                    .multilineTextAlignment(.leading)
                                            }
                                            Spacer()
                                        }
                                        .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/80)
                                    HStack{
                                        
                                        //likebutton
                                        
                                        Button(action: {
                                            if globalVM.postDetails[0].postID  != "" {
                                                if globalVM.postDetails[0].likeCount != 0 {
                                                    if globalVM.postDetails[0].liked == "not liked" {
                                                        mainFeedService.likePost(loginData: loginData, postID: globalVM.postDetails[0].postID, posterID: globalVM.postDetails[0].userID)
                                                        globalVM.postDetails[0].likeCount = globalVM.postDetails[0].likeCount + 1
                                                        globalVM.postDetails[0].liked = "Liked"
                                                    } else {
                                                        mainFeedService.likePost(loginData: loginData, postID: globalVM.postDetails[0].postID, posterID: globalVM.postDetails[0].userID)
                                                        globalVM.postDetails[0].likeCount = globalVM.postDetails[0].likeCount - 1
                                                        globalVM.postDetails[0].liked = "not liked"
                                                    }
                                                }
                                            }
                                        }, label: {
                                            VStack {
                                                Image(globalVM.postDetails[0].liked == "not liked" ? "PostLikeBlack" : "PostLikedBlack" )
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                                if globalVM.postDetails[0].likeCount != 0 {
                                                    Text(String(globalVM.postDetails[0].likeCount))
                                                        .foregroundColor(.black)
                                                        .font(.body)
                                                        .fontWeight(.regular)
                                                }
                                                Spacer()
                                            }
                                        })
                                        
                                        //comment
                                        Button(action: {
                                            print("open comment screen")
                                            if globalVM.postDetails[0].postID  != "" {
                                                mainFeedService.getCommentPost(globalVM: globalVM, postID: globalVM.postDetails[0].postID)
                                            }
                                            showCommentSheet = true
                                        }, label: {
                                            VStack {
                                                Image("PostCommentBlack")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                                if globalVM.postDetails[0].commentCount != 0 {
                                                    Text(String(globalVM.postDetails[0].commentCount))
                                                        .foregroundColor(.black)
                                                        .font(.body)
                                                        .fontWeight(.regular)
                                                }
                                                Spacer()
                                            }
                                        })
                                        .sheet(isPresented: $showCommentSheet) {
                                            if globalVM.postDetails[0].postID != "" {
                                                CommentBottomSheetView(globalVM: globalVM, postID: globalVM.postDetails[0].postID , posterID: globalVM.postDetails[0].userID, loginData: loginData, commentCount: $globalVM.postDetails[0].commentCount)
                                                    .presentationDetents([.medium])
                                                    .presentationDragIndicator(.visible)
                                            }
                                        }
                                        //save
                                        //                            Button(action: {
                                        //                                print("saved")
                                        //                                if post.isSaved == "not saved"{
                                        //                                    saveService.savePostID(loginData: loginData, postID: post.postID)
                                        //                                    post.isSaved = "saved"
                                        //                                } else {
                                        //                                    saveService.unsavePostID(loginData: loginData, postID: post.postID)
                                        //                                    post.isSaved = "not saved"
                                        //                                }
                                        //                            }, label: {
                                        //                                Image(post.isSaved == "not saved" ? "PostSaveBlack" : "PostSavedBlack")
                                        //                                    .resizable()
                                        //                                    .scaledToFit()
                                        //                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                        //                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                        //                                    .padding(.bottom, UIScreen.screenHeight/100)
                                        //                            })
                                        Spacer()
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
                                    
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
                }
            } else {
                VStack{
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            makepostDEtailCall(globalVM: globalVM, userID: loginData.mainUserID, postID: isPushNotification ? loginData.notificationUserpostID : postID)
            mainfeedService.getCommentPost(globalVM: globalVM, postID: loginData.notificationUserpostID)
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
    func makepostDEtailCall(globalVM: GlobalViewModel, userID: String, postID: String){
        
            Task{
                isLoading = false
                let res = await profileService.getPostByID(globalVM: globalVM, userID: userID, postID: postID)
                if res == "Success" {
                    isLoading = true
                } else {
                    makeAPICall(globalVM: globalVM, userID: userID)
                }
            }
    }
}

//struct PollsPushNotificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        PollsPushNotificationView()
//    }
//}
