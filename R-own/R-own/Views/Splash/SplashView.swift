//
//  SplashView.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//

import SwiftUI
import mesibo
import MesiboCall

struct SplashView: View {
    
    
    @StateObject var languageData: LanguageViewModel
    
    //Auth Variable
    @AppStorage("login_status") var loginStatus: Bool = false
    
    //SplashScreen Variable
    @State var isActive: Bool = false
    
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    @StateObject var loginData: LoginViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var profileVM = ProfileViewModel()
    @StateObject var globalVM = GlobalViewModel()
    
    @StateObject var feedService = MainFeedService()
    @StateObject var appUpdateService = AppUpdateService()
    
    @State var isLoading: Bool = false
    @StateObject var newFeedService = NewFeedServices()
    
    var body: some View {
        ZStack{
            VStack{
                if networkMonitor.isConnected {
                    if self.isActive {
                        if loginData.isServerError {
                            ServerError(loginData: loginData, globalVM: globalVM)
                        } else if loginData.isAppUpdate {
                            AppUpdateView(loginData: loginData)
                        } else if loginData.notificationMessageView{
                            MessageView(loginData: loginData, mesiboAddress: loginData.notificationUserAddress, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
                        } else if loginData.notificationPostView{
                            MediaPushNotificationView(globalVM: globalVM, loginData: loginData, mesiboVM: mesiboVM, profileVM: profileVM, isPushNotification: true, postID: "")
                        } else if loginData.notificationNormalPostPostView {
                            StatusPushNotificationView(globalVM: globalVM, loginData: loginData, mesiboVM: mesiboVM, profileVM: profileVM, isPushNotification: true, postID: "")
                        } else if loginData.notificationCheckInPostView {
                            CheckInPostPushNotificationView(globalVM: globalVM, loginData: loginData, mesiboVM: mesiboVM, profileVM: profileVM, isPushNotification: true, postID: "")
                        } else if loginData.notificationProfileView{
                            ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: loginData.notificationUserrole, mainUser: false, userID: loginData.notificationUseruserID)
                        } else if loginData.loginStatusFinal{
                            MainFeedView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, isLoading: $isLoading)
                        } else if loginData.userAlreadyExist {
                            ProfileCreationNumberView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, isLoading: $isLoading)
                        } else if loginData.interestSelected {
                            SyncContactsView(loginData: loginData, globalVM: globalVM)
                        } else if loginData.onboardingCompleted{
                            SelectInterestView(loginData: loginData, globalVM: globalVM)
                        } else if loginData.logStatusviaNumber{
                            ProfileCreationNumberView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, isLoading: $isLoading)
                        } else {
                            LoginView(languageData: languageData, loginData: loginData, globalVM: globalVM)
                        }
                    } else {
                        Image("SplashImg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    }
                } else {
                    NoInternetView()
                }
            }
            if loginData.showProfileMax {
                ProfileFullView(loginData: loginData)
            }
        }
        .onAppear{
            if loginData.notificationMessageView {
                mesiboVM.mesiboInitalize(loginData.mainUserMesiboToken, address: loginData.mainUserPhoneNumber, remoteUserName: loginData.mainUserFullName)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                withAnimation{
//                    loginData.mesiboInitializeOnce = true
                    self.isActive = true
                }
            }
            Task{
                let appRes = await appUpdateService.getAppUpdate(loginData: loginData)
                if appRes == "Success" {
                    if loginData.appUpdate.count != 0 {
                        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject

                        //Then just cast the object as a String, but be careful, you may want to double check for nil
                        let version = nsObject as! String
                        print("==========================================")
                        print(version)
                        if loginData.appUpdate[0].iOSVersion != version {
                            loginData.isAppUpdate = true
                        }
                    }
                } else if appRes == "Failure: HTTP request failed" {
                    let appRes = await appUpdateService.getAppUpdate(loginData: loginData)
                    if appRes == "Success" {
                        if loginData.appUpdate.count != 0 {
                            let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject

                            //Then just cast the object as a String, but be careful, you may want to double check for nil
                            let version = nsObject as! String
                            print("==========================================")
                            print(version)
                            if loginData.appUpdate[0].iOSVersion != version {
                                loginData.isAppUpdate = true
                            }
                        }
                    } else if appRes == "Failure: HTTP request failed" {
                        loginData.isAppUpdate = false
                    }
                }
                
            }
            
            if loginData.loginStatusFinal{
//                feedService.getFeed(globalVM: globalVM, userID: loginData.mainUserID)
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
            }
        }
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
