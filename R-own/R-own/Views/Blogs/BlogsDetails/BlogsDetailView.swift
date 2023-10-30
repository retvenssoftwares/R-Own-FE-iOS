//
//  BlogsDetailView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct BlogsDetailView: View {
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var blogID: String
    @Binding var saved: String
    
    @StateObject var blogsService = BlogsService()
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack{
            if isLoading {
                if globalVM.blogByBlogID.count > 0{
                    ScrollView{
                        BlogsDetailFirstHalfView(globalVM: globalVM)
                        BlogsDetailSecondHalfView(globalVM: globalVM)
                    }
                    Spacer()
                    BlogsDetailThirdHalfView(globalVM: globalVM, loginData: loginData, saved: $saved)
                }
            } else {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
        .onAppear{
            Task {
                isLoading = false
                globalVM.blogByBlogID = [BlogByBlogIDModel]()
                let res = await blogsService.getBlogsByBlogID(globalVM: globalVM, loginData: loginData, blogID: blogID)
                if res == "Success" {
                    isLoading = true
                } else {
                    let res = await blogsService.getBlogsByBlogID(globalVM: globalVM, loginData: loginData, blogID: blogID)
                    if res == "Success" {
                        isLoading = true
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.all)
    }
}

//struct BlogsDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BlogsDetailView()
//    }
//}
