//
//  NotificationCArd.swift
//  R-own
//
//  Created by Aman Sharma on 07/06/23.
//

import SwiftUI

struct PersonalNotificationCard: View {
    
    @State var notification: GetPersonalNotification
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    
    
    @State var navigateToMediaPost: Bool = false
    @State var navigateToNormalStatusPost: Bool = false
    @State var navigateToCHeckinPost: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                VStack(spacing: 10){
                    HStack{
                        ProfilePictureView(profilePic: notification.profilePic, verified: false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                        Text(notification.body)
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Text(relativeTime(from: notification.dateAdded) ?? "")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/20)
            .onTapGesture {
                if notification.postType == "share some media" || notification.postType == "click and share" {
                    navigateToMediaPost.toggle()
                } else if notification.postType == "normal status" {
                    navigateToNormalStatusPost.toggle()
                } else if notification.postType == "Check-in" {
                    navigateToCHeckinPost.toggle()
                }
            }
            .navigationDestination(isPresented: $navigateToMediaPost, destination: {
                if notification.postID ?? "" != "" {
                    MediaPushNotificationView(globalVM: globalVM, loginData: loginData, mesiboVM: mesiboVM, profileVM: profileVM, isPushNotification: false, postID: notification.postID!)
                }
            })
            .navigationDestination(isPresented: $navigateToNormalStatusPost, destination: {
                if notification.postID ?? "" != "" {
                    StatusPushNotificationView(globalVM: globalVM, loginData: loginData, mesiboVM: mesiboVM, profileVM: profileVM, isPushNotification: false, postID: notification.postID!)
                }
            })
            .navigationDestination(isPresented: $navigateToCHeckinPost, destination: {
                if notification.postID ?? "" != "" {
                    CheckInPostPushNotificationView(globalVM: globalVM, loginData: loginData, mesiboVM: mesiboVM, profileVM: profileVM, isPushNotification: false, postID: notification.postID!)
                }
            })
        }
    }
}

//struct NotificationCArd_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationCArd()
//    }
//}
