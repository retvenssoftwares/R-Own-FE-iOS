//
//  BlogsCategoryView.swift
//  R-own
//
//  Created by Aman Sharma on 26/05/23.
//

import SwiftUI

struct BlogsCategoryView: View {
    
    @StateObject var blogsVM: BlogsViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var navigateToCategoryBlogsView: Bool = false
    
    @StateObject var blogService = BlogsService()
    
    var filteredCategories: [BlogsCategoryModel] {
        blogsVM.blogsSearchText.isEmpty ? globalVM.blogsCategory : globalVM.blogsCategory.filter { $0.categoryName.localizedCaseInsensitiveContains(blogsVM.blogsSearchText) }
    }
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Blogs Category")
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
                            if globalVM.blogsCategory.count > 0{
                                ForEach(0..<filteredCategories.count, id: \.self){ count in
                                    if filteredCategories[count].blogCount != 0 {
                                        NavigationLink(destination: {
                                            BlogsByCategoryView(blogsVM: blogsVM, selectedCategory: filteredCategories[count].categoryID, navigationTitleName: filteredCategories[count].categoryName, globalVM: globalVM, loginData: loginData)
                                        }, label: {
                                            BlogCategoryCard(blogCategory: filteredCategories[count])
                                        })
                                    }
                                }
                            }
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

//struct BlogsCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        BlogsCategoryView()
//    }
//}
