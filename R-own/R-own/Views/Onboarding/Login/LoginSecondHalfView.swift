//
//  LoginSecondHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 08/04/23.
//

import SwiftUI

struct LoginSecondHalfView: View {
    
    //login variables
    @ObservedObject var loginData: LoginViewModel
    
    @Binding var numberNotPresetToast: Bool
    @Binding var lessNumberToast: Bool
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var selectedCountryFlag: String = "🇮🇳"
    @State var selectedCountryCode: String = "91"
    @State var phoneNumber: String = ""
    @State var searchText: String = ""
    @State var openBottomSheet: Bool = false
    
    @StateObject var globalVM: GlobalViewModel
    
    var filteredData: [CountriesForBar] {
        if searchText.isEmpty {
            return loginData.countriesList
        } else {
            return loginData.countriesList.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack{
            VStack{
                Text("intro-str-1")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, UIScreen.screenHeight/100)
                
                Text("intro-str-2")
                    .foregroundColor(.black)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("login-str")
                    .foregroundColor(.black)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                VStack(spacing: UIScreen.screenHeight/60){
                    HStack{
                        Button(action: {
                            openBottomSheet.toggle()
                        }, label: {
                            HStack(spacing: 4){
                                Text(selectedCountryFlag)
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                Text("+")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                Text(selectedCountryCode)
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                            }
                            .frame(height: UIScreen.screenHeight/20)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lightGreyUi, lineWidth: 1)
                            )
                        })
                        .sheet(isPresented: $openBottomSheet) {
                            VStack{
                                HStack{
                                    Text("Select your country: ")
                                        .font(.title2)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                        .padding(.vertical, UIScreen.screenHeight/50)
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                    Spacer()
                                }
                                
                                
                                TextField("Search", text: $searchText)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.default)
                                    .font(.subheadline)
                                    .padding()
                                    .frame(width: UIScreen.screenWidth/1.1)
                                    .cornerRadius(5)
                                    .overlay{
                                        if searchText == "" {
                                            HStack{
                                                Spacer()
                                                Image("ExploreSearchIcon")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                    .padding(.trailing, UIScreen.screenWidth/10)
                                            }
                                        } else {
                                            Button(action: {
                                                searchText = ""
                                            }, label: {
                                                HStack{
                                                    Spacer()
                                                    Image(systemName: "xmark.circle")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                        .foregroundColor(.black)
                                                        .padding(.trailing, UIScreen.screenWidth/10)
                                                }
                                            })
                                        }
                                    }
                                    .focused($isKeyboardShowing)
                                
                                ScrollView {
                                    ForEach(0..<filteredData.count, id: \.self){ count in
                                        if filteredData[count].name != "China" {
                                            VStack{
                                                Button(action: {
                                                    selectedCountryCode = filteredData[count].phoneCode
                                                    selectedCountryFlag = filteredData[count].emoji
                                                    openBottomSheet.toggle()
                                                }, label: {
                                                    HStack{
                                                        Text(filteredData[count].emoji)
                                                            .font(.subheadline)
                                                            .fontWeight(.regular)
                                                            .foregroundColor(.black)
                                                        Text(filteredData[count].phoneCode)
                                                            .font(.subheadline)
                                                            .fontWeight(.regular)
                                                            .foregroundColor(.black)
                                                        Text(filteredData[count].name)
                                                            .font(.subheadline)
                                                            .fontWeight(.regular)
                                                            .foregroundColor(.black)
                                                        Spacer()
                                                    }
                                                    .padding(.horizontal, UIScreen.screenWidth/20)
                                                })
                                                
                                                Divider()
                                            }
                                        }
                                    }
                                }
                                .padding(.top, UIScreen.screenHeight/80)
                            }
                            .presentationDetents([.medium])
                        }
                        
                        TextField("Enter phone number", text: $phoneNumber)
                            .frame(height: UIScreen.screenHeight/20)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .font(.body)
                            .limitInputLength(value: $phoneNumber, length: 10)
                            .keyboardType(.phonePad)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lightGreyUi, lineWidth: 1)
                            )
                            .focused($isKeyboardShowing)
                            .onChange(of: phoneNumber) { newText in
                                if newText.count == 10 {
                                    
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                                }
                            }
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    
                                    Button("Done") {
                                        
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                                    }
                                }
                            }
                    }
                    
                    CustomGreenButton(title: "continue-str-1", width: UIScreen.screenWidth/1.4, action: {
                        if phoneNumber.count == 10 {
                            loginData.mainUserPhoneNumber = "+"+selectedCountryCode+phoneNumber
                            loginData.showSheet.toggle()
                            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                        } else if phoneNumber == "" {
                            numberNotPresetToast.toggle()
                        } else if phoneNumber.count < 10 {
                            lessNumberToast.toggle()
                        }
                        
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                    })
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                }
                .padding()
                .frame(width: UIScreen.screenWidth/1.3)
            }
            Spacer()
            VStack{
                
//                Text("continue-str-2")
//                    .foregroundColor(.black)
//                    .font(.system(size: 15))
//                    .multilineTextAlignment(.center)
//                HStack{
//
//                    //Custom Google SignIn Button
//                    Button(action:{
////                        loginData.signInWithGoogle()
//                        print("signing in with google")
//                    }){
//                        Image("GLogin")
//                    }
//
//                    //Custom Apple SignIn Button
//                    Button(action:{
//                        print("signing in with apple")
//                    }){
//                        Image("AppleLogin")
//                    }
//                    .overlay{
//                        //Native Apple SignIn Button
////                        SignInWithAppleButton{ (request) in
////
////                            loginData.nonce = randomNonceString()
////
////                            request.requestedScopes = [.email, .fullName]
////                            request.nonce = sha256(loginData.nonce)
////
////                            //getting error or success
////                        } onCompletion:{ (result) in
////                            switch result{
////                            case .success(let user):
////                                print("Success")
////
////                                //doing login with firebase
////                                guard let credential = user.credential as?
////                                        ASAuthorizationAppleIDCredential else{
////                                    print("Error with firebase")
////                                    return
////                                }
////                                loginData.appleAuthenticate(credential: credential)
////
////                            case .failure(let error):
////                                print(error.localizedDescription)
////                            }
////                        }
////                        .frame(width: 41,height: 41)
////                        .offset(x:40)
////                        .blendMode(.overlay)
//                    }
//
//                    }
//                .padding()
                
                Spacer()
                VStack(spacing: UIScreen.screenHeight/90){
                    Text("terms-str-1")
                        .foregroundColor(.black)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                    
                    HStack{
                        Text("terms-str-2")
                            .foregroundColor(.black)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .underline()
                            .onTapGesture {
                                UIApplication.shared.open(URL(string: "https://www.r-own.com/terms-and-conditions")!)
                            }
                        
                        Text("terms-str-3")
                            .foregroundColor(.black)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .underline()
                            .onTapGesture {
                                UIApplication.shared.open(URL(string: "https://www.r-own.com/privacy-policy")!)
                            }
                        
                        //                    Text("terms-str-4")
                        //                        .foregroundColor(.black)
                        //                        .font(.body)
                        //                        .multilineTextAlignment(.center)
                        //                        .padding()
                        //                        .onTapGesture {
                        //                            UIApplication.shared.open(URL(string: "https://www.r-own.com/privacy-policy")!)
                        //                        }
                    }
                }
                .padding(.bottom, UIScreen.screenHeight/60)
            }
            Spacer()
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
    } 
}

//struct LoginSecondHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginSecondHalfView()
//    }
//}
