//
//  UpdateEventPostView.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI
import Shimmer

struct UpdateEventPostView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    
    @StateObject var eventService = UserEventService()
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var postService = PostsService()
    @State var navigateToHomeView: Bool = false
    
    @State var canSeeAudienceName: String = ""
    @State var canCommentAudienceName: String = ""
    
    @State var postType: String = "Update about an event"
    
    @Environment(\.dismiss) private var dismiss
    
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
                            navigateToHomeView.toggle()
                            postService.postUpdateEventService(loginData: loginData, postCaption: createPostVM.postCaption, location: createPostVM.postLocation, postType: postType, canSee: canSeeAudienceName, canComment: canCommentAudienceName, eventID: createPostVM.selectedEventID, eventLocation: createPostVM.postLocation)
                        }, label: {
                            Text("Share")
                                .font(.system(size: UIScreen.screenHeight/90))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, UIScreen.screenWidth/40)
                                .padding(.vertical, UIScreen.screenHeight/80)
                                .cornerRadius(5)
                                .background(greenUi)
                        })
                        .navigationDestination(isPresented: $navigateToHomeView, destination: {
//                            MainFeedView(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
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
                            AsyncImage(url: URL(string: loginData.mainUserProfilePic)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Color.purple.opacity(0.1)
                            }
                            .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                            .clipShape(Circle())
                            .padding(.trailing, 10)
                        }
                        
                        //profile
                        VStack(alignment: .leading){
                            Text(loginData.mainUserFullName)
                                .font(.system(size: UIScreen.screenHeight/60))
                                .fontWeight(.bold)
                            HStack{
                                HStack{
                                    Image("PostsCanSeeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                    
                                    if canSeeAudienceName == "" {
                                        Text("Can See")
                                            .font(.system(size: UIScreen.screenHeight/90))
                                    } else {
                                        Text(canSeeAudienceName)
                                            .font(.system(size: UIScreen.screenHeight/90))
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
                                            .font(.system(size: UIScreen.screenHeight/90))
                                    } else {
                                        Text(canCommentAudienceName)
                                            .font(.system(size: UIScreen.screenHeight/90))
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
                    
                    ZStack{
                        TextEditor(text: $createPostVM.postCaption)
                            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenWidth/6)
                            .font(.system(size: UIScreen.screenHeight/60))
                        if createPostVM.postCaption == "" {
                            Text("What do want to share today ?")
                                .foregroundColor(.black.opacity(0.5))
                                .offset(x: -UIScreen.screenWidth/4, y: -UIScreen.screenHeight/20)
                            
                        }
                    }
                    Divider()
                        .frame(width: UIScreen.screenWidth/1.2)
                    if globalVM.eventDetailsByEventID.count > 0 {
                        VStack(alignment: .leading){
                            AsyncImage(url: URL(string: globalVM.eventDetailsByEventID[0].eventThumbnail)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.screenHeight/4, height: UIScreen.screenHeight/4)
                                    .cornerRadius(5)    // Error here
                            } placeholder: {
                                //put your placeholder here
                                Rectangle()
                                    .fill(lightGreyUi)
                                    .frame(width: UIScreen.screenHeight/4, height: UIScreen.screenHeight/4)
                                    .shimmering(active: true)
                            }
                            Text(globalVM.eventDetailsByEventID[0].eventTitle)
                                .font(.system(size: UIScreen.screenHeight/80))
                                .fontWeight(.regular)
                                .padding(.horizontal, UIScreen.screenWidth/50)
                            VStack{
                                HStack{
                                    AsyncImage(url: URL(string: globalVM.eventDetailsByEventID[0].profilePic ?? "")) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                            .cornerRadius(15)
                                    } placeholder: {
                                        //put your placeholder here
                                        Rectangle()
                                            .fill(lightGreyUi)
                                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                            .shimmering(active: true)
                                    }
                                    Text(globalVM.eventDetailsByEventID[0].userName ?? "fetchin user name")
                                        .font(.system(size: UIScreen.screenHeight/110))
                                        .fontWeight(.thin)
                                    Spacer()
                                }
                                Divider()
                                HStack{
                                    Text(globalVM.eventDetailsByEventID[0].categoryName ?? "fetchin category name")
                                        .font(.system(size: UIScreen.screenHeight/110))
                                        .fontWeight(.regular)
                                        .foregroundColor(greenUi)
                                        .background(jobsDarkBlue)
                                        .cornerRadius(5)
                                    Text(globalVM.eventDetailsByEventID[0].dateAdded)
                                        .font(.system(size: UIScreen.screenHeight/110))
                                        .fontWeight(.thin)
                                }
                                .padding(.vertical, 5)
                            }
                            .padding(.horizontal, UIScreen.screenWidth/50)
                        }
                        .background(.white)
                        .frame(width: UIScreen.screenHeight/4, height: UIScreen.screenHeight/2.5)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    }
                    Spacer()
                }
                CommentAudienceBottomSheet(loginData: loginData, createPostVM: createPostVM, audienceName: $canCommentAudienceName)
                CanSeeAudienceBottomSheet(loginData: loginData, createPostVM: createPostVM, audienceName: $canSeeAudienceName, commentAudienceName: $canCommentAudienceName)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            eventService.getEventInfoByEventID(globalVM: globalVM, loginData: loginData, eventID: createPostVM.selectedEventID)
        }
    }
}

//struct UpdateEventPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateEventPostView()
//    }
//}
