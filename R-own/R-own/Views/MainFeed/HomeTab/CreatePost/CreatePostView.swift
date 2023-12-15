//
//  CreatePostView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI
import AlertToast

struct CreatePostView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @FocusState private var isKeyboardShowing: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    @State var canSeeAudienceName: String = "Anyone"
    @State var canCommentAudienceName: String = "Anyone"
    
    @State var postType: String = "normal status"
    
    @State var alertNoStatusCaption: Bool = false
    
    @StateObject var postService = PostsService()
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    //nav
                    HStack{
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                        })
                        Spacer()
                        Button(action: {
                            if createPostVM.postCaption == "" {
                                alertNoStatusCaption = true
                            } else {
                                Task{
                                    do {
                                        let result = try await postService.postNormalStatusService(loginData: loginData, postCaption: createPostVM.postCaption, location: createPostVM.postLoction, postType: postType, canSee: canSeeAudienceName, canComment: canCommentAudienceName)

                                        if result == "Success" {
                                            // Handle success
                                            dismiss()
                                        } else {
                                            // Handle other success cases or failures
                                            print("Post failed.")
                                        }
                                    } catch {
                                        // Handle errors
                                        print("Error: \(error)")
                                    }

                                }
                            }
                        }, label: {
                            Text("Share")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, UIScreen.screenWidth/40)
                                .padding(.vertical, UIScreen.screenHeight/100)
                                .background(greenUi)
                                .cornerRadius(5)
                        })
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/15)
                    .background(.white)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    
                    //postview
                    HStack{
                        //profilepic
                        ProfilePictureView(profilePic: loginData.mainUserProfilePic, verified: loginData.mainUserVerificationStatus == "false" ? false : true, height: UIScreen.screenHeight/10, width: UIScreen.screenHeight/10)
                        
                        //profile
                        VStack(alignment: .leading){
                            Text(loginData.mainUserFullName)
                                .font(.headline)
                                .fontWeight(.bold)
                            HStack{
                                HStack{
                                    Image("PostsCanSeeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                    
                                    if canSeeAudienceName == "" {
                                        Text("Can See")
                                            .font(.body)
                                    } else {
                                        Text(canSeeAudienceName)
                                            .font(.body)
                                    }
                                    
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/100, height: UIScreen.screenHeight/100)
                                }
                                .padding(5)
                                .background(.white)
                                .cornerRadius(5)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 1))
                                .onTapGesture {
                                    createPostVM.canSeeAudienceBottomSheet.toggle()
                                }
                                HStack{
                                    Image("PostsCanCommentIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                    
                                    
                                    if canCommentAudienceName == "" {
                                        Text("Can Comment")
                                            .font(.body)
                                    } else {
                                        Text(canCommentAudienceName)
                                            .font(.body)
                                    }
                                    
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/100, height: UIScreen.screenHeight/100)
                                }
                                .padding(5)
                                .background(.white)
                                .cornerRadius(5)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 1))
                                .onTapGesture {
                                    createPostVM.canCommentAudienceBottomSheet.toggle()
                                }
                            }
                        }
                        Spacer()
                        Button(action: {
                            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                            createPostVM.postTypeBottomSheet.toggle()
                        }, label: {
                            Image("PostsGalleryIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                        })
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .padding(.top, UIScreen.screenHeight/20)
                    .padding(.bottom, UIScreen.screenHeight/40)
                    
                    AutoFetchLocationTab(autoLocation: $createPostVM.postLoction, loginData: loginData, globalVM: globalVM, width: UIScreen.screenWidth/1.2)
                    
                    TextEditor(text: $createPostVM.postCaption)
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
                                    if createPostVM.postCaption == "" {
                                        Text("What do you want to share today?")
                                            .foregroundColor(.black.opacity(0.5))
                                            .padding()
                                    }
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                        .onChange(of: createPostVM.postCaption) { newText in
                            // Limit text to maxCharacterLimit
                            if newText.count > 6000 {
                                createPostVM.postCaption = String(newText.prefix(6000))
                            }
                        }
                    
                    
                    Spacer()
                }
                .toast(isPresenting: $alertNoStatusCaption, duration: 2, tapToDismiss: true){
                    AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Enter Status", subTitle: ("Enter your status to post"))
                }
                PostTypeBottomSheet(loginData: loginData, createPostVM: createPostVM, globalVM: globalVM, profileVM: profileVM)
                CommentAudienceBottomSheet(loginData: loginData, createPostVM: createPostVM, audienceName: $canCommentAudienceName)
                CanSeeAudienceBottomSheet(loginData: loginData, createPostVM: createPostVM, audienceName: $canSeeAudienceName, commentAudienceName: $canCommentAudienceName)
                MainLocationBottomSheetView(loginData: loginData, globalVM: globalVM, location: $createPostVM.postLoction)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                isKeyboardShowing = false
                globalVM.keyboardVisibility = false
            }
            .onAppear{
                createPostVM.canSeeAudienceBottomSheet = false
                createPostVM.canCommentAudienceBottomSheet = false
                createPostVM.postCaption = ""
                createPostVM.postLoction = ""
                createPostVM.postTypeBottomSheet = false
            }
            .navigationBarBackButtonHidden()
        }
    }
}

//struct CreatePostView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePostView()
//    }
//}
