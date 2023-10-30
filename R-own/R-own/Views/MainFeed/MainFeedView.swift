//
//  MainFeedView.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//

import SwiftUI
import Shimmer

struct MainFeedView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //MainFeed Var
    @StateObject var feedData = MainFeedViewModel()
    
    //Mesibo Var
    @StateObject var mesiboData = MesiboViewModel()
    
    //Explore var
    @StateObject var exploreVM = ExploreViewModel()
    
    //Jobs var
    @StateObject var jobsVM = JobsViewModel()
    
    //Jobs var
    @StateObject var createPostVM = CreatePostViewModel()
    
    //Community Var
    @StateObject var communityVM = CommunityViewModel()
    
    //Notification Var
    @StateObject var notificationVM = NotificationViewModel()
    
    //Notification Var
    @StateObject var eventVM = EventViewModel()
    
    //Notification Var
    @StateObject var profileVM: ProfileViewModel
    
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var blogsVM = BlogsViewModel()
    
    @StateObject var userCreationService = UserCreationService()
    @StateObject var profileService = ProfileService()
    @StateObject var feedService = MainFeedService()
    @StateObject var communityService = CommunityService()
    
    
    @State var isDataLoading: Bool = false
    @State var navigateToChatPage: Bool = false
    @State var hideSideBarFakeLogic: Bool = false
    
    //Tabs var
    var tabs = ["Home", "Jobs", "Explore", "Events", "Profile"]
    func testFunc(){
        print("it works")
    }
    
