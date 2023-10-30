//
//  HotelUserEditFPPProfileDetailsView.swift
//  R-own
//
//  Created by Aman Sharma on 12/06/23.
//

import SwiftUI
import Combine

struct HotelUserEditFPPProfileDetailsView: View {
    
    
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
                        TextField("Enter Username", text: $globalVM.getHotelOwnerProfileHeader.profiledata.userName)
                            .autocapitalization(.none)
                            .onReceive(Just(globalVM.getHotelOwnerProfileHeader.profiledata.userName)) { newValue in
                                let allowedCharacters = "abcdefghijklmnopqrstuvwxyz0123456789._"
                                let filtered = newValue.filter { allowedCharacters.contains($0) }
                                if filtered != newValue {
                                    self.globalVM.getHotelOwnerProfileHeader.profiledata.userName = filtered
                                }
                            }
                            .onChange(of: globalVM.getHotelOwnerProfileHeader.profiledata.userName) { newText in
                                // Limit text to maxCharacterLimit
                                if newText.count > 30 {
                                    globalVM.getHotelOwnerProfileHeader.profiledata.userName = String(newText.prefix(30))
                                }
                                loginData.usernameStatus = ""
                            }
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.1)
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
                                            let res = await userPCS.verifyUsername(loginData: loginData, userName: globalVM.getHotelOwnerProfileHeader.profiledata.userName)
                                            if res == "Success"{
                                                loginData.showLoader = false
                                            } else {
                                                loginData.showLoader = true
                                                let res = await userPCS.verifyUsername(loginData: loginData, userName: globalVM.getHotelOwnerProfileHeader.profiledata.userName)
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
                                Text("Congratulations! \(globalVM.getHotelOwnerProfileHeader.profiledata.userName) username is available")
                                    .foregroundColor(greenUi)
                                    .font(.body)
                                    .fontWeight(.thin)
                            } else if loginData.usernameStatus == "Unavailable" {
                                Text("Sorry! \(globalVM.getHotelOwnerProfileHeader.profiledata.userName) username isn’t available")
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
                        
                        TextEditor(text: $loginData.userData.userBio)
                            .frame(height: UIScreen.screenHeight/8)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                    }
                    
                    
                    //gender
                    VStack{
                            Divider()
                                .background(greenUi)
                                .overlay{
                                    Text("How do you identify?")
                                        .font(.body)
                                        .fontWeight(.thin)
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                        .foregroundColor(greenUi)
                                        .background(.white)
                                        .offset(x: -UIScreen.screenWidth/3)
                                }
                        ScrollView(.horizontal){
                            HStack{
                                Button(action: {
                                    loginData.userData.gender = "Male"
                                }, label: {
                                    HStack{
                                        Text("Male")
                                            .foregroundColor(.black)
                                        Image(loginData.userData.gender == "Male" ? "PollsSelected": "PollsUnselected")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/50)
                                    .padding(.vertical, UIScreen.screenHeight/80)
                                    .background(.white)
                                    .cornerRadius(5)
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                    .padding(.horizontal, UIScreen.screenWidth/40)
                                })
                                .padding()
                                
                                
                                Button(action: {
                                    loginData.userData.gender = "Female"
                                }, label: {
                                    HStack{
                                        Text("Female")
                                            .foregroundColor(.black)
                                        Image(loginData.userData.gender == "Female" ? "PollsSelected": "PollsUnselected")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/50)
                                    .padding(.vertical, UIScreen.screenHeight/80)
                                    .background(.white)
                                    .cornerRadius(5)
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                    .padding(.horizontal, UIScreen.screenWidth/40)
                                })
                                .padding()
                                
                                
                                Button(action: {
                                    loginData.userData.gender = "Non Binary"
                                }, label: {
                                    HStack{
                                        Text("Non Binary")
                                            .foregroundColor(.black)
                                        Image(loginData.userData.gender == "Non Binary" ? "PollsSelected": "PollsUnselected")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/50)
                                    .padding(.vertical, UIScreen.screenHeight/80)
                                    .background(.white)
                                    .cornerRadius(5)
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                    .padding(.horizontal, UIScreen.screenWidth/40)
                                })
                                .padding()
                                
                                
                                Button(action: {
                                    loginData.userData.gender = "Prefer not to say"
                                }, label: {
                                    HStack{
                                        Text("Prefer not to say")
                                            .foregroundColor(.black)
                                        Image(loginData.userData.gender == "Prefer not to say" ? "PollsSelected": "PollsUnselected")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/50)
                                    .padding(.vertical, UIScreen.screenHeight/80)
                                    .background(.white)
                                    .cornerRadius(5)
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                    .padding(.horizontal, UIScreen.screenWidth/40)
                                })
                                .padding()
                            }
                        }
                        .padding(.vertical, UIScreen.screenHeight/50)
                    }
                }
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
    }
}
