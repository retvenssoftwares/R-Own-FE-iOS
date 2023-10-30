//
//  UserBioAndGenderProfileCompletion.swift
//  R-own
//
//  Created by Aman Sharma on 07/06/23.
//

import SwiftUI
import AlertToast

struct UserBioAndGenderProfileCompletion: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @StateObject var userBAGCS = UserBioAndGenderProfileCompletionService()
    @State var openBottomSheet: Bool = false
    //keyboard var
    @FocusState private var isKeyboardShowing: Bool
    
    @State var naviagtetonextprofilecompletion: Bool = false
    @State var toastUserBio: Bool = false
    @State var toastGender: Bool = false

    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            VStack{
                //Navbar
                HStack{
                    //profilepic
                    if loginData.mainUserProfilePic == "" {
                        Image("UserIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                            .padding(.trailing, 10)
                    } else {
                        AsyncImage(url: currentUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Color.purple.opacity(0.1)
                        }
                        .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                        .clipShape(Circle())
                        .padding(.trailing, 10)
                        .onAppear {
                            if currentUrl == nil {
                                DispatchQueue.main.async {
                                    currentUrl = URL(string: loginData.mainUserProfilePic)
                                }
                            }
                        }
                    }
                    VStack(alignment: .leading){
                        //name text
                        Text("Hi..! \(loginData.mainUserFullName)")
                            .foregroundColor(.black)
                            .font(.title3)
                            .fontWeight(.bold)
                        //text
                        Text("Let’s gather some interesting information about you to get a best experience.")
                            .foregroundColor(.black)
                            .font(.body)
                    }
                    Spacer()
                }
                .padding(.leading, UIScreen.screenWidth/30)
                .padding(.bottom, UIScreen.screenHeight/30)
                //text field
                
                TextEditor(text: $loginData.userBio)
                    .padding()
                    .frame(width: UIScreen.screenWidth/1.1, height: UIScreen.screenWidth/5)
                    .lineLimit(nil) // Allow multiple lines
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
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 0.5)
                    ) // Add border
                    .overlay{
                        VStack{
                            HStack{
                                Text("Bio")
                                    .font(.body)
                                    .background(Color.white)
                                    .fontWeight(.ultraLight)
                                    .offset(x: UIScreen.screenWidth/30, y: -UIScreen.screenHeight/90)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .overlay{
                        VStack{
                            HStack{
                                if loginData.userBio == "" {
                                    Text("Your Bio")
                                        .foregroundColor(.black.opacity(0.5))
                                        .padding()
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .onChange(of: loginData.userBio) { newText in
                        // Limit text to maxCharacterLimit
                        if newText.count > 150 {
                            loginData.userBio = String(newText.prefix(150))
                        }
                    }
                //text field
                TextField("Your Gender", text: $loginData.userGender)
                    .disabled(true)
                    .padding()
                    .frame(width: UIScreen.screenWidth/1.1, height: UIScreen.screenHeight/20)
                    .cornerRadius(7)
                    .overlay{
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 0.5)
                    }
                    .overlay{
                        // apply a rounded border
                        
                        VStack{
                            HStack{
                                Text("Gender")
                                    .font(.body)
                                    .background(Color.white)
                                    .padding(.horizontal,UIScreen.screenWidth/30)
                                    .fontWeight(.ultraLight)
                                Spacer()
                            }
                            Spacer()
                        }
                        .offset(y: -UIScreen.screenHeight/100)
                    }
                    .focused($isKeyboardShowing)
                    .padding(.vertical, UIScreen.screenHeight/50)
                    .padding(.horizontal, UIScreen.screenWidth/30)
                    .onTapGesture {
                        openBottomSheet.toggle()
                    }
                    .sheet(isPresented: $openBottomSheet, content: {
                        VStack{
                            HStack{
                                Text("Select your gender:")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding()
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            VStack{
                                Button(action: {
                                    loginData.userGender = "Male"
                                    openBottomSheet.toggle()
                                }, label: {
                                    HStack{
                                        Text("Male")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                        Spacer()
                                    }
                                })
                                .padding()
                                Divider()
                            }
                            VStack{
                                Button(action: {
                                    loginData.userGender = "Female"
                                    openBottomSheet.toggle()
                                }, label: {
                                    HStack{
                                        Text("Female")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                        Spacer()
                                    }
                                })
                                .padding()
                                Divider()
                            }
                            VStack{
                                Button(action: {
                                    loginData.userGender = "Non Binary"
                                    openBottomSheet.toggle()
                                }, label: {
                                    HStack{
                                        Text("Non Binary")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                        Spacer()
                                    }
                                })
                                .padding()
                                Divider()
                            }
                            VStack{
                                Button(action: {
                                    loginData.userGender = "Prefer not to say"
                                    openBottomSheet.toggle()
                                }, label: {
                                    HStack{
                                        Text("Prefer not to say")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                        Spacer()
                                    }
                                })
                                .padding()
                                Divider()
                            }
                            Spacer()
                        }
                        .padding(.top, UIScreen.screenHeight/60)
                        .presentationDetents([.height(UIScreen.screenHeight/2.5)])
                    })
                
                                
                //button
                Button(action: {
                    if loginData.userBio == ""{
                        toastUserBio = true
                    } else {
                        if loginData.userBio != "" {
                            loginData.profileCompletionPercentage = "70"
                            userBAGCS.postBioAndGenderInfo(loginData: loginData)
                            naviagtetonextprofilecompletion.toggle()
                        } else{
                            print("username not selected, select one first")
                        }
                    }
                    isKeyboardShowing = false
                    globalVM.keyboardVisibility = false
                }) {
                    Text("Continue")
                        .foregroundColor(.black)
                        .font(.body)
                        .fontWeight(.medium)
                        .padding(.vertical, 10)
                        .padding(.horizontal, UIScreen.screenWidth/5)
                        .background(greenUi)
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                .navigationDestination(isPresented: $naviagtetonextprofilecompletion, destination: {
                    LocationProfileCompletionView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                })
                Spacer()
            }
            .padding(.top, UIScreen.screenHeight/15)
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
        .toast(isPresenting: $toastUserBio, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Bio not complete", subTitle: ("Enter your bio to proceed"))
        }
        .toast(isPresenting: $toastGender, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Gender not set", subTitle: ("Set your gender to proceed"))
        }
    }
}
//struct UserBioAndGenderProfileCompletion_Previews: PreviewProvider {
//    static var previews: some View {
//        UserBioAndGenderProfileCompletion()
//    }
//}
