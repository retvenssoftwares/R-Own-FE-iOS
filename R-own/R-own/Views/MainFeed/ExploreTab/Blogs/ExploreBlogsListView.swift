//
//  ExploreBlogsListView.swift
//  R-own
//
//  Created by Aman Sharma on 07/08/23.
//

import SwiftUI
import AlertToast

struct ExploreBlogsListView: View {
    
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var exploreVM: ExploreViewModel
    
    @StateObject var exploreService = ExploreService()
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var counter1: Int = 1
    @State var counter2: Int = 1
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        VStack{
            TextField("Search", text: $exploreVM.exploreBlogsSearchText )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.default)
                .frame(width: UIScreen.screenWidth/1.1)
                .cornerRadius(5)
                .overlay{
                    HStack{
                        Spacer()
                        Image("ExploreSearchIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .padding(.trailing, UIScreen.screenWidth/20)
                    }
                }
                .onChange(of: exploreVM.exploreBlogsSearchText) { newValue in
                    searchPost()
                }
                .focused($isKeyboardShowing)
            ScrollView{
                VStack{
                    if exploreVM.exploreBlogsSearchText == "" {
                        LazyVGrid(columns: columns, spacing: 10) {
                            if globalVM.exploreBlogList.count == 1 {
                                ForEach(0..<globalVM.exploreBlogList[0].blogs.count, id: \.self) { id in
                                    if globalVM.exploreBlogList[0].blogs[id].displayStatus == "1" {
                                        ExploreBlogsTabView(blogs: globalVM.exploreBlogList[0].blogs[id], loginData: loginData, globalVM: globalVM)
                                            .onAppear{
                                                if id == globalVM.exploreBlogList[0].blogs.count - 2 {
                                                    counter1 = counter1 + 1
                                                    exploreService.getExploreBlog(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(counter1))
                                                }
                                            }
                                    }
                                }
                            }else {
                                VStack{
                                    Spacer()
                                    Image("NothingToSeeHereIllustration")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.bottom, UIScreen.screenHeight/9)
                    } else {
                        LazyVGrid(columns: columns, spacing: 10) {
                            if globalVM.exploreSearchBlogList.count == 1 {
                                ForEach(0..<globalVM.exploreSearchBlogList[0].blogs.count, id: \.self) { id in
                                    if globalVM.exploreSearchBlogList[0].blogs[id].displayStatus == "1" {
                                        ExploreBlogSearchTabView(blogs: globalVM.exploreSearchBlogList[0].blogs[id], loginData: loginData, globalVM: globalVM)
                                            .onAppear{
                                                if globalVM.exploreSearchBlogList[0].blogs.count > 10 {
                                                    if id == globalVM.exploreSearchBlogList[0].blogs.count - 2 {
                                                        counter2 = counter2 + 1
                                                        exploreService.getExploreBlogsBySearch(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(counter2), keyword: exploreVM.exploreBlogsSearchText)
                                                    }
                                                }
                                            }
                                    }
                                }
                            }else {
                                VStack{
                                }
                            }
                        }
                        .padding(.bottom, UIScreen.screenHeight/9)
                        .padding(.horizontal)
                    }
                    Rectangle()
                        .fill(.white)
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/12)
                }
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
    }   
    func searchPost() {
        if globalVM.toastSearchLoading == false {
            globalVM.toastSearchLoading.toggle()
        }
        exploreService.getExploreBlogsBySearch(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(1), keyword: exploreVM.exploreBlogsSearchText)
    }
}

//struct ExploreBlogsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreBlogsListView()
//    }
//}
