//
//  CommunityNotificationsView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct CommunityNotificationsSettingView: View {
    
    @State var pushNotificationSetting: Bool = true
    @State var inAppNotificationSetting: Bool = true
    
    var body: some View {
        VStack{
            BasicNavbarView(navbarTitle: "Community Notifications")
                .padding(.bottom, UIScreen.screenHeight/50)
            
            
            VStack{
                HStack{
                    Text("Push Notifications")
                        .font(.body)
                        .fontWeight(.regular)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation{
                            pushNotificationSetting.toggle()
                        }
                    }, label: {
                        Image(pushNotificationSetting ? "ToggleOnIcon" : "ToggleOffIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                    })
                }
                .padding(.horizontal, UIScreen.screenWidth/20)
                Divider()
            }
            
            VStack{
                HStack{
                    Text("In-App Notifications")
                        .font(.body)
                        .fontWeight(.regular)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation{
                            inAppNotificationSetting.toggle()
                        }
                    }, label: {
                        Image(inAppNotificationSetting ? "ToggleOnIcon" : "ToggleOffIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                    })
                }
                .padding(.horizontal, UIScreen.screenWidth/20)
                Divider()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct CommunityNotificationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityNotificationsView()
//    }
//}
