//
//  ProfilePostDetailView.swift
//  R-own
//
//  Created by Aman Sharma on 11/06/23.
//

import SwiftUI
import AlertToast

struct ProfilePostDetailView: View {
    
    @State var navigateToLikedUserListScreen: Bool = false
    @State var post: Post643
    @State var newComment: String = ""
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var mainfeedService = MainFeedService()
    
    @FocusState private var isKeyboardShowing: Bool
    
    @StateObject var profileVM: ProfileViewModel
//    @State var role: String
    @StateObject var mesiboVM: MesiboViewModel
//
    @StateObject var profileService = ProfileService()
    @StateObject var saveService = SaveElemetsIDService()
//
    @State var showCommentSheet: Bool = false
    @State var navigateToProfileView: Bool = false
    @State var mainUser: Bool
    @Environment(\.dismiss) private var dismiss
    @State var showEditSheet: Bool = false
    @State var showEditPost: Bool = false
    @State var showDeletePost: Bool = false
    @State var currentIndex: Int = 0
    
    @StateObject var postService = PostsService()
    //
//    @FocusState private var isKeyboardShowing: Bool
    
    @State var openBottomSheet: Bool = false
    
    @State var alertReport: Bool = false
    @State var alertFailure: Bool = false
    @State var reportReason: String = ""
    