//    init(){
//        self.testFunc()
//    }
    @State var sidebarWidth = UIScreen.screenWidth - UIScreen.screenWidth/7
    
    
    @Binding var isLoading: Bool
    @StateObject var newFeedService = NewFeedServices()
    @State var countryCode: String = ""
    @State var stateCode: String = ""
    
    
    @State private var currentUrl1: URL?
    @State private var currentUrl2: URL?
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                    VStack{
                        if loginData.selectedMainFeedTab == "Home" {
                            HomeView(loginData: loginData, feedData: feedData, mesiboData: mesiboData, communityVM: communityVM, createPostVM: createPostVM, notificationVM: notificationVM, globalVM: globalVM, profileVM: profileVM, isLoading: $isLoading, blogsVM: blogsVM)
                                .ignoresSafeArea(.all, edges: .all)
                        }
                        
                        if loginData.selectedMainFeedTab == "Jobs" {
                            JobsView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, createPostVM: createPostVM, profileVM: profileVM, mesiboVM: mesiboData)
                                .ignoresSafeArea(.all, edges: .all)
                        }
                        
                        
                        if loginData.selectedMainFeedTab == "Explore" {
                            ExploreView(loginData: loginData, exploreVM: exploreVM, jobsVM: jobsVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboData, communityVM: communityVM)
                                .ignoresSafeArea(.all, edges: .all)
                        }
                        
                        if loginData.selectedMainFeedTab == "Events" {
                            EventView(loginData: loginData, eventVM: eventVM, globalVM: globalVM)
                                .ignoresSafeArea(.all, edges: .all)
                        }
                        
                        
                        if loginData.selectedMainFeedTab == "Profile" {
                            ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboData, role: loginData.mainUserRole, mainUser: true, userID: loginData.mainUserID)
                                .ignoresSafeArea(.all, edges: .all)
                        }
                    }
                
                //Custom Tab Bar
                VStack {
                    HStack(alignment: .firstTextBaseline, spacing: 0){
                        
                        if loginData.selectedMainFeedTab == "Home"{
                            Button(action: {
                                loginData.selectedMainFeedTab = "Home"
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
                                mesiboData.messageList = [MessageListModel]()
                                mesiboData.mesiboMessageListInit(loginData: loginData)
                                globalVM.ownCommunityModelList = [OwnCommunityGroupDetailsModel]()
                                communityService.getOwnedCommunities(globalVM: globalVM, userID: loginData.mainUserID)
                            }, label: {
                                VStack{
                                    Spacer()
//                                    ExDivider(color: greenUi, width: UIScreen.screenWidth/14, thickness: 5)
                                    VStack(spacing:0){
                                        Image("BottomNavHome-g")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                        Text("Home")
                                            .foregroundColor(.black)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                    }
                                    Spacer()
                                }
                            })
                        } else {
                            Button(action: {
                                loginData.selectedMainFeedTab = "Home"
                            }, label: {
                                VStack{
                                    Spacer()
//                                    ExDivider(color: greenUi, width: UIScreen.screenWidth/14, thickness: 5)
                                    VStack(spacing:0){
                                        Image("BottomNavHome-w")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                        Text("Home")
                                            .foregroundColor(.black)
                                            .font(.subheadline)
                                            .fontWeight(.thin)
                                    }
                                    Spacer()
                                }
                            })
                        }
                        
                        Spacer()
                        
                        if loginData.isHiddenKPI {
                            if loginData.selectedMainFeedTab == "Jobs"{
                                
                                Button(action: {
                                    loginData.selectedMainFeedTab = "Jobs"
                                }, label: {
                                    VStack{
                                        Spacer()
                                        VStack(spacing:0){
                                            Image("BottomNavJobs-g")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                            Text("Jobs")
                                                .foregroundColor(.black)
                                                .font(.subheadline)
                                                .fontWeight(.medium)
                                        }
                                        Spacer()
                                    }
                                })
                            } else {
                                Button(action: {
                                    loginData.selectedMainFeedTab = "Jobs"
                                }, label: {
                                    VStack{
                                        Spacer()
                                        VStack(spacing:0){
                                            Image("BottomNavJobs-w")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                            Text("Jobs")
                                                .foregroundColor(.black)
                                                .font(.subheadline)
                                                .fontWeight(.thin)
                                        }
                                        Spacer()
                                    }
                                })
                            }
                            Spacer()
                        }
                        if loginData.selectedMainFeedTab == "Explore"{
                            
                            Button(action: {
                                exploreVM.exploreCategorySelected = "Posts"
                                loginData.selectedMainFeedTab = "Explore"
                            }, label: {
                                VStack{
                                    Spacer()
                                    VStack(spacing:0){
                                        Image("BottomNavExplore-g")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                        Text("Explore")
                                            .foregroundColor(.black)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                    }
                                    Spacer()
                                }
                            })
                        } else {
                            Button(action: {
                                exploreVM.exploreCategorySelected = "Posts"
                                loginData.selectedMainFeedTab = "Explore"
                            }, label: {
                                VStack{
                                    Spacer()
                                    VStack(spacing:0){
                                        Image("BottomNavExplore-w")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                        Text("Explore")
                                            .foregroundColor(.black)
                                            .font(.subheadline)
                                            .fontWeight(.thin)
                                    }
                                    Spacer()
                                }
                            })
                        }
                        Spacer()
                        if loginData.isHiddenKPI {
                            if loginData.selectedMainFeedTab == "Events"{
                                
                                Button(action: {
                                    withAnimation(.spring()){
                                        loginData.selectedMainFeedTab = "Events"
                                    }
                                }, label: {
                                    VStack{
                                        Spacer()
                                        VStack(spacing:0){
                                            Image("BottomNavEvents-g")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                            Text("Events")
                                                .foregroundColor(.black)
                                                .font(.subheadline)
                                                .fontWeight(.medium)
                                        }
                                        Spacer()
                                    }
                                })
                            } else {
                                Button(action: {
                                    loginData.selectedMainFeedTab = "Events"
                                }, label: {
                                    VStack{
                                        Spacer()
                                        VStack(spacing:0){
                                            Image("BottomNavEvents-g")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                            Text("Events")
                                                .foregroundColor(.black)
                                                .font(.subheadline)
                                                .fontWeight(.thin)
                                        }
                                        Spacer()
                                    }
                                })
                            }
                            Spacer()
                        }
                        if loginData.selectedMainFeedTab == "Profile"{
                            
                            Button(action: {
                                loginData.selectedMainFeedTab = "Profile"
                            }, label: {
                                VStack{
                                    Spacer()
                                    
                                    VStack(spacing:0){
                                        ProfilePictureView(profilePic: loginData.mainUserProfilePic, verified: false, height: UIScreen.screenHeight/30, width: UIScreen.screenHeight/30)
                                        Text("Profile")
                                            .foregroundColor(.black)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                    }
                                    Spacer()
                                }
                            })
                        } else {
                            Button(action: {
                                loginData.selectedMainFeedTab = "Profile"
                            }, label: {
                                VStack{
                                    Spacer()
                                    VStack(spacing:0){
                                        ProfilePictureView(profilePic: loginData.mainUserProfilePic, verified: false, height: UIScreen.screenHeight/30, width: UIScreen.screenHeight/30)
                                        Text("Profile")
                                            .foregroundColor(.black)
                                            .font(.subheadline)
                                            .fontWeight(.thin)
                                    }
                                    Spacer()
                                }
                            })
                        }
                    }
                    .padding(.bottom, UIScreen.screenHeight/30)
                    .padding(.horizontal, UIScreen.screenWidth/10)
                    .background(Color.white)
                    .border(width: 0.8, edges: [.top], color: Color.black)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/13)
                }
                //Side Bar
                SideMenuView(loginData: loginData, globalVM: globalVM, jobsVM: jobsVM, feedData: feedData, notificationVM: notificationVM, blogsVM: blogsVM, mainFeedTab: $loginData.selectedMainFeedTab, profileVM: profileVM, mesiboVM: mesiboData)
                    .shadow(color: Color.black.opacity( feedData.sidebarX != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                    .offset(x: feedData.sidebarX)
                    .background(Color.black.opacity(feedData.sidebarX == 0 ? 0.5 : 0).ignoresSafeArea(.all, edges: .vertical)
                    .onTapGesture {
                        withAnimation{
                            feedData.sidebarX = -sidebarWidth
                        }
                    })
                
                
                Group{
                    //JobsExploreBottomSheet
                    if loginData.isHiddenKPI{
                        Group{
                            JobFilterBottomSheet(loginData: loginData, jobsVM: jobsVM)
                            JobCategoryFilterBottomSheet(loginData: loginData, jobsVM: jobsVM)
                            JobTypeFilterBottomSheet(loginData: loginData, jobsVM: jobsVM)
                            JobLocationFilterBottomSheet(loginData: loginData, jobsVM: jobsVM)
                        }
                        
                        //Request A Job
                        Group{
//                            RequestLocationBottomSheet(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM)
                            //                        CountryBottomSheetView(loginData: loginData, country: jobsVM.requestedCountryField, countryCode: $countryCode)
                            //                        StateBottomSheetView(loginData: loginData, state: jobsVM.requestedStateField, stateCode: $stateCode, countryCode: countryCode)
                            //                        CityBottomSheetView(loginData: loginData, city: jobsVM.requestedCityField, countryCode: countryCode, stateCode: stateCode)
                            RequestDepartmentBottomSheet(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM)
                            RequestDesignationBottomSheet(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM)
                            RequestEmploymentTypeBottomSheet(loginData: loginData, jobsVM: jobsVM)
                            RequestNoticePeriodBottomSheet(loginData: loginData, jobsVM: jobsVM)
                            RequestedCTCBottomSheet(loginData: loginData, jobsVM: jobsVM)
                        }
                    }
                    //profile
                    Group{
                        VendorProfileEditBottomSheet(loginData: loginData, profileVM: profileVM, jobsVM: jobsVM, globalVM: globalVM, mesiboVM: mesiboData)
                        NormalProfileEditBottomSheet(loginData: loginData, profileVM: profileVM, jobsVM: jobsVM, globalVM: globalVM, mesiboVM: mesiboData)
                        HotelOwnerProfileEditBottomSheet(loginData: loginData, profileVM: profileVM, jobsVM: jobsVM, globalVM: globalVM, mesiboVM: mesiboData)
                    }
                    //event
                    if loginData.isHiddenKPI{
                        Group{
                            EventLocationBottomSheet(loginData: loginData, eventVM: eventVM, country: $eventVM.eventLocationCountry, state: $eventVM.eventLocationState, city: $eventVM.eventLocationCity)
                            EventAddBottomSheetView(globalVM: globalVM, loginData: loginData, eventVM: eventVM)
                        }
                    }
                    //hometab
                    Group{
                        if loginData.mainUserConnectionCount == 0 {
                            NewUserConnectionBottomSheetView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboData)
                        }
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation {
                            if loginData.selectedMainFeedTab == "Home" {
                                if !hideSideBarFakeLogic{
                                    let translationX = value.translation.width
                                    if translationX > 0 {
                                        feedData.sidebarX = min(0, -sidebarWidth + translationX)
                                    } else {
                                        if feedData.sidebarX != 0 {
                                            print("svnfr")
                                            navigateToChatPage = true
                                        } else {
                                            feedData.sidebarX = min(0, -sidebarWidth + translationX)
                                        }
                                        hideSideBarFakeLogic = true
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            hideSideBarFakeLogic = false
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            if loginData.selectedMainFeedTab == "Home"{
                                if !hideSideBarFakeLogic{
                                    if value.translation.width > 0 {
                                        if -feedData.sidebarX < sidebarWidth / 2 {
                                            feedData.sidebarX = 0
                                        } else {
                                            feedData.sidebarX = -sidebarWidth
                                        }
                                    } else {
                                        if feedData.sidebarX != 0 {
                                            print("vrev")
                                            navigateToChatPage = true
                                        } else {
                                            if -feedData.sidebarX < sidebarWidth / 2 {
                                                feedData.sidebarX = 0
                                            } else {
                                                feedData.sidebarX = -sidebarWidth
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                hideSideBarFakeLogic = false
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
            )
            .navigationDestination(isPresented: $navigateToChatPage, destination: {
                ChatView(loginData: loginData, mesiboData: mesiboData, globalVM: globalVM, profileVM: profileVM, communityVM: communityVM)
            })
            .onAppear {
//                if loginData.mesiboInitializeOnce{
                print("mesibo token ====> \(loginData.mainUserMesiboToken)")
                print("mesibo address mob number => \(loginData.mainUserPhoneNumber)")
                print("mesibo remote username => \(loginData.mainUserFullName)")
                    mesiboData.mesiboInitalize(loginData.mainUserMesiboToken, address: loginData.mainUserPhoneNumber, remoteUserName: loginData.mainUserFullName)
                
//                }
                Task{
                    let res = await userCreationService.getUserDetails(loginData: loginData)
                    if res == "Success" {
                        globalVM.ownCommunityModelList = [OwnCommunityGroupDetailsModel]()
                        communityService.getOwnedCommunities(globalVM: globalVM, userID: loginData.mainUserID)
                        mesiboData.startUpdatingMCall(loginData: loginData)
                        isDataLoading = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.spring()){
                                if loginData.showNewUserConnectionBottomSheetShownOnce == false {
                                    if loginData.mainUserConnectionCount == 0 {
                                        loginData.showNewUserConnectionBottomSheet = true
                                        loginData.showNewUserConnectionBottomSheetShownOnce = true
                                    }
                                }
                            }
                        }
                    }
                }
//                globalVM.openCommunityModelList = [OwnCommunityGroupDetailsModel]()
//                communityService.getCommunitiesNotJoined(globalVM: globalVM, userID: loginData.mainUserID)
//                globalVM.feedList = [FeedModel(posts: [Post535]())]
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ExDivider: View {
    let color: Color
    let width: CGFloat
    let thickness: CGFloat
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width, height: thickness)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

//struct MainFeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainFeedView()
//    }
//}
