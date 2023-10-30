//
//  NotificationSettingView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct NotificationSettingView: View {
    
    @State var navigateToJobNotifications: Bool = false
    @State var navigateToPostNotifications: Bool = false
    @State var navigateToChatNotifications: Bool = false
    @State var navigateToCommunityNotfications: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Notifications")
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        HStack{
                            Image("SettingJobNotifications")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                            Text("Job Notifications")
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        .onTapGesture {
                            navigateToJobNotifications.toggle()
                        }
                        .navigationDestination(isPresented: $navigateToJobNotifications, destination: {
                            JobNotificationsSettingView()
                        })
                        Divider()
                    }
                    VStack(alignment: .leading){
                        HStack{
                            Image("SettingPostNotifications")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                            Text("Post Notifications")
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        .onTapGesture {
                            navigateToPostNotifications.toggle()
                        }
                        .navigationDestination(isPresented: $navigateToPostNotifications, destination: {
                            PostNotificationsSettingView()
                        })
                        Divider()
                    }
                    VStack(alignment: .leading){
                        HStack{
                            Image("SettingChatNotifications")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                            Text("Chat Notifications")
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        .onTapGesture {
                            navigateToChatNotifications.toggle()
                        }
                        .navigationDestination(isPresented: $navigateToChatNotifications, destination: {
                            ChatNotificationsSettingView()
                        })
                        Divider()
                    }
                    VStack(alignment: .leading){
                        HStack{
                            Image("SettingCommunityNotifications")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                            Text("Commmunity Notifications")
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        .onTapGesture {
                            navigateToCommunityNotfications.toggle()
                        }
                        .navigationDestination(isPresented: $navigateToCommunityNotfications, destination: {
                            CommunityNotificationsSettingView()
                        })
                        Divider()
                    }
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

//struct NotificationSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationSettingView()
//    }
//}
