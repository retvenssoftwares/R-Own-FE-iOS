//
//  PersonalNotificationCard.swift
//  R-own
//
//  Created by Aman Sharma on 07/06/23.
//

import SwiftUI

struct ConnectionNotificationCard: View {
    
    
    @State var notification: GetConnectionNotification
    @State var navigateToProfile: Bool = false
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    var body: some View {
        VStack{
            HStack{
                VStack{
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
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/20)
            .onTapGesture {
                navigateToProfile.toggle()
            }
            .navigationDestination(isPresented: $navigateToProfile, destination: {
                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: notification.role, mainUser: false, userID: notification.userID)
            })
        }
    }
}

//struct PersonalNotificationCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonalNotificationCard()
//    }
//}
