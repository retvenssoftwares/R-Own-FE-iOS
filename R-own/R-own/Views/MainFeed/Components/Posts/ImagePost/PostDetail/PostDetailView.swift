//
//  PostDetailView.swift
//  R-own
//
//  Created by Aman Sharma on 22/05/23.
//

import SwiftUI
import AlertToast

struct PostDetailView: View {
    
    @State var navigateToLikedUserListScreen: Bool = false
    
    @State var newComment: String
    @State var postProfilePic: String
    @State var postUserFullName: String
    @State var postUserName: String
    @State var postUserDesignation: String
    @State var postUserLocation: String
    @State var postTime: String
    @State var postCaption: String
    @State var media: [Media535]
    @Binding var likeCount: Int
    @Binding var commentCount: Int
    @State var postID: String
    @StateObject var loginData: LoginViewModel
    @State var posterID: String
    @StateObject var globalVM: GlobalViewModel
    @Binding var liked: String
    @Binding var saved: String
    @State var verificationStatus: String
    @StateObject var profileVM: ProfileViewModel
    @State var role: String
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var mainUserService = MainUserService()
    
    @StateObject var mainfeedService = MainFeedService()
    @StateObject var profileService = ProfileService()
    @StateObject var saveService = SaveElemetsIDService()
    
    @State var showCommentSheet: Bool = false
    @State var navigateToProfileView: Bool = false
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var currentIndex: Int = 0
    
    @Environment(\.dismiss) private var dismiss
    
    @State var openBottomSheet: Bool = false
    
    @State var alertReport: Bool = false
    @State var alertFailure: Bool = false
    @State var reportReason: String = ""
    
    @State var openLikedUserView: Bool = false
    
