//
//  AccountSettingView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct AccountSettingView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var navigateToLastSeen: Bool = false
    @State var navigateToSyncContacts: Bool = false
    @State var navigateToAccountmanagement: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Account")
                VStack(alignment: .leading){
//                    VStack(alignment: .leading){
//                        HStack{
//                            Image("SettingLastSeen")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
//                            Text("Last Seen")
//                                .font(.system(size: UIScreen.screenHeight/90))
//                                .fontWeight(.regular)
//                        }
//                        .onTapGesture {
//                            navigateToLastSeen.toggle()
//                        }
//                        .navigationDestination(isPresented: $navigateToLastSeen, destination: {
//                            LastSeenSettingView()
//                        })
//                        Divider()
//                    }
                    VStack(alignment: .leading){
                        HStack{
                            Image("SettingSyncContacts")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                            Text("Sync Contacts")
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        .padding(.vertical, UIScreen.screenHeight/80)
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        .onTapGesture {
                            navigateToSyncContacts.toggle()
                        }
                        .navigationDestination(isPresented: $navigateToSyncContacts, destination: {
                            SyncContactsSettingVIew(loginData: loginData, globalVM: globalVM)
                        })
                        Divider()
                    }
                    VStack(alignment: .leading){
                        HStack{
                            Image("SettingAccount")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                            Text("Account Management")
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        .padding(.vertical, UIScreen.screenHeight/80)
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        .onTapGesture {
                            navigateToAccountmanagement.toggle()
                        }
                        .navigationDestination(isPresented: $navigateToAccountmanagement, destination: {
                            AccountManagementSettingView(loginData: loginData)
                        })
                        Divider()
                    }
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct AccountSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSettingView()
//    }
//}
