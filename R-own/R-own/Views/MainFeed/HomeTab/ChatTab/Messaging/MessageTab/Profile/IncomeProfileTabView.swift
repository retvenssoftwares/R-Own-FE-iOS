//
//  IncomeProfileTabView.swift
//  R-own
//
//  Created by Aman Sharma on 03/07/23.
//

import SwiftUI
import mesibo

struct IncomeProfileTabView: View {
    
    @State var fullname: String
    @State var username: String
    @State var profilePictureLink: String
    @State var userId: String
    @State var verificationStatus: String
    @State var profilePic: String
    @State var userRole: String
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @State var message: MesiboMessage
    
    @State var navigateToPostView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading, spacing: 0){
                    HStack{
                        ProfilePictureView(profilePic: profilePictureLink, verified: verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                        VStack(alignment: .leading){
                            Text(fullname)
                                .font(.body)
                                .fontWeight(.bold)
                            if username != "" {
                                Text(username)
                            }
                        }
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Text(convertTo12HourClock(message.getTimestamp().getTime(true))!)
                            .font(.footnote)
                    }
                }
                .padding()
                .frame(width: UIScreen.screenWidth/1.7)
                .background(.white)
                .cornerRadius(10, corners: .bottomLeft)
                .cornerRadius(10, corners: .topLeft)
                .cornerRadius(10, corners: .topRight)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .onTapGesture {
                    navigateToPostView.toggle()
                }
                .navigationDestination(isPresented: $navigateToPostView, destination: {
                    ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: userRole, mainUser: false, userID: userId)
                })
                
                Spacer(minLength: UIScreen.screenWidth/3)
            }
        }
    }
}

//struct IncomeProfileTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncomeProfileTabView()
//    }
//}
