//
//  HomeView.swift
//  R-own
//
//  Created by Aman Sharma on 11/04/23.
//

import SwiftUI
import mesibo

struct HomeView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Feed Var
    @StateObject var feedData: MainFeedViewModel
    
    //userModelVar
    @StateObject var mainUserData = MainUserService()
    
    //mesiboUserModelVar
    @StateObject var mesiboUserData = MesiboUserService()
    
    //Mesibo Var
    @StateObject var mesiboData: MesiboViewModel
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    
    
    //Notification Var
    @StateObject var notificationVM: NotificationViewModel
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @StateObject var userProfileCreation = UserCreationService()
    @StateObject var mainFeedService = MainFeedService()
    @StateObject var communityService = CommunityService()
    @StateObject var exploreService = ExploreService()
    
    @State var horizontalLists: [any View] = []
    @State var horizontalListIndex: Int = 0
    
    @State var countListAppended = 0
    @State var representingCount = 0
    
    @StateObject var newFeedService = NewFeedServices()
    
    @Binding var isLoading: Bool 
    
    let columns = [
        GridItem(.flexible())
    ]
    
    @StateObject var blogsVM: BlogsViewModel
    
    @State var showBlog: Bool = false
    @State var showCommunity: Bool = false
    @State var showHotel: Bool = false
    @State var showService: Bool = false
    
    var body: some View {
            VStack{
                HomeNavigationBar(loginData: loginData, mesiboData: mesiboData, feedData: feedData, notificationVM: notificationVM, globalVM: globalVM, profileVM: profileVM, communityVM: communityVM)
                ScrollView {
                    VStack{
                        CreatePostSubTabView(loginData: loginData, createPostVM: createPostVM, globalVM: globalVM, profileVM: profileVM)
                        CommunityView(communityVM: communityVM, mesiboVM: mesiboData, loginData: loginData, globalVM: globalVM,profileVM: profileVM)
                            .background(.white)
                        if globalVM.newFeedList.count > 0 {
                            if globalVM.newFeedList[0].posts.count > 0 {
                                LazyVGrid(columns: columns, spacing: 5) {
                                    ForEach(0..<globalVM.newFeedList[0].posts.count, id: \.self){ count in
                                        if globalVM.newFeedList[0].posts[count].displayStatus == "1" {
                                            VStack{
                                                FeedCardView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, posts: globalVM.newFeedList[0].posts[count], mesiboVM: mesiboData)
                                                    .onAppear{
                                                        if count == (globalVM.newFeedList[0].posts.count - 2) && (globalVM.newFeedList[0].posts.count > 7) {
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
                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                                        Task {
                                                                            let res = await newFeedService.getNewFeed(globalVM: globalVM, userID: loginData.mainUserID)
                                                                            if res == "Success"{
                                                                                loginData.isLoadingNewFeed = true
                                                                                loginData.isServerError = false
                                                                            } else if res == "Server Error" {
                                                                                loginData.isServerError = true
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
                                                if count % 10 == 0 {
                                                    
                                                    VStack{
                                                        if globalVM.newFeedList[0].blogs.count > globalVM.newFeedblog {
                                                            if globalVM.newFeedList[0].blogs.count > 0 {
                                                                HomeFeedBlogsListView(globalVM: globalVM, loginData: loginData, blogs:  globalVM.newFeedList[0].blogs, blogsVM: blogsVM)
                                                                    .background(.white)
                                                            }
                                                        }
                                                        
                                                        if globalVM.newFeedList[0].communities.count > globalVM.newFeedcommunities {
                                                            if globalVM.newFeedList[0].communities.count > 0 {
                                                                OpenCommunityList(globalVM: globalVM, loginData: loginData, communityVM: communityVM, mesiboVM: mesiboData, profileVM: profileVM, communities: globalVM.newFeedList[0].communities)
                                                                    .background(.white)
                                                            }
                                                        }
                                                        
                                                        if globalVM.newFeedList[0].hotels.count > globalVM.newFeedhotel {
                                                            if globalVM.newFeedList[0].hotels.count > 0 {
                                                                HomeFeedHotelListView(globalVM: globalVM, loginData: loginData, hotels: globalVM.newFeedList[0].hotels)
                                                                    .background(.white)
                                                            }
                                                        }
                                                        
                                                        if globalVM.newFeedList[0].services.count > globalVM.newFeedservices {
                                                            if globalVM.newFeedList[0].services.count > 0 {
                                                                HomeFeedServiceList(globalVM: globalVM, loginData: loginData, mesiboVM: mesiboData, profileVM: profileVM, services: globalVM.newFeedList[0].services)
                                                                    .background(.white)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    if loginData.isLoadingNewFeed {
                                        VStack{
                                            ProgressView()
                                                .onAppear{
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
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                                Task {
                                                                    let res = await newFeedService.getNewFeed(globalVM: globalVM, userID: loginData.mainUserID)
                                                                    if res == "Success"{
                                                                        loginData.isLoadingNewFeed = true
                                                                        loginData.isServerError = false
                                                                    } else if res == "Server Error" {
                                                                        loginData.isServerError = true
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
                                        .padding()
                                    }
                                }
                            }
                        } else {
                            Text("Looks like you need to make some connections")
                                .font(.body)
                        }
                    }
                Spacer()
            }
                .background(screenBGGreyColor)
                .border(width: 1, edges: [.top], color: .black)
        }
            .onAppear{
//                loginData.isLoadingNewFeed = false
//                globalVM.newFeedList = [NewFeedModel(posts: [NewFeedPost](), blogs: [NewFeedBlog](), hotels: [NewFeedHotel](), communities: [NewFeedCommunity](), services: [NewFeedService]())]
//                Task{
//                    let res = await newFeedService.getNewFeed(globalVM: globalVM, userID: loginData.mainUserID)
//                    if res == "Success"{
//                        loginData.isLoadingNewFeed = true
//                    } else if res == "Try again" {
//                        loginData.isLoadingNewFeed = false
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            Task {
//                                let res = await newFeedService.getNewFeed(globalVM: globalVM, userID: loginData.mainUserID)
//                                if res == "Success"{
//                                    loginData.isLoadingNewFeed = true
//                                } else {
//                                    loginData.isLoadingNewFeed = true
//                                }
//                            }
//                        }
//                    } else {
//                        print("Try again")
//                    }
//                }
            }
            .refreshable {
                isLoading = false
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
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            Task {
                                let res = await newFeedService.getNewFeed(globalVM: globalVM, userID: loginData.mainUserID)
                                if res == "Success"{
                                    loginData.isLoadingNewFeed = true
                                    loginData.isServerError = false
                                } else if res == "Server Error" {
                                    loginData.isServerError = true
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
//                globalVM.feedList = [FeedModel(posts: [Post535]())]
//                mainFeedService.getFeed(globalVM: globalVM, userID: loginData.mainUserID)
                mesiboData.chatListMessageList = [MessageListModel]()
                mesiboData.messageType = "ChatTabList"
                mesiboData.mesiboMessageListInit(loginData: loginData)
                globalVM.ownCommunityModelList = [OwnCommunityGroupDetailsModel]()
                communityService.getOwnedCommunities(globalVM: globalVM, userID: loginData.mainUserID)
            }
    }
    func getValueForNumber(_ number: Int) -> Int {
        if number % 10 == 0 && number != 0 {
            return (number / 10) % 4 + 1
        } else {
            return 6
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
