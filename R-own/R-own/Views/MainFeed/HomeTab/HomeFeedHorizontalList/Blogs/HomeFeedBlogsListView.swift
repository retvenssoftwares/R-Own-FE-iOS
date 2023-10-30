//
//  HomeFeedBlogsListView.swift
//  R-own
//
//  Created by Aman Sharma on 12/07/23.
//

import SwiftUI

struct HomeFeedBlogsListView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @State var blogs: [NewFeedBlog]
    @StateObject var blogsVM: BlogsViewModel
    @State var navigateToViewAll: Bool = false
    
    var body: some View {
        NavigationStack{
            if blogs.count > 0 {
                VStack{
                    HStack{
                        Text("Popular blogs you must read.")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        NavigationLink(destination: {
                            AllBlogsView(blogsVM: blogsVM, globalVM: globalVM, loginData: loginData)
                        }, label: {HStack(spacing: 4){
                            Text("View All")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(greenUi)
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                .foregroundColor(greenUi)
                        }
                        })
                    }
                    .padding(.horizontal, UIScreen.screenWidth/30)
                    .padding(.vertical, UIScreen.screenHeight/60)
                    
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack(spacing: 10){
                            if blogs.count > 0 {
                                ForEach(0..<blogs.count, id: \.self) { id in
                                    HomeFeedBlogsCard(blogs: blogs[id], loginData: loginData, globalVM: globalVM)
                                }
                            }else {
                                Text("No Blogs to show")
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                    .font(.body)
                            }
                        }
                        .padding(.vertical, UIScreen.screenHeight/60)
                        .padding(.trailing, 10)
                        .padding(.leading, UIScreen.screenWidth/30)
                    })
                    //                ScrollView(.horizontal, showsIndicators: true, content: {
                    //                    HStack(spacing: 4){
                    //                        if globalVM.exploreBlogList.count == 1 {
                    //                            ForEach(0..<globalVM.exploreBlogList[0].blogs.count, id: \.self) { id in
                    //                                if globalVM.exploreBlogList[0].blogs[id].displayStatus == "1" {
                    //                                    ExploreBlogsTabView(blogs: globalVM.exploreBlogList[0].blogs[id], loginData: loginData, globalVM: globalVM)
                    //                                }
                    //                            }
                    //                        }else {
                    //                            Text("No Blogs to show")
                    //                        }
                    //                    }
                    //                    .padding(.vertical, UIScreen.screenHeight/60)
                    //                    .padding(.trailing, 10)
                    //                })
                }
                .padding(.vertical, UIScreen.screenHeight/60)
            }
        }
    }
}

//struct HomeFeedBlogsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeFeedBlogsListView()
//    }
//}
