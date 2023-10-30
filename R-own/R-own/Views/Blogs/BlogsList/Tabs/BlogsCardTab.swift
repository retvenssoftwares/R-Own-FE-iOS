//
//  BlogsCardTab.swift
//  R-own
//
//  Created by Aman Sharma on 24/07/23.
//

import SwiftUI
import Shimmer

struct BlogsCardTab: View {
    
    @State var blogs: BlogListModel
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var savedStatus: Bool = false
    
    @State var navigateToBlogsDetailView: Bool = false
    
    @StateObject var blogService = BlogsService()
    @StateObject var saveService = SaveElemetsIDService()
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack {
            
            NavigationLink(destination: {
                BlogsDetailView(loginData: loginData, globalVM: globalVM, blogID: blogs.blogID, saved: $blogs.saved)
            }, label: {
                
                VStack{
                    ZStack{
                        AsyncImage(url: currentUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/5)
                                .clipped()
                                .overlay{
                                    VStack{
                                        HStack{
                                            if blogs.categoryName ?? "" != "" {
                                                Text(blogs.categoryName ?? "" )
                                                    .font(.footnote)
                                                    .fontWeight(.thin)
                                                    .foregroundColor(.black)
                                                    .padding(.horizontal, 5)
                                                    .padding(.vertical, 5)
                                                    .background(.white)
                                                    .cornerRadius(5)
                                            }
                                            Spacer()
                                            Button(action: {
                                                blogService.likeBlogs(loginData: loginData, blogID: blogs.blogID)
                                                if blogs.like == "liked" {
                                                    blogs.like = "not liked"
                                                } else {
                                                    blogs.like = "liked"
                                                }
                                            }, label: {
                                                Image(blogs.like == "liked" ? "HeartIcon" : "UnheartIcon")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                            })
                                        }
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                        Spacer()
                                    }
                                    .padding(.top, UIScreen.screenHeight/30)
                                }
                        } placeholder: {
                            //put your placeholder here
                            Rectangle()
                                .fill(lightGreyUi)
                                .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenHeight/5)
                                .shimmering(active: true)
                        }
                        .onAppear {
                            if currentUrl == nil {
                                DispatchQueue.main.async {
                                    currentUrl = URL(string: blogs.blogImage.replacingOccurrences(of: " ", with: "%20"))
                                }
                            }
                        }
                    }
                    Spacer()
                    VStack{
                        HStack{
                            Text(blogs.blogTitle )
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        HStack{
                            ProfilePictureView(profilePic: blogs.profilePic , verified: false, height: UIScreen.screenHeight/50, width: UIScreen.screenHeight/50)
                            Text(blogs.userName)
                                .font(.footnote)
                                .fontWeight(.thin)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            Text("Read More")
                                .font(.footnote)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 5)
                                .background(greyUi)
                                .cornerRadius(5)
                        }
                        Divider()
                            .padding(.horizontal, UIScreen.screenWidth/40)
                        HStack{
                            Spacer()
                            Text(relativeTime(from:blogs.dateAdded) ?? "")
                                .font(.footnote)
                                .foregroundColor(.black)
                                .fontWeight(.light)
                                .padding(.bottom, UIScreen.screenHeight/80)
                        }
                    }
                    .padding()
                }
                .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/3)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 2)
            })
        }
    }
}

//struct BlogsCardTab_Previews: PreviewProvider {
//    static var previews: some View {
//        BlogsCardTab()
//    }
//}