    @StateObject var mainUserService = MainUserService()
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack {
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
                            if mainUser {
                                showEditSheet = true
                            } else {
                                print("not main")
                            }
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
                    .sheet(isPresented: $showEditSheet, content: {
                        VStack{
                            Button(action: {
                                showEditPost = true
                            }, label: {
                                HStack{
                                    Image("CommunityEditIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                    Text("Edit Post")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                .padding(.leading, UIScreen.screenWidth/10)
                            })
                            .sheet(isPresented: $showEditPost, content: {
                                VStack{
                                    Text("Edit your post")
                                        .font(.headline)
                                    VStack{
                                        
                                        
                                        TextEditor(text: $post.caption)
                                            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenWidth/5)
                                            .lineLimit(nil) // Allow multiple lines
                                            .focused($isKeyboardShowing)
                                            .toolbar {
                                                ToolbarItemGroup(placement: .keyboard) {
                                                    Spacer()
                                                    
                                                    Button("Done") {
                                                        
                                                        isKeyboardShowing = false
                                                        globalVM.keyboardVisibility = false
                                                    }
                                                }
                                            }
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(.black.opacity(0.5), lineWidth: 1)
                                            ) // Add border
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        if post.caption == "" {
                                                            Text("What do you want to share today?")
                                                                .font(.footnote)
                                                                .foregroundColor(.black.opacity(0.5))
                                                                .padding()
                                                        }
                                                        Spacer()
                                                    }
                                                    Spacer()
                                                }
                                            }
                                            .onChange(of: post.caption) { newText in
                                                // Limit text to maxCharacterLimit
                                                if newText.count > 6000 {
                                                    post.caption = String(newText.prefix(6000))
                                                }
                                            }
                                        
                                        Button(action: {
                                            Task{
                                                loginData.showLoader = true
                                                let res = await postService.editPost(postID: post.postID, caption: post.caption, location: post.location, canSee: post.canSee, Can_comment: post.canComment)
                                                if res == "Success"{
                                                    showEditPost = false
                                                    showEditSheet = false
                                                    loginData.showLoader = false
                                                    dismiss()
                                                }
                                            }
                                        }, label: {
                                            Text("Update")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                                .padding(.horizontal, UIScreen.screenWidth/10)
                                                .padding(.vertical, UIScreen.screenHeight/70)
                                                .background(greenUi)
                                                .cornerRadius(10)
                                        })
                                    }
                                }
                            })
                            
                            
                            Divider()
                            
                            Button(action: {
                                showDeletePost = true
                            }, label: {
                                HStack{
                                    Image("CommunityDeleteIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                    Text("Delete Post")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                .padding(.leading, UIScreen.screenWidth/10)
                            })
                            .sheet(isPresented: $showDeletePost, content: {
                                VStack{
                                    Text("Do you really want to delete this post?")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                    
                                    VStack{
                                        Button(action: {
                                            Task{
                                                loginData.showLoader = true
                                                let res = await postService.deletePost(postID: post.postID, display_status: "0")
                                                if res == "Success"{
                                                    showEditSheet = false
                                                    showDeletePost = false
                                                    loginData.showLoader = false
                                                    dismiss()
                                                }
                                            }
                                        }, label: {
                                            Text("Yes, I'm sure")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                                .padding(.horizontal, UIScreen.screenWidth/10)
                                                .padding(.vertical, UIScreen.screenHeight/70)
                                                .background(greenUi)
                                                .cornerRadius(10)
                                        })
                                        
                                        Button(action: {
                                            showDeletePost = false
                                        }, label: {
                                            Text("No")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                                .foregroundColor(greenUi)
                                                .padding(.horizontal, UIScreen.screenWidth/10)
                                                .padding(.vertical, UIScreen.screenHeight/70)
                                                .background(jobsDarkBlue)
                                                .cornerRadius(10)
                                        })
                                        
                                        
                                    }
                                }
                            })
                        }
                        .presentationDetents([.medium])
                    })
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
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: post.userID, postID: post.postID, reason: reportReason)
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
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: post.userID, postID: post.postID, reason: reportReason)
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
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: post.userID, postID: post.postID, reason: reportReason)
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
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: post.userID, postID: post.postID, reason: reportReason)
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
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: post.userID, postID: post.postID, reason: reportReason)
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
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: post.userID, postID: post.postID, reason: reportReason)
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
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: post.userID, postID: post.postID, reason: reportReason)
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
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: post.userID, postID: post.postID, reason: reportReason)
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
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: post.userID, postID: post.postID, reason: reportReason)
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
                                                        let res = await mainUserService.reportUser(reportType: "Post Report", reporterUserID: loginData.mainUserID, reportedUserID: post.userID, postID: post.postID, reason: reportReason)
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
//                            NavigationLink(isActive: $navigateToProfileView, destination: {
//                                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: , mainUser: false, userID: post.userID)
//                            }, label: {Text("")})
                            ProfilePictureView(profilePic: post.profilePic, verified: post.verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                                .onTapGesture {
                                    navigateToProfileView.toggle()
                                    print("move to profile screen")
                                }
//                                .navigationDestination(isPresented: $navigateToProfileView, destination: {
//                                    ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: , mainUser: false, userID: post.userID)
//                                })
                            VStack(alignment: .leading) {
                                //name
                                Text(post.fullName)
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                                    .onTapGesture {
                                        navigateToProfileView.toggle()
                                    }
                                //profile
                                if post.jobTitle != "" {
                                    Text(post.jobTitle)
                                        .foregroundColor(.black)
                                        .font(.footnote)
                                        .fontWeight(.thin)
                                        .frame(alignment: .leading)
                                }
                                //location
                                if post.location != "" {
                                    Text(post.location)
                                        .foregroundColor(.black)
                                        .font(.footnote)
                                        .fontWeight(.thin)
                                        .frame(alignment: .leading)
                                }
                            }
                            Spacer()
                            //time
                            Text(relativeTime(from: post.dateAdded) ?? "")
                                .foregroundColor(.black)
                                .font(.footnote)
                                .fontWeight(.thin)
                                .frame(alignment: .leading)
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .padding(.vertical, UIScreen.screenHeight/70)
                        
                        ProfileImageViewWithoutBottomNav(media: post.media, likeCount: $post.likeCount, postID: post.postID, loginData: loginData, posterID: post.userID, liked: $post.liked, saved: $post.saved, commentCount: $post.commentCount, globalVM: globalVM, currentIndex: $currentIndex)
                        
                        VStack (spacing: 0){
                            HStack(spacing: 2) {
                                if post.media.count != 1 {
                                    ForEach((0..<post.media.count), id: \.self) { index in
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
                                    if post.liked == "not liked" {
                                        mainfeedService.likePost(loginData: loginData, postID: post.postID, posterID: post.userID)
                                        post.likeCount = post.likeCount + 1
                                        post.liked = "liked"
                                    } else {
                                        mainfeedService.likePost(loginData: loginData, postID: post.postID, posterID: post.userID)
                                        post.likeCount = post.likeCount - 1
                                        post.liked = "not liked"
                                    }
                                }, label: {
                                    VStack {
                                        Image(post.liked == "not liked" ? "PostLikeBlack" : "PostLikedBlack" )
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                        if post.likeCount != 0 {
                                            Text(String(post.likeCount))
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
                                    mainfeedService.getCommentPost(globalVM: globalVM, postID: post.postID)
                                    showCommentSheet = true
                                }, label: {
                                    VStack {
                                        Image("PostCommentBlack")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                        if post.commentCount != 0 {
                                            Text(String(post.commentCount))
                                                .foregroundColor(.black)
                                                .font(.footnote)
                                                .fontWeight(.regular)
                                        }
                                        Spacer()
                                    }
                                })
                                .sheet(isPresented: $showCommentSheet) {
                                    CommentBottomSheetView(globalVM: globalVM, postID: post.postID, posterID: post.userID, loginData: loginData, commentCount: $post.commentCount)
                                        .presentationDetents([.medium, .large])
                                        .presentationDragIndicator(.visible)
                                }
                                Spacer()
                                Button(action: {
                                    print("open share bottomsheet")
                                    globalVM.getConnectionList = [ProfileConnectionListModel]()
                                    makeAPICall(globalVM: globalVM, userID: loginData.mainUserID)
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
                                    SendImagePostBottomSheet(loginData: loginData, globalVM: globalVM, postID: post.postID, firstImageLink: post.media[0].post, caption: post.caption )
                                }
                                //save
                                Button(action: {
                                    print("saved")
                                    if post.saved == "not saved"{
                                        saveService.savePostID(loginData: loginData, postID: post.postID)
                                        post.saved = "saved"
                                    } else {
                                        saveService.unsavePostID(loginData: loginData, postID: post.postID)
                                        post.saved = "not saved"
                                    }
                                }, label: {
                                    VStack{
                                        Image(post.saved == "not saved" ? "PostSaveBlack" : "PostSavedBlack")
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
                                if post.userName != "" {
                                    Text(post.userName)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .frame(alignment: .leading)
                                } else {
                                    Text(post.fullName)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .frame(alignment: .leading)
                                    
                                }
                                Spacer()
                            }
                            VStack{
                                Text(post.caption)
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
                                    Text("\(post.likeCount) has liked this.")
                                        .font(.footnote )
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                    //                                ZStack{
                                    //                                    ProfilePictureView(profilePic: "", verified: false, height: UIScreen.screenHeight/50, width: UIScreen.screenHeight/50)
                                    //                                    ProfilePictureView(profilePic: "", verified: false, height: UIScreen.screenHeight/50, width: UIScreen.screenHeight/50)
                                    //                                        .offset(x: 6)
                                    //                                    ProfilePictureView(profilePic: "", verified: false, height: UIScreen.screenHeight/50, width: UIScreen.screenHeight/50)
                                    //                                        .offset(x: 12)
                                    //                                }
                                    //                                .padding(.trailing, UIScreen.screenWidth/40)
                                    //                                if likeCount > 4 {
                                    //                                    Text("and \((likeCount-3)) more")
                                    //                                        .font(.system(size: UIScreen.screenHeight/80))
                                    //                                        .fontWeight(.bold)
                                    //                                }
                                    Spacer()
                                }
                            }
                            .padding(.vertical, UIScreen.screenHeight/70)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .onTapGesture {
                                navigateToLikedUserListScreen = true
                            }
                            .navigationDestination(isPresented: $navigateToLikedUserListScreen, destination: {
                                LikedUserListView(globalVM: globalVM, postID: post.postID, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM)
                            })
                            
                            NavigationLink(isActive: $navigateToLikedUserListScreen, destination: {
                                LikedUserListView(globalVM: globalVM, postID: post.postID, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM)
                            }, label: {
                                Text("")}
                            )
                            
                            Spacer()
                        }
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
            navigateToProfileView = false
            navigateToLikedUserListScreen = false
            mainfeedService.getCommentPost(globalVM: globalVM, postID: post.postID)
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

//struct ProfilePostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfilePostDetailView()
//    }
//}
