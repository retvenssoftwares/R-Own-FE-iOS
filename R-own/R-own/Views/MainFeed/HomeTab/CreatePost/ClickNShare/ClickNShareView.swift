//
//  ClickNShareView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI
import Mantis
import AlertToast

struct ClickNShareView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    
    @StateObject private var filterViewModel = FilterViewModel()
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var canSeeAudienceName: String = "Anyone"
    @State var canCommentAudienceName: String = "Anyone"
    
    @State private var clickNShareImage: UIImage?
    @State private var photoToBeChaged: Image?
    @State private var shouldPresentCropper = false
    @State private var shouldPresentCamera = false
    
    @State var navigateToPhotoEfitor: Bool = false
    @State var postCaption: String = ""
    
    @State var postType: String = "click and share"
    
    @State private var cropShapeType: Mantis.CropShapeType = .rect
    @State private var presetFixedRatioType: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 3/4)
    @State private var cropperType: ImageCropperType = .normal
    
    @StateObject var postService = PostsService()
    
    @State var alertNoPic: Bool = false
    @State var alertCantPost: Bool = false
    
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var globalVM: GlobalViewModel
    
    @State private var currentUrl: URL?
    
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
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            if clickNShareImage != nil {
                                Task{
                                    let res: String = await postService.postClickNShareService(loginData: loginData, postCaption: postCaption, location: createPostVM.postLoction, postType: postType, canSee: canSeeAudienceName, canComment: canCommentAudienceName, image: clickNShareImage!)
                                    if res == "Success" {
                                        dismiss()
                                    } else if res == "Failure" {
                                        alertCantPost = true
                                    }
                                }
                            } else {
                                alertNoPic = true
                            }
                        }, label: {
                            Text("Share")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, UIScreen.screenWidth/40)
                                .padding(.vertical, UIScreen.screenHeight/80)
                                .background(greenUi)
                                .cornerRadius(10)
                        })
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/15)
                    .background(.white)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    
                    //postview
                    HStack{
                        
                        //profilepic
                        ProfilePictureView(profilePic: loginData.mainUserProfilePic, verified: false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                        
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
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .padding(.vertical, UIScreen.screenHeight/20)
                    
                    
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
                        .overlay{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.black.opacity(0.5), lineWidth: 1)
                        } // Add border
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
                    
                    Divider()
                    
                    VStack{
                        //Image Preview
                        if clickNShareImage == nil {
                            Image(systemName: "plus.app.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: UIScreen.screenHeight/4)
                                .foregroundColor(postBgGrey)
                                .onTapGesture {
                                    self.shouldPresentCamera = true
                                }
                        } else {
                            Image(uiImage: clickNShareImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: UIScreen.screenHeight/4)
                                .onTapGesture {
                                    self.shouldPresentCamera = true
                                }
                        }
                    }
                    .sheet(isPresented: $shouldPresentCamera) {
                        CameraView(image: $clickNShareImage)
                            .onAppear(perform: {
                                clickNShareImage = nil
                            })
                            .onDisappear(perform: {
                                if clickNShareImage != nil {
                                    shouldPresentCropper = true
                                }
                            })
                    }
                    .fullScreenCover(isPresented: $shouldPresentCropper, content: {
                        ImageCropper(image: $clickNShareImage,
                                     cropShapeType: $cropShapeType,
                                     presetFixedRatioType: $presetFixedRatioType,
                                     type: $cropperType,
                                     cropMandatory: true)
                        .ignoresSafeArea()
                    })
                    
                    Spacer()
                    
                    //Button to edit image
                    //                Button(action: {
                    //                    if clickNShareImage != nil {
                    //                        filterViewModel.inputImage = clickNShareImage
                    //                        filterViewModel.loadImage()
                    //                        filterViewModel.currentImage = 0
                    //                        navigateToPhotoEfitor.toggle()
                    //                    }
                    //                }, label: {
                    //                    Text("Apply filter on selected image")
                    //                        .font(.system(size: UIScreen.screenHeight/80))
                    //                        .fontWeight(.regular)
                    //                        .foregroundColor(.white)
                    //                        .padding(.horizontal, UIScreen.screenWidth/40)
                    //                        .padding(.vertical, UIScreen.screenHeight/70)
                    //                        .background(greenUi)
                    //                        .shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 5)
                    //                })
                    //                .padding(.vertical, UIScreen.screenHeight/40)
                    //                .navigationDestination(isPresented: $navigateToPhotoEfitor, destination: {
                    //                    SinglePhotoEditView(filterViewModel: filterViewModel, photoTobeChanged: $clickNShareImage)
                    //                })
                }
                CommentAudienceBottomSheet(loginData: loginData, createPostVM: createPostVM, audienceName: $canCommentAudienceName)
                CanSeeAudienceBottomSheet(loginData: loginData, createPostVM: createPostVM, audienceName: $canSeeAudienceName, commentAudienceName: $canCommentAudienceName)
                MainLocationBottomSheetView(loginData: loginData, globalVM: globalVM, location: $createPostVM.postLoction)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                isKeyboardShowing = false
                globalVM.keyboardVisibility = false
            }
            .toast(isPresenting: $alertNoPic, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "No image", subTitle: ("Select a pic to post"))
            }
            .toast(isPresenting: $alertCantPost, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try again!", subTitle: ("Unable to post"))
            }
            .navigationBarBackButtonHidden()
        }
    }
}

//struct ClickNShareView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClickNShareView()
//    }
//}
