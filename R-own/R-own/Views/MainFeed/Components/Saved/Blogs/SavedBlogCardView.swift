//
//  SavedBlogCardView.swift
//  R-own
//
//  Created by Aman Sharma on 18/06/23.
//

import SwiftUI
import Shimmer

struct SavedBlogCardView: View {
    
    @State var blogs: BlogSave
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var navigateToBlogsDetailView: Bool = false
    @State var savedStatus: String = "saved"
    @StateObject var blogService = BlogsService()
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack {
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
                                        Text(blogs.categoryName)
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                            .foregroundColor(.black)
                                            .padding(.horizontal, 5)
                                            .padding(.vertical, 5)
                                            .background(.white)
                                            .cornerRadius(5)
                                        Spacer()
                                        //                                    Button(action: {
                                        //                                        blogService.likeBlogs(loginData: loginData, blogID: blogs.blogID)
                                        //                                        if blogs.like == "not liked" {
                                        //                                            blogs.like = "liked"
                                        //                                        } else {
                                        //                                            blogs.like = "not liked"
                                        //                                        }
                                        //                                    }, label: {
                                        //                                        Image(blogs. == "not liked" ? "UnheartIcon" : "HeartIcon")
                                        //                                            .resizable()
                                        //                                            .scaledToFit()
                                        //                                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                        //                                            .padding(.trailing, UIScreen.screenWidth/40)
                                        //                                    })
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
                    //                    HStack{
                    //                        Spacer()
                    //                        Button(action: {
                    //                        }, label: {
                    //                            Text("Read More")
                    //                                .font(.system(size: UIScreen.screenHeight/110))
                    //                                .fontWeight(.regular)
                    //                                .foregroundColor(.black)
                    //                                .padding(.horizontal, 5)
                    //                                .padding(.vertical, 5)
                    //                                .background(greyUi)
                    //                                .cornerRadius(5)
                    //                        })
                    //                        .navigationDestination(isPresented: $navigateToBlogsDetailView, destination: {
                    //                        })
                    //                    }
                    Divider()
                        .padding(.horizontal, UIScreen.screenWidth/40)
                    //                    HStack{
                    ////                        Text("2.2k Reads")
                    ////                            .font(.system(size: UIScreen.screenHeight/110))
                    ////                            .fontWeight(.bold)
                    //                        Spacer()
                    //                        Text(blogs.)
                    //                            .font(.footnote)
                    //                            .fontWeight(.light)
                    //                    }
                    
                    
                }
                .padding()
            }
            .frame(width: UIScreen.screenWidth/2.2, height: UIScreen.screenHeight/3)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 2)
            .onTapGesture {
                navigateToBlogsDetailView = true
            }
            .navigationDestination(isPresented: $navigateToBlogsDetailView, destination: {
                BlogsDetailView(loginData: loginData, globalVM: globalVM, blogID: blogs.blogid, saved: $savedStatus)
            })
            
            NavigationLink(isActive: $navigateToBlogsDetailView, destination:
                            { BlogsDetailView(loginData: loginData, globalVM: globalVM, blogID: blogs.blogid, saved: $savedStatus)}, label: {Text("")})
        }
        .onAppear{
            navigateToBlogsDetailView = false
        }
    }
}

//struct SavedBlogCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedBlogCardView()
//    }
//}
