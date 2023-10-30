//
//  PersonalNotificationView.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI

struct PersonalNotificationView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @StateObject var notificationService = NotificationService()
    @State var counter: Int = 0
    
    var body: some View {
        
        VStack{
            ScrollView{
                LazyVStack{
                    if globalVM.personalNotificationList.count > 0 {
                        ForEach(0..<globalVM.personalNotificationList.count, id: \.self){ count in
                            VStack{
                                PersonalNotificationCard(notification: globalVM.personalNotificationList[count], globalVM: globalVM, loginData: loginData, mesiboVM: mesiboVM, profileVM: profileVM)
                                    .padding(.vertical, UIScreen.screenHeight/70)
                                    .onAppear{
                                        print(count)
                                        if count == globalVM.personalNotificationList.count - 2 {
                                            counter = counter + 1
                                            print("counter")
                                            print(counter)
                                            notificationService.getPersonalNotification(globalVM: globalVM, loginData: loginData, pageNo: String(counter))
                                        }
                                    }
                                Divider()
                            }
                        }
                    } else {
                        Spacer()
                        Image("NotificationNotAvailableYet")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/2)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .onAppear{
            globalVM.personalNotificationList = [GetPersonalNotification]()
            notificationService.getPersonalNotification(globalVM: globalVM, loginData: loginData, pageNo: "1")
        }
    }
}

//struct PersonalNotificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonalNotificationView()
//    }
//}
