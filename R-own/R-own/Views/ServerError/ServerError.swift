//
//  ServerError.swift
//  R-own
//
//  Created by Aman Sharma on 03/08/23.
//

import SwiftUI

struct ServerError: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var newFeedService = NewFeedServices()
    
    
    var body: some View {
        VStack{
            Image("ServerDown")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.screenWidth/1.2)
            ProgressView()
                .foregroundColor(greenUi)
        }
        .onAppear{
            getNewFeedRecursion(globalVM: globalVM, loginData: loginData)
        }
        .onDisappear{
            
        }
    }
    func getNewFeedRecursion(globalVM: GlobalViewModel, loginData: LoginViewModel) {
        globalVM.newFeedList = [NewFeedModel(posts: [NewFeedPost](), blogs: [NewFeedBlog](), hotels: [NewFeedHotel](), communities: [NewFeedCommunity](), services: [NewFeedService]())]
        Task{
            loginData.isLoadingNewFeed = false
            let res = await newFeedService.getNewFeed(globalVM: globalVM, userID: loginData.mainUserID)
            if res == "Success"{
                loginData.isLoadingNewFeed = true
                loginData.isServerError = false
            } else if res == "Server Error" {
                loginData.isServerError = true
            } else if res == "Try again" {
                loginData.isLoadingNewFeed = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    Task {
                        let res = await newFeedService.getNewFeed(globalVM: globalVM, userID: loginData.mainUserID)
                        if res == "Success"{
                            loginData.isLoadingNewFeed = true
                            loginData.isServerError = false
                        } else if res == "Server Error" {
                            loginData.isServerError = true
                            getNewFeedRecursion(globalVM: globalVM, loginData: loginData)
                        } else {
                            loginData.isLoadingNewFeed = true
                            loginData.isServerError = false
                        }
                    }
                }
            } else {
                print("Try again")
            }
        }
    }
}

//struct ServerError_Previews: PreviewProvider {
//    static var previews: some View {
//        ServerError()
//    }
//}
