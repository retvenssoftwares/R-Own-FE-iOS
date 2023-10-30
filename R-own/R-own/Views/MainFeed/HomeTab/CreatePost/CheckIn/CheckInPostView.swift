//
//  CheckInPostView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI
import Shimmer
import AlertToast

struct CheckInPostView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    
    @StateObject var globalVM: GlobalViewModel
    
    @State var navigateToHomeView: Bool = false
    
    @State var canSeeAudienceName: String = "Anyone"
    @State var canCommentAudienceName: String = "Anyone"
    
    @State var postType: String = "Check-in"
    
    @StateObject var postService = PostsService()
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var alertCantPost: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentUrl1: URL?
    @State private var currentUrl2: URL?
    @State private var currentUrl3: URL?
    
    var body: some View {
        NavigationStack{
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
                            Task{
                                let res: String = await postService.postCheckInsService(loginData: loginData, postCaption: createPostVM.postCaption, location: createPostVM.postLoction, postType: postType, canSee: canSeeAudienceName, canComment: canCommentAudienceName, checkInLocation: createPostVM.checkinHotelAddress, checkInVenue: createPostVM.checkinHotelName, hotelID: createPostVM.checkinHotelID)
                                if res == "Success" {
                                    dismiss()
                                } else if res == "Failure" {
                                    alertCantPost = true
                                }
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
                        if loginData.mainUserProfilePic == "" {
                            Image("UserIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                .padding(.trailing, 10)
                        } else {
                            AsyncImage(url: currentUrl1) { image in
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
                                if currentUrl1 == nil {
                                    DispatchQueue.main.async {
                                        currentUrl1 = URL(string: loginData.mainUserProfilePic)
                                    }
                                }
                            }
                        }
                        
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
                        .frame(width: UIScreen.screenWidth/1.2)
                    
                    AsyncImage(url: currentUrl2) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/3, height: UIScreen.screenHeight/3)
                            .overlay{
                                VStack{
                                    
                                    Spacer()
                                    HStack{
                                        AsyncImage(url: currentUrl3) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                                .clipShape(Circle())
                                                .padding()
                                        } placeholder: {
                                            Circle()
                                                .fill(lightGreyUi)
                                                .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                                .shimmering(active: true)
                                                .padding()
                                        }
                                        .onAppear {
                                            if currentUrl3 == nil {
                                                DispatchQueue.main.async {
                                                    currentUrl3 = URL(string: createPostVM.checkinHotelLogo)
                                                }
                                            }
                                        }
                                        VStack(alignment: .leading){
                                            Text(createPostVM.checkinHotelName)
                                                .font(.body)
                                                .fontWeight(.regular)
                                            Text(createPostVM.checkinHotelRating)
                                                .font(.body)
                                                .fontWeight(.regular)
                                        }
                                        Spacer()
                                    }
                                    .frame(width: UIScreen.screenWidth/2.5)
                                    .background(.white)
                                    .cornerRadius(5)
                                    .shadow(color: .black.opacity(0.2), radius: 5, x:0, y:0)
                                }
                                .padding(.vertical, UIScreen.screenHeight/70)
                            }
                    } placeholder: {
                        Rectangle()
                            .fill(lightGreyUi)
                            .frame(width: UIScreen.screenHeight/3, height: UIScreen.screenHeight/3)
                            .shimmering(active: true)
                    }
                    .onAppear {
                        if currentUrl2 == nil {
                            DispatchQueue.main.async {
                                currentUrl2 = URL(string: createPostVM.checkinHotelCoverPic.replacingOccurrences(of: " ", with: "%20"))
                            }
                        }
                    }
                    Spacer()
                }
                CommentAudienceBottomSheet(loginData: loginData, createPostVM: createPostVM, audienceName: $canCommentAudienceName)
                CanSeeAudienceBottomSheet(loginData: loginData, createPostVM: createPostVM, audienceName: $canSeeAudienceName, commentAudienceName: $canCommentAudienceName)
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .toast(isPresenting: $alertCantPost, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try again!", subTitle: ("Unable to post"))
        }
        .navigationBarBackButtonHidden()
    }
}
//struct CheckInPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckInPostView()
//    }
//}
