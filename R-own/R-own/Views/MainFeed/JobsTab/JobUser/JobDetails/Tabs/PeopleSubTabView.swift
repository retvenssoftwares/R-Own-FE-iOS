//
//  PeopleSubTabView.swift
//  R-own
//
//  Created by Aman Sharma on 09/05/23.
//

import SwiftUI

struct PeopleSubTabView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var userID: String
    @State var user: HotelOwnerProfileHeaderModel
    @StateObject var mesiboVM: MesiboViewModel
    
    var body: some View {
        VStack(spacing: UIScreen.screenHeight/60){
            HStack(){
                
                ProfilePictureView(profilePic: user.profiledata.profilePic, verified: false, height: UIScreen.screenHeight/40, width: UIScreen.screenHeight/40)
                VStack{
                    Text(user.profiledata.fullName)
                        .font(.system(size: UIScreen.screenHeight/60))
                        .fontWeight(.bold)
                    
//                    Text(user.profiledata.userName)
//                        .font(.system(size: UIScreen.screenHeight/100))
//                        .fontWeight(.thin)
                }
                Spacer()
                
                Button(action: {
                    ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: "Hotel Owner", mainUser: false, userID: userID)
                }, label: {
                    Text("View Profile")
                        .font(.system(size: UIScreen.screenHeight/80))
                        .padding(.horizontal, UIScreen.screenWidth/50)
                        .padding(.vertical, UIScreen.screenHeight/80)
                        .foregroundColor(.black)
                        .background(jobsBrightGreen)
                        .cornerRadius(15)
                })
            }
            
            
            Divider()
                .padding(.vertical, UIScreen.screenHeight/70)
        }
        .padding(.top, UIScreen.screenHeight/20)
    }
}

//struct PeopleSubTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        PeopleSubTabView()
//    }
//}
