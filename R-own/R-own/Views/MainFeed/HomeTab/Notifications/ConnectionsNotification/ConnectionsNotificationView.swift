//
//  ConnectionsNotificationView.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI

struct ConnectionsNotificationView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var notificationService = NotificationService()
    
    
    @State var counter: Int = 0
    
    var body: some View {
        VStack{
            ScrollView{
                LazyVStack{
                    if globalVM.connectionNotificationList.count > 0 {
                        ForEach(0..<globalVM.connectionNotificationList.count, id: \.self){ count in
                            ConnectionNotificationCard(notification: globalVM.connectionNotificationList[count], loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM)
                                .onAppear{
                                    print(count)
                                    if count == globalVM.connectionNotificationList.count - 2 {
                                        counter = counter + 1
                                        print("counter")
                                        print(counter)
                                        notificationService.getConnectionNotification(globalVM: globalVM, loginData: loginData, pageNo: String(counter))
                                    }
                                }
                                .padding(.vertical, UIScreen.screenHeight/70)
                            
                            Divider()
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
            globalVM.connectionNotificationList = [GetConnectionNotification]()
            notificationService.getConnectionNotification(globalVM: globalVM, loginData: loginData, pageNo: "1")
        }
    }
}

//struct ConnectionsNotificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConnectionsNotificationView()
//    }
//}
