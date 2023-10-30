//
//  BasicInfoProfileView.swift
//  R-own
//
//  Created by Aman Sharma on 04/05/23.
//

import SwiftUI
import Combine
import AlertToast

struct BasicInfoProfileView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @StateObject var userPCS = UserProfileCompletionService()
    
    //datenTime
    @State private var dob = Date()
    
    //keyboard var
    @FocusState private var isKeyboardShowing: Bool
    
    @State var naviagtetonextprofilecompletion: Bool = false
    @State var temporaryUsername: String = ""
    
    @State var toastNameNotPresent: Bool = false
    @State var toastUserNameNotVerified: Bool = false
    
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
                TextField("Your Full Name", text: $loginData.mainUserFullName)
                    .padding()
                    .cornerRadius(7)
                    .overlay{
                        // apply a rounded border
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 0.5)
                    }
                    .overlay{
                        VStack{
                            HStack{
                                Text("Full Name")
                                    .font(.body)
                                    .background(Color.white)
                                    .fontWeight(.ultraLight)
                                    .offset(x: UIScreen.screenWidth/30, y: -UIScreen.screenHeight/90)
                                Spacer()
                            }
                            Spacer()
                        }

                    }
                    .focused($isKeyboardShowing)
                    .padding(.vertical, UIScreen.screenHeight/50)
                    .padding(.horizontal, UIScreen.screenWidth/30)
                
                //text field
                HStack{
                    VStack(spacing: 5){
                        Text("Date Of Birth")
                            .font(.body)
                        
                        DatePicker(
                            "Pick a date",
                            selection: $loginData.userDOB,
                            in: ...Date(),
                            displayedComponents: [.date]
                        )
                        .background(Color.white)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .accentColor(greenUi)
                    }
                    .padding(.leading, UIScreen.screenWidth/30)
                    Spacer()
                }
                
                //text field
                TextField("Enter Username", text: $loginData.mainUserUserName)
                    .autocapitalization(.none)
                    .onReceive(Just(loginData.mainUserUserName)) { newValue in
                        let allowedCharacters = "abcdefghijklmnopqrstuvwxyz0123456789._"
                        let filtered = newValue.filter { allowedCharacters.contains($0) }
                        if filtered != newValue {
                            self.loginData.mainUserUserName = filtered
                        }
                    }
                    .onChange(of: loginData.mainUserUserName) { newText in
                        // Limit text to maxCharacterLimit
                        if newText.count > 30 {
                            loginData.mainUserUserName = String(newText.prefix(30))
                        }
                        loginData.usernameStatus = ""
                        
                    }
                    .padding()
                    .cornerRadius(7)
                    .overlay{
                        // apply a rounded border
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 0.5)
                    }
                    .overlay{
                        VStack{
                            HStack{
                                Text("User Name")
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
                                    let res = await userPCS.verifyUsername(loginData: loginData, userName: loginData.mainUserUserName)
                                    if res == "Success"{
                                        loginData.showLoader = false
                                    } else {
                                        loginData.showLoader = true
                                        let res = await userPCS.verifyUsername(loginData: loginData, userName: loginData.mainUserUserName)
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
                                    .font(.system( size: UIScreen.screenHeight/60))
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
                        Text("Congratulations! \(loginData.mainUserUserName) username is available")
                            .foregroundColor(greenUi)
                            .font(.body)
                            .fontWeight(.thin)
                    } else if loginData.usernameStatus == "Unavailable" {
                        Text("Sorry! \(loginData.mainUserUserName) username isn’t available")
                            .foregroundColor(.red)
                            .font(.body)
                            .fontWeight(.thin)
                    }
                }
                //button
                Button(action: {
                    if loginData.mainUserFullName == "" {
                        toastNameNotPresent = true
                    } else if loginData.usernameStatus == "Unavailable" || loginData.usernameStatus == "" || loginData.mainUserUserName == "" {
                        toastUserNameNotVerified = true
                    } else {
                        if loginData.usernameStatus == "Available" {
                            loginData.profileCompletionPercentage = "60"
                            userPCS.postBasicProfileInfo(loginData: loginData)
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
                .padding(.vertical, UIScreen.screenHeight/70)
                .navigationDestination(isPresented: $naviagtetonextprofilecompletion, destination: {
                    UserBioAndGenderProfileCompletion(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                })
                Spacer()
            }
            .padding(.top, UIScreen.screenHeight/15)
            .onAppear{
                let (firstWord, lastWord) = getFirstAndLastWord(from: loginData.mainUserFullName)
                loginData.mainUserFirstName = firstWord
                loginData.mainUserLastName = lastWord
                print(firstWord)
                print(lastWord)
            }
            .toast(isPresenting: $toastNameNotPresent, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Name not complete", subTitle: ("Enter your name to proceed"))
            }
            .toast(isPresenting: $toastUserNameNotVerified, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Verify username", subTitle: ("Verify your username to proceed"))
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
    }
    func getFirstAndLastWord(from inputString: String) -> (String, String) {
        let words = inputString.components(separatedBy: .whitespaces)
        guard let firstWord = words.first, let lastWord = words.last else {
            return ("", "")
        }
        return (firstWord, lastWord)
    }
}

//struct BasicInfoProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        BasicInfoProfileView()
//    }
//}
