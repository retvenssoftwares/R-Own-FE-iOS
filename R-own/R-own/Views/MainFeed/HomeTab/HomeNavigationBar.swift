//
//  HomeNavigationBar.swift
//  R-own
//
//  Created by Aman Sharma on 11/04/23.
//

import SwiftUI
import mesibo
import Shimmer

struct HomeNavigationBar: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Mesibo Var
    @StateObject var mesiboData: MesiboViewModel
    
    //Feed Var
    @StateObject var feedData: MainFeedViewModel
    
    //Notification Var
    @StateObject var notificationVM: NotificationViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var communityVM: CommunityViewModel
    
    @State var navigateToMessaging: Bool = false
    @State var navigateToNotification: Bool = false
    
    @State var unreadChatCount: Int = 0
    @State var isanimating: Bool = true
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                HStack{
                    Button(action: {
                        withAnimation{
                            feedData.sidebarX = 0
                        }
                    }, label: {
                        Image("TopNavHamburger")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        navigateToNotification.toggle()
                    }, label: {
                        Image("NotificationIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                    })
                    .navigationDestination(isPresented: $navigateToNotification, destination: {
                        NotificationsView(loginData: loginData, notificationVM: notificationVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboData)
                    })
                    
                    Button(action: {
                        navigateToMessaging.toggle()
                    }, label: {
                        
                        Image("TopNavChat")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                            .overlay{
                                if mesiboData.unreadChatCount > 0{
                                    Circle()
                                        .fill(jobsDarkBlue)
                                        .overlay{
                                            Text("\(mesiboData.unreadChatCount)")
                                                .font(.body)
                                                .foregroundColor(greenUi)
                                                .fontWeight(.bold)
                                            //                                            .padding(4)
                                                .cornerRadius(15)
                                        }
                                        .offset(x: 10, y: -10)
                                }
                            }
                    })
                    .navigationDestination(isPresented: $navigateToMessaging, destination: {
                        ChatView(loginData: loginData, mesiboData: mesiboData, globalVM: globalVM, profileVM: profileVM, communityVM: communityVM)
                    })
                    
                }
                .padding(.top, UIScreen.screenHeight/25)
                .padding(.bottom, 10)
                .padding(.horizontal, UIScreen.screenWidth/30)
                .overlay{
                    Image("RownNameIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                        .offset(y: UIScreen.screenHeight/90)
                        .opacity(loginData.rownLogoOpacity)
                        .overlay{
                            Image("RownLogoTransparent")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/25, height: UIScreen.screenHeight/25)
                                .offset(x: loginData.rownLogoXOffset)
                                .offset(y: UIScreen.screenHeight/90)
                        }
                        .shimmering(
                            active: isanimating,
                            animation: .easeInOut(duration: 2).repeatCount(5, autoreverses: false).delay(1)
                        )
                }
                .padding(.top, UIScreen.screenHeight/70)
            }
        }
        .onAppear{
            if !loginData.rownLogoPosChange {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    withAnimation(.spring()){
                        loginData.rownLogoXOffset = -UIScreen.screenHeight/15
                        loginData.rownLogoPosChange = true
                        loginData.rownLogoOpacity = 1
                    }
                }
            }
            mesiboData.messageList = [MessageListModel]()
            mesiboData.mesiboMessageListInit(loginData: loginData)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isanimating = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                mesiboData.unreadChatCount = 0
                if mesiboData.messageList.count > 0 {
                    print("message count \(mesiboData.messageList.count)")
                    for message in mesiboData.messageList {
                        if message.mMessage.isIncoming(){
                            print("message is incoming")
                            if message.mMessage.isUnread() {
                                print("message is unread")
                                mesiboData.unreadChatCount += 1
                                print("unread chat count \(mesiboData.unreadChatCount)")
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct HomeNavigationBar_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeNavigationBar()
//    }
//}
