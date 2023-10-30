//
//  SavedBlogsListView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct SavedBlogsListView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var saveService = SaveElemetsIDService()
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var counter: Int = 1
    
    
    var body: some View {
        ScrollView {
            if globalVM.getSaveBlogList[0].blogs.count > 0 {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<globalVM.getSaveBlogList[0].blogs.count, id: \.self) { count in
                        SavedBlogCardView(blogs: globalVM.getSaveBlogList[0].blogs[count], loginData: loginData, globalVM: globalVM)
                            .padding()
                            .onAppear{
                                if count == globalVM.exploreEventList[0].events.count - 2 {
                                    counter = counter + 1
                                    saveService.getSaveBlog(globalVM: globalVM, userID: loginData.mainUserID, pageNo: counter)
                                }
                            }
                    }
                }
                .padding(.horizontal, UIScreen.screenWidth/30)
            } else {
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Image("NothingToSeeHereIllustration")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .onAppear{
            globalVM.getSaveBlogList = [GetSaveBlogModel(page: 0, pageSize: 0, blogs: [BlogSave]())]
            saveService.getSaveBlog(globalVM: globalVM, userID: loginData.mainUserID, pageNo: 1)
        }
    }
}
//struct SavedBlogsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedBlogsListView()
//    }
//}
