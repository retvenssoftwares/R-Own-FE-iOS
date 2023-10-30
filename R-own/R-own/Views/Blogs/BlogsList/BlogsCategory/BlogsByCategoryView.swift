//
//  BlogsByCategoryView.swift
//  R-own
//
//  Created by Aman Sharma on 24/07/23.
//

import SwiftUI

struct BlogsByCategoryView: View {
    
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
    
    @StateObject var blogService = BlogsService()
    
    var filteredBlogs: [BlogListModel] {
        blogsVM.blogsSearchText.isEmpty ? globalVM.blogsListByCategory : globalVM.blogsListByCategory.filter { $0.blogTitle.localizedCaseInsensitiveContains(blogsVM.blogsSearchText) }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: navigationTitleName)
                
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
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                                }
                            }
                        }
                        
                        
                    ScrollView{
                        VStack{
                            LazyVGrid(columns: columns, spacing: 20) {
                                
                                if filteredBlogs.count > 0{
                                    ForEach(0..<filteredBlogs.count, id: \.self) { count in
                                        BlogsCardTab(blogs: filteredBlogs[count], loginData: loginData, globalVM: globalVM)
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
        .onAppear{
            globalVM.blogsListByCategory = [BlogListModel]()
            blogService.getBlogsByCategory(globalVM: globalVM, loginData: loginData, userID: loginData.mainUserID, categoryID: selectedCategory)
        }
        .navigationBarBackButtonHidden()
    }
}

//struct BlogsByCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        BlogsByCategoryView()
//    }
//}
