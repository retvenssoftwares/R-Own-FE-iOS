//
//  ExploreBlogsView.swift
//  R-own
//
//  Created by Aman Sharma on 29/04/23.
//

import SwiftUI
import AlertToast

struct ExploreBlogsView: View {
    
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
            ExploreBlogsListView(globalVM: globalVM, loginData: loginData, exploreVM: exploreVM)
        }
        .onAppear{
            exploreVM.exploreBlogsSearchText = ""
            globalVM.exploreSearchBlogList = [ExploreBlogSearchModel(page: 0, pageSize: 0, blogs: [ExploreBlogSearch]())]
            globalVM.exploreBlogList = [ExploreBlogModel(page: 0, pageSize: 0, blogs: [ExploreBlog]())]
            exploreService.getExploreBlog(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: "1")
        }
    }
}

//struct ExploreBlogsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreBlogsView()
//    }
//}
