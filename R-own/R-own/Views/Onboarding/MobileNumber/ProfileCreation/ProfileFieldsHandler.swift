//
//  ProfileFieldsHandler.swift
//  R-own
//
//  Created by Aman Sharma on 08/04/23.
//

import SwiftUI
import AlertToast

struct ProfileFieldsHandler: View {
    
    @State var name: String = ""
    @State var phoneNumber: String = ""
    //Login Var
    @StateObject var loginData: LoginViewModel
    //Mesibo Variable
    @StateObject var userVM = UserViewModel()
    @StateObject var mesiboData = MesiboViewModel()
    
    @Binding var profilePic: UIImage?
    
    @StateObject var profileService = UserCreationService()
    
    @State var alertNoFullName: Bool = false
    @State var alertNoEmail: Bool = false
    @State var alertInvalidEmail: Bool = false
    @State private var isEmailValid = true
    @StateObject var globalVM: GlobalViewModel
    
    //keyboard var
    @FocusState private var isKeyboardShowing: Bool
    @StateObject var profileVM: ProfileViewModel
    @State var isLoading: Bool = true
    
    @State var encodedStatus: String = ""
    
    var body: some View {
        VStack{
            TextField("Enter Name", text: $loginData.mainUserFullName)
                .padding()
                .font(.body)
                .cornerRadius(7)
                .overlay{
                    // apply a rounded border
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.gray, lineWidth: 0.5)
                }
                .overlay{
                    HStack{
                        VStack{
                            Text("Your Name")
                                .font(.headline)
                                .background(Color.white)
                                .padding(.horizontal,5)
                                .fontWeight(.ultraLight)
                                .offset(x: UIScreen.screenWidth/50, y: -UIScreen.screenHeight/110)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .frame(width:UIScreen.screenWidth/1.1)
            
            VStack(spacing: 0){
                Text("This is not your username or Pin")
                    .foregroundColor(.black)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                Text("This name will be visible to your Community")
                    .foregroundColor(.black)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
            .frame(width:UIScreen.screenWidth/1.1)
            
            TextField("Enter Email", text: $loginData.mainUserEmail)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .onChange(of: loginData.mainUserEmail) { newValue in
                    // Validate the email format
                    isEmailValid = isValidEmail(email: newValue)
                }
                .padding()
                .font(.body)
                .cornerRadius(7)
                .overlay{
                    // apply a rounded border
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.gray, lineWidth: 0.5)
                }
                .overlay{
                    HStack{
                        VStack{
                            Text("Your Email")
                                .background(Color.white)
                                .padding(.horizontal,5)
                                .font(.subheadline)
                                .fontWeight(.ultraLight)
                                .offset(x: UIScreen.screenWidth/50, y: -UIScreen.screenHeight/110)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .frame(width: UIScreen.screenWidth/1.1)
                .padding(.top, UIScreen.screenHeight/70)
            
            CustomGreenButton(title: "Save") {
                if loginData.mainUserFullName == "" {
                    alertNoFullName.toggle()
                } else if loginData.mainUserEmail == "" {
                    alertNoEmail.toggle()
                } else if !isEmailValid {
                    alertInvalidEmail.toggle()
                } else if profilePic == nil {
                    print("There is no image selected")
                    mesiboData.addUserToMesiboModelFunc(loginData: loginData)
                    print(loginData.mainUserPhoneNumber)
                    print(loginData.mainUserFullName)
                    mesiboData.mesiboInitalize(loginData.mainUserMesiboToken, address: loginData.mainUserPhoneNumber, remoteUserName: loginData.mainUserFullName)
                    mesiboData.mesiboSetSelfProfile(loginData.mainUserPhoneNumber)
                    encodedStatus = encodeStatusData(userID: loginData.mainUserID, userRole: loginData.mainUserRole == "" ? "Normal User" : loginData.mainUserRole)
                    mesiboData.mSelfProfile.setName(loginData.mainUserFullName)
                    mesiboData.mSelfProfile.setStatus(encodedStatus)
                    mesiboData.mSelfProfile.save()
                    print("printing mesibo data down there:")
                    print(mesiboData.mSelfProfile.getAddress())
                    print(mesiboData.mSelfProfile.getName())
                    print(mesiboData.mSelfProfile.getStatus())
                    print(mesiboData.mSelfProfile.getAddress())
                    userVM.updateUserDetailsAfterLoginWithoutPic(loginData: loginData)
                } else {
                    print("image is uploaded")
                    mesiboData.addUserToMesiboModelFunc(loginData: loginData)
                    mesiboData.mesiboInitalize(loginData.mainUserMesiboToken, address: loginData.mainUserPhoneNumber, remoteUserName: loginData.mainUserFullName)
                    mesiboData.mesiboSetSelfProfile(loginData.mainUserPhoneNumber)
                    encodedStatus = encodeStatusData(userID: loginData.mainUserID, userRole: loginData.mainUserRole == "" ? "Normal User" : loginData.mainUserRole)
                    mesiboData.mSelfProfile.setName(loginData.mainUserFullName)
                    mesiboData.mSelfProfile.setStatus(encodedStatus)
                    mesiboData.mSelfProfile.setImage(profilePic)
                    mesiboData.mSelfProfile.save()
                    print("printing mesibo data down there:")
                    print(mesiboData.mSelfProfile.getName())
                    print(mesiboData.mSelfProfile.getStatus())
                    profileService.updateUserDataAfterLogin(loginData: loginData, profilePic: profilePic, fullName: loginData.mainUserFullName, email: loginData.mainUserEmail, apnToken: loginData.apnToken)
                }
                isKeyboardShowing = false
                globalVM.keyboardVisibility = false
                loginData.showSheet.toggle()
                
                if  loginData.userAlreadyExist{
                    loginData.loginStatusFinal = true
                } else {
                    loginData.navigateToInterestView.toggle()
                }
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding(.vertical, UIScreen.screenHeight/60)
                
            Spacer(minLength: 40)
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
        .toast(isPresenting: $alertNoEmail, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Email is empty")
        }
        .toast(isPresenting: $alertNoFullName, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Full Name is empty")
        }
        .toast(isPresenting: $alertInvalidEmail, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Invalid email")
        }
        .navigationDestination(isPresented: $loginData.navigateToInterestView) {
            if loginData.userAlreadyExist{
                MainFeedView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, isLoading: $isLoading)
            }else {
                SelectInterestView(loginData:loginData, globalVM: globalVM)
            }
        }
    }
    
    // Function to validate email format
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = #"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b"#
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func encodeStatusString(input: String, shift: Int) -> String {
        var encodedData = ""
        for char in input {
            let encodedChar: Character
            if char.isLetter {
                let base = char.isLowercase ? Character("a") : Character("A")
                let encodedAscii = (Int(char.asciiValue ?? 0) - Int(base.asciiValue ?? 0) + shift) % 26
                encodedChar = Character(UnicodeScalar(encodedAscii + Int(base.asciiValue ?? 0))!)
            } else {
                encodedChar = char
            }
            encodedData.append(encodedChar)
        }
        return encodedData
    }
    func encodeStatusData(userID: String, userRole: String) -> String {
        let encodedUserID = encodeStatusString(input: userID, shift: 5)
        let encodedUserRole = encodeStatusString(input: userRole, shift: 6)
        return "\(encodedUserID)|\(encodedUserRole)"
    }
}

//struct ProfileFieldsHandler_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileFieldsHandler()
//    }
//}
