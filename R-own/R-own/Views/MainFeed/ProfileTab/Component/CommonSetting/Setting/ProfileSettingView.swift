//
//  ProfileSettingView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct ProfileSettingView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @State var navigateToAccountSetting: Bool = false
    @State var navigateToNotificationSetting: Bool = false
    @State var navigateToLanguageSetting: Bool = false
    @State var navigateToVerificationSetting: Bool = false
    @State var navigateToBlockedUserList: Bool = false
    @StateObject var mesiboVM: MesiboViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Setting")
                    .padding(.bottom, UIScreen.screenHeight/40)
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        HStack{
                            Image("SettingAccount")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                            Text("Account")
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        .padding(.vertical, UIScreen.screenHeight/80)
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        .onTapGesture {
                            navigateToAccountSetting = true
                        }
                        .navigationDestination(isPresented: $navigateToAccountSetting, destination: {
                            AccountSettingView(loginData: loginData, globalVM: globalVM)
                        })
                        NavigationLink(isActive: $navigateToAccountSetting, destination: {
                            AccountSettingView(loginData: loginData, globalVM: globalVM)
                        }, label: {
                            Text("")
                        })
                        Divider()
                    }
//                    VStack(alignment: .leading){
//                        HStack{
//                            Image("SettingNotifications")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
//                            Text("Notifications")
//                                .font(.system(size: UIScreen.screenHeight/70))
//                                .fontWeight(.regular)
//                        }
//                        .padding(.vertical, UIScreen.screenHeight/80)
//                        .padding(.horizontal, UIScreen.screenWidth/40)
//                        .onTapGesture {
//                            navigateToNotificationSetting.toggle()
//                        }
//                        .navigationDestination(isPresented: $navigateToNotificationSetting, destination: {
//                            NotificationSettingView()
//                        })
//                        Divider()
//                    }
//                    VStack(alignment: .leading){
//                        HStack{
//                            Image("SettingLanguage")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
//                            Text("Language")
//                                .font(.system(size: UIScreen.screenHeight/70))
//                                .fontWeight(.regular)
//                        }
//                        .padding(.vertical, UIScreen.screenHeight/80)
//                        .padding(.horizontal, UIScreen.screenWidth/40)
//                        .onTapGesture {
//                            navigateToLanguageSetting.toggle()
//                        }
//                        .navigationDestination(isPresented: $navigateToLanguageSetting, destination: {
//                            LanguageSettingView()
//                        })
//                        Divider()
//                    }
                    VStack(alignment: .leading){
                        Button(action: {
                            navigateToBlockedUserList = true
                        }, label: {
                            HStack{
                                Image(systemName: "nosign")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.black)
                                    .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                Text("Blocked Users")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .foregroundColor(.black)
                            }
                            .padding(.vertical, UIScreen.screenHeight/80)
                            .padding(.horizontal, UIScreen.screenWidth/40)
                        })
                        .navigationDestination(isPresented: $navigateToBlockedUserList, destination: {
                            BlockedUsersListView(loginData: loginData, globalVM: globalVM, mesiboVM: mesiboVM)
                        })
                        NavigationLink(isActive: $navigateToBlockedUserList, destination: {
                            BlockedUsersListView(loginData: loginData, globalVM: globalVM, mesiboVM: mesiboVM)
                        }, label: {
                            Text("")
                        })
                        Divider()
                    }
                    VStack(alignment: .leading){
                        HStack{
                            Image("SettingApplyVerification")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                            Text("Apply For Verification")
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        .padding(.vertical, UIScreen.screenHeight/80)
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        .onTapGesture {
                            navigateToVerificationSetting = true
                        }
                        .navigationDestination(isPresented: $navigateToVerificationSetting, destination: {
                            VerificationSettingView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                        })
                        NavigationLink(isActive: $navigateToVerificationSetting, destination: {
                            VerificationSettingView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                        }, label: {
                            Text("")
                        })
                        Divider()
                    }
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            navigateToAccountSetting = false
            navigateToBlockedUserList = false
            navigateToVerificationSetting = false
        }
    }
}

//struct ProfileSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileSettingView()
//    }
//}
