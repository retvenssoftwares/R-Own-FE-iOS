//
//  ProfileView.swift
//  R-own
//
//  Created by Aman Sharma on 11/04/23.
//

import SwiftUI

struct ProfileView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Notification Var
    @StateObject var profileVM: ProfileViewModel
    
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var role: String
    @State var mainUser: Bool
    @State var userID: String
    
    var body: some View {
        ZStack{
            VStack{
                if role == "Hotelier" {
                    NormalProfileFPPView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: role, mainUser: mainUser, userID: userID)
                } else if role == "Business Vendor / Freelancer" {
                    VendorFPPProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, role: role, mainUser: mainUser, userID: userID, mesiboVM: mesiboVM)
                } else if role == "Hotel Owner" {
                    HotelOwnerFPPProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, role: role, mainUser: mainUser, userID: userID, mesiboVM: mesiboVM)
                } else {
                    NormalProfileFPPView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: role, mainUser: mainUser, userID: userID)
                }
            }
            .padding(.top, mainUser ? UIScreen.screenHeight/80 : 0)
        }
        .navigationBarBackButtonHidden()
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
