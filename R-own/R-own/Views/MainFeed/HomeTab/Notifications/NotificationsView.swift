//
//  NotificationsView.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI

struct NotificationsView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Notification Var
    @StateObject var notificationVM: NotificationViewModel
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var notificationService = NotificationService()
    
    
    var body: some View {
        NavigationStack{
            VStack{
                
                BasicNavbarView(navbarTitle: "Notification")
                NotificationSecondHalfView(notificationVM: notificationVM, loginData: loginData, globalVM: globalVM)
                
                //tabs
                
                if notificationVM.notificationCategorySelected == "Personal" {
                    PersonalNotificationView(globalVM: globalVM, loginData: loginData, mesiboVM: mesiboVM, profileVM: profileVM)
                }
                        
                if loginData.isHiddenKPI{
                    if notificationVM.notificationCategorySelected == "Community" {
                        CommunityNotificationView()
                    }
                }
                
                if notificationVM.notificationCategorySelected == "Connections" {
                    ConnectionsNotificationView(globalVM: globalVM, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM)
                }
                        
                if loginData.isHiddenKPI {
                    if notificationVM.notificationCategorySelected == "Suggestions" {
                        SuggestionsNotificationView()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct NotificationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationsView()
//    }
//}
