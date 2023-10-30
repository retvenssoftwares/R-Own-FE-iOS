//
//  EditVendorFPPProfileDetails.swift
//  R-own
//
//  Created by Aman Sharma on 26/07/23.
//

import SwiftUI
import Combine

struct EditVendorFPPProfileDetails: View {
    
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var userPCS = UserProfileCompletionService()
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
            ZStack {
                VStack{
                    
                    //username
                    VStack{
                        ZStack{
                            Divider()
                                .background(greenUi)
                                .overlay{
                                    Text("Change your username")
                                        .font(.body)
                                        .fontWeight(.thin)
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                        .foregroundColor(greenUi)
                                        .background(.white)
                                        .offset(x: -UIScreen.screenWidth/3)
                                }
                        }
                        
                        //text field
                        TextField("Enter Username", text: $globalVM.getVendorProfileHeader.roleDetails.userName)
                            .autocapitalization(.none)
                            .onReceive(Just(globalVM.getVendorProfileHeader.roleDetails.userName)) { newValue in
                                let allowedCharacters = "abcdefghijklmnopqrstuvwxyz0123456789._"
                                let filtered = newValue.filter { allowedCharacters.contains($0) }
                                if filtered != newValue {
                                    self.globalVM.getVendorProfileHeader.roleDetails.userName = filtered
                                }
                            }
                            .onChange(of: globalVM.getVendorProfileHeader.roleDetails.userName) { newText in
                                // Limit text to maxCharacterLimit
                                if newText.count > 30 {
                                    globalVM.getVendorProfileHeader.roleDetails.userName = String(newText.prefix(30))
                                }
                                loginData.usernameStatus = ""
                                
                            }
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.1)
                            }
                            .overlay{
                                // apply a rounded border
                                HStack(spacing: 4) {
                                    if loginData.usernameStatus != "" {
                                        if loginData.usernameStatus == "Available" {
                                            Image("UsernameRight")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                .offset(x: UIScreen.screenWidth/3)
                                        } else if loginData.usernameStatus == "Unavailable" {
                                            Image("UsernameWrong")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                .offset(x: UIScreen.screenWidth/3)
                                        }
                                    }
                                    
                                    Button(action: {
                                        print("Verifying Username")
                                        Task {
                                            loginData.showLoader = true
                                            let res = await userPCS.verifyUsername(loginData: loginData, userName: globalVM.getVendorProfileHeader.roleDetails.userName)
                                            if res == "Success"{
                                                loginData.showLoader = false
                                            } else {
                                                loginData.showLoader = true
                                                let res = await userPCS.verifyUsername(loginData: loginData, userName: globalVM.getVendorProfileHeader.roleDetails.userName)
                                                if res == "Success"{
                                                    loginData.showLoader = false
                                                } else {
                                                    loginData.showLoader = false
                                                }
                                            }
                                        }
                                        
                                        isKeyboardShowing = false
                                        globalVM.keyboardVisibility = false
                                    }, label: {
                                        Text("Verify")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .padding(.horizontal,5)
                                            .fontWeight(.regular)
                                    })
                                    .offset(x: UIScreen.screenWidth/2.6)
                                }
                                
                            }
                            .focused($isKeyboardShowing)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    
                                    Button("Done") {
                                        
                                        isKeyboardShowing = false
                                        globalVM.keyboardVisibility = false
                                    }
                                }
                            }
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                        
                        //text
                        
                        if loginData.usernameStatus != "" {
                            if loginData.usernameStatus == "Available" {
                                Text("Congratulations! \(globalVM.getVendorProfileHeader.roleDetails.userName) username is available")
                                    .foregroundColor(greenUi)
                                    .font(.body)
                                    .fontWeight(.thin)
                            } else if loginData.usernameStatus == "Unavailable" {
                                Text("Sorry! \(globalVM.getVendorProfileHeader.roleDetails.userName) username isn’t available")
                                    .foregroundColor(.red)
                                    .font(.body)
                                    .fontWeight(.thin)
                            }
                        }
                    }
                    
                    //edit bio
                    VStack{
                        
                        Divider()
                            .background(greenUi)
                            .overlay{
                                Text("Edit your bio")
                                    .font(.body)
                                    .fontWeight(.thin)
                                    .padding(.horizontal, UIScreen.screenWidth/40)
                                    .foregroundColor(greenUi)
                                    .background(.white)
                                    .offset(x: -UIScreen.screenWidth/3)
                            }
                        
                        TextEditor(text: $globalVM.getVendorProfileHeader.roleDetails.userBio)
                            .frame(height: UIScreen.screenHeight/8)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                    }
                    
                    
                    
                }
            }
    }
}

//struct EditVendorFPPProfileDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        EditVendorFPPProfileDetails()
//    }
//}
