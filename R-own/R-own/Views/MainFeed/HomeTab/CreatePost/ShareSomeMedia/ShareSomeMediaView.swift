//
//  ShareSomeMediaView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI
import PhotosUI
import Mantis
import AlertToast

struct ShareSomeMediaView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject private var filterViewModel = FilterViewModel()
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var canSeeAudienceName: String = "Anyone"
    @State var canCommentAudienceName: String = "Anyone"
    
    //Image Var
    @State private var showPicker: Bool = false
    
    @State private var cropShapeType: Mantis.CropShapeType = .rect
    @State private var presetFixedRatioType: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 3/4)
    @State private var cropperType: ImageCropperType = .normal
    
    @State private var shouldPresentCropper = false
    @State private var shouldPresentCamera = false
    
    @State var selectedImage: Int = 0
    @State private var image: UIImage?
    @State var imageList = [UIImage]()
    
    
//    @StateObject var imagePicker = ImagePicker2()
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    @State var navigateToPhotoEfitor: Bool = false
    
    @State var postType: String = "share some media"
    
    @StateObject var postService = PostsService()
    
    @State var alertNoPic: Bool = false
    @State var alertCantPost: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentUrl: URL?
    
    var body: some View {
                ZStack{
                    VStack{
                        //nav
                        HStack{
                            Button(action: {
                                dismiss()
                            }, label: {
                                Image(systemName: "arrow.left.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.black)
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            })
                            Spacer()
                            Button(action: {
                                if imageList.count != 0 {
                                    Task{
                                        let res: String = await postService.postShareSomeMediaService(loginData: loginData, postCaption: createPostVM.postCaption, location: createPostVM.postLoction, postType: postType, canSee: canSeeAudienceName, canComment: canCommentAudienceName, imageList: imageList)
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
                        ScrollView{
                            VStack{
                                //postview
                                HStack{
                                    //profilepic
                                    if loginData.mainUserProfilePic == "" {
                                        Image("UserIcon")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                            .padding(.trailing, 10)
                                    } else {
                                        AsyncImage(url: currentUrl) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        } placeholder: {
                                            Color.purple.opacity(0.1)
                                        }
                                        .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                        .clipShape(Circle())
                                        .padding(.trailing, 10)
                                        .onAppear {
                                            if currentUrl == nil {
                                                DispatchQueue.main.async {
                                                    currentUrl = URL(string: loginData.mainUserProfilePic)
                                                }
                                            }
                                        }
                                    }
                                    
                                    //profile
                                    VStack(alignment: .leading){
                                        Text(loginData.mainUserFullName)
                                            .font(.body)
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
                                
                                Divider()
                                
                                
                                
                                //Image Preview
                                VStack{
                                    if selectedImage == 0 {
                                        Image(systemName: "plus.app.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: UIScreen.screenHeight/5)
                                            .foregroundColor(postBgGrey)
                                    } else {
                                        VStack{
                                            Image(uiImage: imageList[selectedImage-1])
                                                .resizable()
                                                .scaledToFit()
                                                .border(.black)
                                                .frame(height: UIScreen.screenHeight/5)
                                                .clipped()
                                                .overlay{
                                                    VStack{
                                                        HStack{
                                                            Spacer()
                                                            Image("DeleteIcon")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: UIScreen.screenWidth/80, height: UIScreen.screenWidth/80)
                                                                .padding(2)
                                                                .background(greenUi)
                                                                .onTapGesture {
                                                                    if selectedImage == imageList.count {
                                                                        selectedImage -= 1
                                                                        imageList.remove(at: selectedImage)
                                                                    } else {
                                                                        imageList.remove(at: (selectedImage-1))
                                                                    }
                                                                }
                                                                .padding()
                                                        }
                                                        Spacer()
                                                    }
                                                }
                                        }
                                    }
                                }
                                
                                HStack {
                                    Spacer()
                                    ScrollView {
                                        LazyVGrid(columns: columns, spacing: 20) {
                                            ForEach(0..<imageList.count, id: \.self) { index in
                                                Image(uiImage: imageList[index])
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                    .border(.black)
                                                    .clipped()
                                                    .onTapGesture {
                                                        selectedImage = index + 1
                                                    }
                                            }
                                            if imageList.count != 5{
                                                Image(systemName: "plus.app.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                    .foregroundColor(postBgGrey)
                                                    .onTapGesture {
                                                        self.shouldPresentCamera = true
                                                    }
                                                    .sheet(isPresented: $shouldPresentCamera) {
                                                        ImagePickerView(image: $image)
                                                            .onAppear(perform: {
                                                                image = nil
                                                            })
                                                            .onDisappear(perform: {
                                                                if image != nil {
                                                                    shouldPresentCropper = true
                                                                }
                                                            })
                                                    }
                                                    .fullScreenCover(isPresented: $shouldPresentCropper, content: {
                                                        ImageCropper(image: $image,
                                                                     cropShapeType: $cropShapeType,
                                                                     presetFixedRatioType: $presetFixedRatioType,
                                                                     type: $cropperType,
                                                                     cropMandatory: true)
                                                        .ignoresSafeArea()
                                                        .onDisappear {
                                                            if image != nil {
                                                                imageList.append(image!)
                                                            }
                                                        }
                                                    })
                                            }
                                        }
                                    }
                                    Spacer()
                                }
                                .padding()
                                
                                Spacer()
                                
                            }
                        }
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
                    AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "No image", subTitle: ("Select atleast one pic to post"))
                }
                .toast(isPresenting: $alertCantPost, duration: 2, tapToDismiss: true){
                    AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try again!", subTitle: ("Unable to post"))
                }
                .navigationBarBackButtonHidden()
    }
}

//struct ShareSomeMediaView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShareSomeMediaView()
//    }
//}