    var body: some View {
        NavigationStack{
                VStack {
                    VStack{
                        //Navbar
                        HStack{
                            //button
                            Button(action: {
                                dismiss()
                            }, label: {
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                    .foregroundColor(.black)
                                    .padding(.leading, UIScreen.screenWidth/20)
                            })
                            Spacer()
                            //text
                            Text("Post Details")
                                .font(.body)
                                .fontWeight(.bold)
                            Spacer()
                            Button(action: {
                                openBottomSheet.toggle()
                            }, label: {
                                Image("ThreeDotsIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                    .foregroundColor(.black)
                                    .padding(.trailing, UIScreen.screenWidth/20)
                            })
                            
                        }
                        .padding(.vertical, UIScreen.screenHeight/80)
                        .border(width: 1, edges: [.bottom], color: .black)
                    }
                    .sheet(isPresented: $openBottomSheet, content: {
                        VStack{
                            ScrollView{
                                VStack{
                                    VStack{
                                        Text("Select your reason to report:")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .padding(.top, UIScreen.screenHeight/70)
                                    }
                                    
                                    Text(" It's important to know that your report is anonymous, except for cases of intellectual property infringement. If you are reporting such an infringement, we may need to share your identity with the relevant parties. \n Also, if someone is in immediate danger, call the local emergency services immediately. \n Don't wait or hesitate. Your safety and the safety of others should always be the top priority. \n Thank you for choosing to report any concerns or issues you may have. \n We take all reports seriously and will do our best to address them promptly.")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .padding(.vertical, UIScreen.screenHeight/90)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                    
                                    VStack(alignment: .leading){
                                        
                                        VStack(alignment: .leading){
                                            VStack{
                                                Button(action: {
                                                    Task {
                                                        reportReason = "It’s spam"
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: posterID, postID: postID, reason: reportReason)
                                                        if res == "Success"{
                                                            alertReport = true
                                                            
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                                openBottomSheet.toggle()
                                                            }
                                                        } else {
                                                            alertFailure = true
                                                        }
                                                    }
                                                }, label: {
                                                    Text("It’s spam")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.black)
                                                })
                                                Divider()
                                            }
                                            VStack{
                                                Button(action: {
                                                    Task {
                                                        reportReason = "I just don’t like it"
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: posterID, postID: postID, reason: reportReason)
                                                        if res == "Success"{
                                                            alertReport = true
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                                openBottomSheet.toggle()
                                                            }
                                                        } else {
                                                            alertFailure = true
                                                        }
                                                    }
                                                }, label: {
                                                    Text("I just don’t like it")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.black)
                                                })
                                                Divider()
                                            }
                                            VStack{
                                                Button(action: {
                                                    Task {
                                                        reportReason = "Suicide, self-injury or eating disorders"
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: posterID, postID: postID, reason: reportReason)
                                                        if res == "Success"{
                                                            alertReport = true
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                                openBottomSheet.toggle()
                                                            }
                                                        } else {
                                                            alertFailure = true
                                                        }
                                                    }
                                                }, label: {
                                                    Text("Suicide, self-injury or eating disorders")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.black)
                                                })
                                                Divider()
                                            }
                                            VStack{
                                                Button(action: {
                                                    Task {
                                                        reportReason = "Sale of illegal or regulated goods"
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: posterID, postID: postID, reason: reportReason)
                                                        if res == "Success"{
                                                            alertReport = true
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                                openBottomSheet.toggle()
                                                            }
                                                        } else {
                                                            alertFailure = true
                                                        }
                                                    }
                                                }, label: {
                                                    Text("Sale of illegal or regulated goods")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.black)
                                                })
                                                Divider()
                                            }
                                            VStack{
                                                Button(action: {
                                                    Task {
                                                        reportReason = "Interior Nudity or sexual activity"
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: posterID, postID: postID, reason: reportReason)
                                                        if res == "Success"{
                                                            alertReport = true
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                                openBottomSheet.toggle()
                                                            }
                                                        } else {
                                                            alertFailure = true
                                                        }
                                                    }
                                                }, label: {
                                                    Text("Interior Nudity or sexual activity")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.black)
                                                })
                                                Divider()
                                            }
                                        }
                                        VStack(alignment: .leading){
                                            VStack{
                                                Button(action: {
                                                    Task {
                                                        reportReason = "Hate speech or symbols"
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: posterID, postID: postID, reason: reportReason)
                                                        if res == "Success"{
                                                            alertReport = true
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                                openBottomSheet.toggle()
                                                            }
                                                        } else {
                                                            alertFailure = true
                                                        }
                                                    }
                                                }, label: {
                                                    Text("Hate speech or symbols")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.black)
                                                })
                                                Divider()
                                            }
                                            VStack{
                                                Button(action: {
                                                    Task {
                                                        reportReason = "Violence or dangerous orgnaisations"
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: posterID, postID: postID, reason: reportReason)
                                                        if res == "Success"{
                                                            alertReport = true
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                                openBottomSheet.toggle()
                                                            }
                                                        } else {
                                                            alertFailure = true
                                                        }
                                                    }
                                                }, label: {
                                                    Text("Violence or dangerous orgnaisations")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.black)
                                                })
                                                Divider()
                                            }
                                            VStack{
                                                Button(action: {
                                                    Task {
                                                        reportReason = "Bullying or harassment"
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: posterID, postID: postID, reason: reportReason)
                                                        if res == "Success"{
                                                            alertReport = true
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                                openBottomSheet.toggle()
                                                            }
                                                        } else {
                                                            alertFailure = true
                                                        }
                                                    }
                                                }, label: {
                                                    Text("Bullying or harassment")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.black)
                                                })
                                                Divider()
                                            }
                                            VStack{
                                                Button(action: {
                                                    Task {
                                                        reportReason = "Intellectual property violation"
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: posterID, postID: postID, reason: reportReason)
                                                        if res == "Success"{
                                                            alertReport = true
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                                openBottomSheet.toggle()
                                                            }
                                                        } else {
                                                            alertFailure = true
                                                        }
                                                    }
                                                }, label: {
                                                    Text("Intellectual property violation")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.black)
                                                })
                                                Divider()
                                            }
                                            VStack{
                                                Button(action: {
                                                    Task {
                                                        reportReason = "Scam or fraud"
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: posterID, postID: postID, reason: reportReason)
                                                        if res == "Success"{
                                                            alertReport = true
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                                openBottomSheet.toggle()
                                                            }
                                                        } else {
                                                            alertFailure = true
                                                        }
                                                    }
                                                }, label: {
                                                    Text("Scam or fraud")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.black)
                                                })
                                                Divider()
                                            }
                                        }
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/70)
                                    Spacer()
                                }
                                .toast(isPresenting: $alertFailure, duration: 2, tapToDismiss: true){
                                    AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try Again")
                                }
                                .toast(isPresenting: $alertReport, duration: 2, tapToDismiss: true){
                                    AlertToast( type: .systemImage("checkmark.square.fill", greenUi), title: "Reported")
                                }
                            }
                        }
                        .presentationDetents([.medium, .large])
                    })
                    ScrollView{
                        HStack{
                            //profilepic
                            NavigationLink(destination: {
                                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: role, mainUser: false, userID: posterID)
                            }, label: {
                                ProfilePictureView(profilePic: postProfilePic, verified: verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                            })
                            VStack(alignment: .leading) {
                                //name
                                NavigationLink(destination: {
                                    ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: role, mainUser: false, userID: posterID)
                                }, label: {
                                    Text(postUserFullName)
                                        .foregroundColor(.black)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .frame(alignment: .leading)
                                })
                                //profile
                                if postUserDesignation != "" {
                                    Text(postUserDesignation)
                                        .foregroundColor(.black)
                                        .font(.footnote)
                                        .fontWeight(.thin)
                                        .frame(alignment: .leading)
                                }
                                //location
                                if postUserLocation != "" {
                                    Text(postUserLocation)
                                        .foregroundColor(.black)
                                        .font(.footnote)
                                        .fontWeight(.thin)
                                        .frame(alignment: .leading)
                                }
                            }
                            
                            Spacer()
                            //time
                            Text(relativeTime(from: postTime) ?? "")
                                .foregroundColor(.black)
                                .font(.footnote)
                                .fontWeight(.thin)
                                .frame(alignment: .leading)
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .padding(.vertical, UIScreen.screenHeight/70)
                        
                        PostImageWithoutBottomNav(media: media, likeCount: $likeCount, postID: postID, loginData: loginData, posterID: posterID, liked: $liked, saved: $saved, commentCount: $commentCount, globalVM: globalVM, currentIndex: $currentIndex)
                        
                        VStack (spacing: 0){
                            HStack(spacing: 2) {
                                if media.count != 1 {
                                    ForEach((0..<media.count), id: \.self) { index in
                                        Circle()
                                            .fill(index == currentIndex ? Color.black : Color.black.opacity(0.3))
                                            .frame(width: UIScreen.screenHeight/130, height: UIScreen.screenHeight/130)
                                    }
                                }
                            }
                            .padding(.top, UIScreen.screenHeight/60)
                            HStack{
                                //likebutton
                                
                                Button(action: {
                                    if liked == "not liked" {
                                        mainfeedService.likePost(loginData: loginData, postID: postID, posterID: posterID)
                                        likeCount = likeCount + 1
                                        liked = "liked"
                                    } else {
                                        mainfeedService.likePost(loginData: loginData, postID: postID, posterID: posterID)
                                        likeCount = likeCount - 1
                                        liked = "not liked"
                                    }
                                }, label: {
                                    VStack {
                                        Image(liked == "not liked" ? "PostLikeBlack" : "PostLikedBlack" )
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                        if likeCount != 0 {
                                            Text(String(likeCount))
                                                .foregroundColor(.black)
                                                .font(.footnote)
                                                .fontWeight(.regular)
                                        }
                                        Spacer()
                                    }
                                })
                                
                                //comment
                                Button(action: {
                                    print("open comment screen")
                                    globalVM.commentList = CommentServiceModel(post: Post5355(id: "", userID: "", postID: "", comments: [Comment5355](), v: 0), commentCount: 0)
                                    mainfeedService.getCommentPost(globalVM: globalVM, postID: postID)
                                    showCommentSheet = true
                                }, label: {
                                    VStack {
                                        Image("PostCommentBlack")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                        if commentCount != 0 {
                                            Text(String(commentCount))
                                                .foregroundColor(.black)
                                                .font(.footnote)
                                                .fontWeight(.regular)
                                        }
                                        Spacer()
                                    }
                                })
                                .sheet(isPresented: $showCommentSheet) {
                                    CommentBottomSheetView(globalVM: globalVM, postID: postID, posterID: posterID, loginData: loginData, commentCount: $commentCount)
                                        .presentationDetents([.medium, .large])
                                        .presentationDragIndicator(.visible)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    print("open share bottomsheet")
                                    globalVM.getConnectionList = [ProfileConnectionListModel]()
                                    makeAPICall(globalVM: globalVM, userID:loginData.mainUserID)
                                    globalVM.showSharePostBottomSheet.toggle()
                                }, label: {
                                    VStack {
                                        Image("PostShareBlack")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                        Spacer()
                                    }
                                })
                                .sheet(isPresented: $globalVM.showSharePostBottomSheet) {
                                    SendImagePostBottomSheet(loginData: loginData, globalVM: globalVM, postID: postID, firstImageLink: media[0].post, caption: postCaption )
                                        .presentationDetents([.medium, .large])
                                }
                                
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
                                    VStack{
                                        Image(saved == "not saved" ? "PostSaveBlack" : "PostSavedBlack")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                        Spacer()
                                    }
                                })
                            }
                            .frame(height: UIScreen.screenHeight/10)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .padding(.top, UIScreen.screenHeight/50)
                        }
                        .frame(height: UIScreen.screenHeight/40)
                        .padding(.vertical, UIScreen.screenHeight/70)
                        //caption display
                        
                        HStack{
                            VStack{
                                if postUserName != "" {
                                    Text(postUserName)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .frame(alignment: .leading)
                                } else {
                                    Text(globalVM.postDetails[0].fullName)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .frame(alignment: .leading)
                                }
                                Spacer()
                            }
                            VStack{
                                Text(postCaption)
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .frame(alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            Spacer()
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        
                        VStack{
                            VStack{
                                HStack{
                                    Text("Liked By")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                HStack{
                                    Text("\(likeCount) people have liked this.")
                                        .font(.footnote )
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                            }
                            .padding(.vertical, UIScreen.screenHeight/70)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .onTapGesture {
                                navigateToLikedUserListScreen.toggle()
                            }
                            .navigationDestination(isPresented: $navigateToLikedUserListScreen, destination: {
                                
                                    LikedUserListView(globalVM: globalVM, postID: postID, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM)
                            })
                            NavigationLink(isActive: $navigateToLikedUserListScreen, destination: {
                                LikedUserListView(globalVM: globalVM, postID: postID, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM)
                            }, label: {Text("")})
                            
                            Spacer()
                        }
                    }
                }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            mainfeedService.getCommentPost(globalVM: globalVM, postID: postID)
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

//struct PostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailView()
//    }
//}
