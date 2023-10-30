//
//  CreatePostSubTabView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI
import Shimmer

struct CreatePostSubTabView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var navigateToCreatePostView: Bool = false
    
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            NavigationLink(isActive: $navigateToCreatePostView, destination: {CreatePostView(loginData: loginData, createPostVM: createPostVM, globalVM: globalVM, profileVM: profileVM)}, label: {Text("")})
            VStack{
                HStack{
                    ProfilePictureView(profilePic: loginData.mainUserProfilePic, verified: false, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                        .padding(.leading, UIScreen.screenWidth/20)
                        .padding(.trailing, UIScreen.screenWidth/30)
                    
                    Text("Share with your community...")
                        .font(.body)
                        .fontWeight(.thin)
                    
                    Spacer()
                    
                    Image("FeedgalleryIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/25, height: UIScreen.screenHeight/25)
                        .padding(.leading, UIScreen.screenWidth/30)
                        .padding(.trailing, UIScreen.screenWidth/20)
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/15)
                .background(.white)
                .cornerRadius(5)
                .clipped()
                .padding(.vertical, UIScreen.screenHeight/80)
                .onTapGesture {
                    navigateToCreatePostView.toggle()
                }
            }
        }
    }
}

//struct CreatePostSubTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePostSubTabView()
//    }
//}
