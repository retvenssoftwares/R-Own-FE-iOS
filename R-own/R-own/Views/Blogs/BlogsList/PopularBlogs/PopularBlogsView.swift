//
//  PopularBlogsView.swift
//  R-own
//
//  Created by Aman Sharma on 26/05/23.
//

import SwiftUI

struct PopularBlogsView: View {
    
    @StateObject var blogsVM: BlogsViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var selectedCategory: String = ""
    @State var navigationTitleName: String
    @FocusState private var isKeyboardShowing: Bool
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    
    var filteredBlogs: [BlogListModel] {
        blogsVM.blogsSearchText.isEmpty ? globalVM.blogList : globalVM.blogList.filter { $0.blogTitle.localizedCaseInsensitiveContains(blogsVM.blogsSearchText) }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: navigationTitleName)
                ScrollView{
                    VStack{
                        //Search Field
                        TextField("Search", text: $blogsVM.blogsSearchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.default)
                            .padding()
                            .frame(width: UIScreen.screenWidth/1.2)
                            .cornerRadius(5)
                            .overlay{
                                Image("ExploreSearchIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                    .offset(x: UIScreen.screenWidth/2.9)
                            }
                            .focused($isKeyboardShowing)
                            
                        
                        
                        VStack{
                            LazyVGrid(columns: columns, spacing: 20) {
                                
                                if filteredBlogs.count > 0{
                                    ForEach(0..<filteredBlogs.count, id: \.self) { count in
                                        AllBlogsCardView(blogs: filteredBlogs[count], loginData: loginData, globalVM: globalVM)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
    }
}

//struct PopularBlogsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PopularBlogsView()
//    }
//}
