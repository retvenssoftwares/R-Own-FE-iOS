//
//  AdminInformativePostView.swift
//  R-own
//
//  Created by Aman Sharma on 26/07/23.
//

import SwiftUI

struct AdminInformativePostView: View {
    
    @Binding var post: NewFeedPost
    
    @State var currentIndex: Int = 0
    
    @State var navigateToPostDetailView: Bool = false
    @State var navigateToImageDetailView: Bool = false
    @State var navigateToProfileDetailView: Bool = false
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var showCommentSheet: Bool = false
    @State var navigateToProfileView: Bool = false
    
    @StateObject var saveService = SaveElemetsIDService()
    @StateObject var mainFeedService = MainFeedService()
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        NavigationStack{
            if post.fullName ?? "" != "" {
                VStack{
                    VStack{
                        HStack{
                            //profilepic
                            //profilepic
                            ProfilePictureView(profilePic: post.profilePic ?? "", verified: post.verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                            VStack(alignment: .leading) {
                                //name
                                if post.userName == "" {
                                    Text(post.fullName!)
                                        .foregroundColor(.black)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .frame(alignment: .leading)
                                } else{
                                    Text(post.userName)
                                        .foregroundColor(.black)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .frame(alignment: .leading)
                                }
                            }
                            Spacer()
                            //time
                            Text(relativeTime(from: post.dateAdded) ?? "")
                                .foregroundColor(.black)
                                .font(.footnote)
                                .fontWeight(.thin)
                                .padding(.leading, 30)
                                .frame(alignment: .leading)
                        }
                        .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
                        
                        NewFeedPostImageView(post: $post, currentIndex: $currentIndex, loginData: loginData, globalVM: globalVM)
                            .padding(.top, UIScreen.screenHeight/100)
                            .onTapGesture {
                                print("image click")
                                print(post.media.count)
                            }
                        
                        //caption display
                        VStack{
                            HStack(spacing: 2) {
                                if post.media.count != 1 {
                                    ForEach((0..<post.media.count), id: \.self) { index in
                                        Circle()
                                            .fill(index == currentIndex ? Color.black : Color.black.opacity(0.3))
                                            .frame(width: UIScreen.screenHeight/130, height: UIScreen.screenHeight/130)
                                    }
                                }
                            }
                            HStack{
                                Text(post.userName == "" ? post.fullName! : post.userName)
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .padding(.trailing, 30)
                                    .frame(alignment: .leading)
                                    .onTapGesture {
                                        print("move to profile screen")
                                    }
                                if post.caption != "" {
                                    Text(post.caption )
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .fontWeight(.thin)
                                        .frame(alignment: .leading)
                                }
                                Spacer()
                            }
                            .padding(.top, UIScreen.screenHeight/100)
                            .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
                            Divider()
                                .frame(width: UIScreen.screenWidth/1.3)
                            
                            
                        }
                    }
                }
                .padding(.vertical, UIScreen.screenHeight/40)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                .padding(.horizontal, UIScreen.screenWidth/30)
                .frame(width: UIScreen.screenWidth)
            }
        }
    }
}

//struct AdminInformativePostView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdminInformativePostView()
//    }
//}
