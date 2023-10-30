//
//  HomeFeedBlogsCard.swift
//  R-own
//
//  Created by Aman Sharma on 28/07/23.
//

import SwiftUI
import Shimmer

struct HomeFeedBlogsCard: View {
    
    @State var blogs: NewFeedBlog
    
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
                                .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/5)
                                .clipped()
                                .overlay{
                                    VStack{
                                        HStack{
                                            Text(blogs.categoryName)
                                                .font(.footnote)
                                                .fontWeight(.thin)
                                                .foregroundColor(.black)
                                                .background(.white)
                                                .cornerRadius(5)
                                            Spacer()
                                            Button(action: {
                                                //                                        blogService.likeBlogs(loginData: loginData, blogID: blogs.blogID)
                                                if blogs.saved == "not saved" {
                                                    saveService.saveBlogID(loginData: loginData, blogID: blogs.blogID)
                                                    blogs.saved = "saved"
                                                } else {
                                                    saveService.unsaveBlogID(loginData: loginData, blogID: blogs.blogID)
                                                    blogs.saved = "not saved"
                                                }
                                            }, label: {
                                                Image(blogs.saved == "not saved" ? "UnheartIcon" : "HeartIcon")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: UIScreen.screenHeight/30)
                                            })
                                        }
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                        .padding(.top, UIScreen.screenHeight/70)
                                        Spacer()
                                    }
                                }
                                .onTapGesture {
                                    navigateToBlogsDetailView.toggle()
                                }
                        } placeholder: {
                            //put your placeholder here
                            Rectangle()
                                .fill(lightGreyUi)
                                .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/5)
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
                    VStack{
                        HStack{
                            Text(blogs.blogTitle )
                                .font(.footnote)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        HStack{
                            ProfilePictureView(profilePic: blogs.profilePic , verified: false, height: UIScreen.screenHeight/45, width: UIScreen.screenHeight/45)
                            if blogs.userName != "" {
                                Text(blogs.userName)
                                    .font(.footnote)
                                    .fontWeight(.thin)
                            }
                            Spacer()
                        }
//                        HStack{
//                            Spacer()
//                            Text("Read More")
//                                .font(.system(size: UIScreen.screenHeight/110))
//                                .fontWeight(.regular)
//                                .foregroundColor(.black)
//                                .padding(.horizontal, 5)
//                                .padding(.vertical, 5)
//                                .background(greyUi)
//                                .cornerRadius(5)
//                        }
//                        Divider()
//                            .padding(.horizontal, UIScreen.screenWidth/40)
//                        HStack{
//    //                        Text("2.2k Reads")
//    //                            .font(.system(size: UIScreen.screenHeight/110))
//    //                            .fontWeight(.bold)
//                            Spacer()
//    //                        Text(formattedDate(from: blogs.))
//    //                            .font(.system(size: UIScreen.screenHeight/110))
//    //                            .fontWeight(.light)
//                        }
                        
                        
                    }
                    .padding()
                }
                .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/3)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.2), radius: 2)
            })
        }
    }
}

//struct HomeFeedBlogsCard_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeFeedBlogsCard()
//    }
//}
