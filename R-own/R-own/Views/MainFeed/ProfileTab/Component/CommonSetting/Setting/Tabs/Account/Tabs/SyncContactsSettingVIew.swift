//
//  SyncContactsSettingVIew.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct SyncContactsSettingVIew: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var contactService = ContactService()
    @StateObject var contactVM = ContactsViewModel()
    
    var body: some View {
        VStack{
            
            BasicNavbarView(navbarTitle: "Sync Contacts")
                .padding(.bottom,  UIScreen.screenHeight/50)
            
            Spacer()
            
            
            if loginData.contactsSynced == "Synced" {
                Image("ContactsSynced")
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.screenHeight/2)
                
            } else if loginData.contactsSynced == "Not Synced" {
                
                Text("Stay connected with ease, sync your contacts now!")
                    .font(.body)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, UIScreen.screenWidth/40)
                
                Button(action: {
                    Task.init{
                        loginData.showLoader = true
                        await contactVM.fetchContactsFromPhone(loginData: loginData, globalVM: globalVM)
                        loginData.contactsSynced = "Synced"
                    }
                }, label: {
                    Text("Sync My Contacts")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                        .frame(width: UIScreen.screenWidth/1.2)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .background(greenUi)
                        .cornerRadius(5)
                })
            }
            
            Spacer()
        }
        .onAppear{
            contactService.checkIfContactsSynced(loginData: loginData)
        }
        .navigationBarBackButtonHidden()
    }
}

//struct SyncContactsSettingVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        SyncContactsSettingVIew()
//    }
//}
