//
//  AllBlogsView.swift
//  R-own
//
//  Created by Aman Sharma on 26/05/23.
//

import SwiftUI

struct AllBlogsView: View {
    
    @StateObject var blogsVM: BlogsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    
    @State var navigateToPopularBlogsView: Bool = false
    @State var navigateToBlogsCategoryView: Bool = false
    @State var navigateToCategoryBlogsView: Bool = false
    
    @State var selecedCategoryID: String = ""
    @State var selectedCategoryName: String = ""
    
    @StateObject var blogService = BlogsService()
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "All Blogs")
                
            
                ScrollView{
                    VStack(spacing: 10){
                        
                        VStack{
                            HStack{
                                Text("Popular Blogs you must read")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                NavigationLink(destination: {
                                    PopularBlogsView(blogsVM: blogsVM, navigationTitleName: "Popular Blogs", globalVM: globalVM, loginData: loginData)
                                }, label: {
                                    Text("See All")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                })
                            }
                            .padding(.top, UIScreen.screenHeight/40)
                            .padding(.horizontal, UIScreen.screenWidth/40)
                            ScrollView(.horizontal){
                                HStack(spacing: 10){
                                    if globalVM.blogList.count > 0{
                                        ForEach(0..<(globalVM.blogList.count > 6 ? 6 : globalVM.blogList.count), id: \.self){ count in
                                            AllBlogsCardView(blogs: globalVM.blogList[count], loginData: loginData, globalVM: globalVM)
                                        }
                                        .padding(.vertical, UIScreen.screenHeight/60)
                                    }
                                }
                            }
                            .padding(.leading, UIScreen.screenWidth/30)
                        }
                        
                        
                        VStack(spacing: 5){
                            HStack{
                                Text("Category")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                NavigationLink(destination: {
                                    BlogsCategoryView(blogsVM: blogsVM, loginData: loginData, globalVM: globalVM)
                                }, label: {
                                    Text("See All")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                })
                            }
                            .padding(.vertical, UIScreen.screenHeight/50)
                            if globalVM.blogsCategory.count > 0 {
                                ForEach(0..<(globalVM.blogsCategory.count > 7 ? 7 : globalVM.blogsCategory.count ) , id: \.self){ count in
                                    if globalVM.blogsCategory[count].blogCount != 0 {
                                        NavigationLink(destination: {
                                            BlogsByCategoryView(blogsVM: blogsVM, selectedCategory: globalVM.blogsCategory[count].categoryID, navigationTitleName: globalVM.blogsCategory[count].categoryName, globalVM: globalVM, loginData: loginData)
                                        }, label: {
                                            BlogCategoryCard(blogCategory: globalVM.blogsCategory[count])
                                        })
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    }
                }
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            blogService.getBlogsList(globalVM: globalVM, loginData: loginData)
            blogService.getBlogsCategory(globalVM: globalVM, loginData: loginData, userID: loginData.mainUserID)
        }
    }
}

//struct AllBlogsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllBlogsView()
//    }
//}
