//
//  AccountManagementSettingView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI
import AlertToast

struct AccountManagementSettingView: View {
    
    @StateObject var loginData: LoginViewModel
    @State var navigateToEditProfile: Bool = false
    @State var hibernateAccountToggle: Bool = false
    @State var deleteAccountToggle: Bool = false
    @State var alertCantPost: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                BasicNavbarView(navbarTitle: "Account Mannagement")
                    .padding(.bottom, UIScreen.screenHeight/50)
                VStack(alignment: .leading){
                    //                VStack(alignment: .leading){
                    //                    HStack{
                    //                        Image("EditPenIcon")
                    //                            .resizable()
                    //                            .scaledToFit()
                    //                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                    //                        Text("Edit Profile")
                    //                            .font(.system(size: UIScreen.screenHeight/70))
                    //                            .fontWeight(.regular)
                    //                    }
                    //                    .padding(.vertical, UIScreen.screenHeight/80)
                    //                    .padding(.horizontal, UIScreen.screenWidth/40)
                    //                    .onTapGesture {
                    //                        navigateToEditProfile.toggle()
                    //                    }
                    //                    .navigationDestination(isPresented: $navigateToEditProfile, destination: {
                    //                        //logic to navigate edit according to user role
                    //                    })
                    //                    Divider()
                    //                }
                    //
                    //                VStack(alignment: .leading){
                    //                    HStack{
                    //                        Image("SettingHibernateAccount")
                    //                            .resizable()
                    //                            .scaledToFit()
                    //                            .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                    //                        Text("Hibernate Account")
                    //                            .font(.system(size: UIScreen.screenHeight/90))
                    //                            .fontWeight(.regular)
                    //                    }
                    //                    .onTapGesture {
                    //                        hibernateAccountToggle.toggle()
                    //                    }
                    //                    Divider()
                    //                }
                    
                    VStack(alignment: .leading){
                        HStack{
                            Image("SettingDeleteAccount")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                            Text("Delete Account")
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        .padding(.vertical, UIScreen.screenHeight/80)
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        .onTapGesture {
                            loginData.deleteAccountBottomSheetToggle.toggle()
                        }
                        Divider()
                    }
                    Spacer()
                }
            }
            DeleteUserAccountBottomSheet(loginData: loginData, alertCantPost: $alertCantPost)
        }
        .toast(isPresenting: $alertCantPost, duration: 3, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try again!", subTitle: ("Unable to delete account"))
        }
        .navigationBarBackButtonHidden()
    }
}

//struct AccountManagementSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountManagementSettingView()
//    }
//}
