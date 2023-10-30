//
//  EditFPPProfileDetailsView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI
import Combine

struct EditFPPProfileDetailsView: View {
    
    
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
                        TextField("Enter Username", text: $globalVM.getNormalProfileHeader.data.profile.userName)
                            .autocapitalization(.none)
                            .onReceive(Just(globalVM.getNormalProfileHeader.data.profile.userName)) { newValue in
                                let allowedCharacters = "abcdefghijklmnopqrstuvwxyz0123456789._"
                                let filtered = newValue.filter { allowedCharacters.contains($0) }
                                if filtered != newValue {
                                    self.globalVM.getNormalProfileHeader.data.profile.userName = filtered
                                }
                            }
                            .onChange(of: globalVM.getNormalProfileHeader.data.profile.userName) { newText in
                                // Limit text to maxCharacterLimit
                                if newText.count > 30 {
                                    globalVM.getNormalProfileHeader.data.profile.userName = String(newText.prefix(30))
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
                                            let res = await userPCS.verifyUsername(loginData: loginData, userName: globalVM.getNormalProfileHeader.data.profile.userName)
                                            if res == "Success"{
                                                loginData.showLoader = false
                                            } else {
                                                loginData.showLoader = true
                                                let res = await userPCS.verifyUsername(loginData: loginData, userName: globalVM.getNormalProfileHeader.data.profile.userName)
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
                                Text("Congratulations! \(globalVM.getNormalProfileHeader.data.profile.userName) username is available")
                                    .foregroundColor(greenUi)
                                    .font(.body)
                                    .fontWeight(.thin)
                            } else if loginData.usernameStatus == "Unavailable" {
                                Text("Sorry! \(globalVM.getNormalProfileHeader.data.profile.userName) username isn’t available")
                                    .foregroundColor(.red)
                                    .font(.body)
                                    .fontWeight(.thin)
                            }
                        }
//
//                        TextField("Enter UserName", text: $globalVM.getNormalProfileHeader.data.profile.userName)
//                            .autocapitalization(.none)
//                            .padding(.horizontal, UIScreen.screenWidth/30)
//                            .onReceive(Just(loginData.mainUserUserName)) { newValue in
//                                let allowedCharacters = "abcdefghijklmnopqrstuvwxyz0123456789._"
//                                let filtered = newValue.filter { allowedCharacters.contains($0) }
//                                if filtered != newValue {
//                                    self.loginData.mainUserUserName = filtered
//                                }
//                            }
//                            .overlay{
//                                if loginData.usernameStatus != "" {
//                                    if loginData.usernameStatus == "Available" {
//                                        Image("UsernameRight")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
//                                            .offset(x: UIScreen.screenWidth/2.6)
//                                    } else if loginData.usernameStatus == "Unavailable" {
//                                        Image("UsernameWrong")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
//                                            .offset(x: UIScreen.screenWidth/2.6)
//                                    }
//                                } else {
//                                    Button(action: {
//
//                                    }, label: {
//                                        Text("Verify")
//                                            .font(.system( size: UIScreen.screenHeight/60))
//                                            .foregroundColor(greenUi)
//                                            .padding(.horizontal,5)
//                                            .fontWeight(.regular)
//                                            .offset(x: UIScreen.screenWidth/2.6)
//                                    })
//                                }
//                            }
//                            .focused($isKeyboardShowing)
//                            .padding(.vertical, UIScreen.screenHeight/60)
                        
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
                        
                        TextEditor(text: $globalVM.getNormalProfileHeader.data.profile.userBio)
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
                                    profileVM.mainUserGender = "Male"
                                }, label: {
                                    HStack{
                                        Text("Male")
                                            .foregroundColor(.black)
                                        Image(profileVM.mainUserGender == "Male" ? "PollsSelected": "PollsUnselected")
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
                                    profileVM.mainUserGender = "Female"
                                }, label: {
                                    HStack{
                                        Text("Female")
                                            .foregroundColor(.black)
                                        Image(profileVM.mainUserGender == "Female" ? "PollsSelected": "PollsUnselected")
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
                                    profileVM.mainUserGender = "Non Binary"
                                }, label: {
                                    HStack{
                                        Text("Non Binary")
                                            .foregroundColor(.black)
                                        Image(profileVM.mainUserGender == "Non Binary" ? "PollsSelected": "PollsUnselected")
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
                                    profileVM.mainUserGender = "Prefer not to say"
                                }, label: {
                                    HStack{
                                        Text("Prefer not to say")
                                            .foregroundColor(.black)
                                        Image(profileVM.mainUserGender == "Prefer not to say" ? "PollsSelected": "PollsUnselected")
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
                    
                    //Resume
//                    VStack{
//
//                        Divider()
//                            .background(greenUi)
//                            .overlay{
//                                Text("Add Resume")
//                                    .font(.system(size: UIScreen.screenHeight/70))
//                                    .fontWeight(.thin)
//                                    .padding(.horizontal, UIScreen.screenWidth/40)
//                                    .foregroundColor(greenUi)
//                                    .background(.white)
//                                    .offset(x: -UIScreen.screenWidth/3)
//                            }
//                        HStack{
//                            Text("Upload")
//                                .font(.system(size: UIScreen.screenHeight/70))
//                                .fontWeight(.thin)
//                            Image(systemName: "square.and.arrow.up")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
//                        }
//                        .frame(width: UIScreen.screenWidth/1.4, height: UIScreen.screenHeight/20)
//                        .background(communityGreyBG)
//                        .cornerRadius(5)
//                        .border(.black)
//                        .padding()
//
//                    }
                }
//                DesignationBottomSheetView(globalVM: globalVM, designation: $profileVM.mainUserDesignation)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
    }
}

//struct EditFPPProfileDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditFPPProfileDetailsView()
//    }
//}
