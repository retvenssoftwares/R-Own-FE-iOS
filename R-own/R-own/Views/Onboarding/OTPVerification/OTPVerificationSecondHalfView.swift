//
//  OTPVerificationSecondHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 08/04/23.
//

import SwiftUI

struct OTPVerificationSecondHalfView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    //Curr-View Var
    @FocusState private var isKeyboardShowing: Bool
    
    
    @State private var countdown = 60
    @State private var isButtonVisible = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 0){
                    Text("Verification Code")
                        .foregroundColor(.black)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.top, UIScreen.screenHeight/80)
                    
                    Text("Please enter the OTP sent to")
                        .foregroundColor(.black)
                        .font(.body)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .padding(.top, UIScreen.screenHeight/80)
                    
                    Text(loginData.mainUserPhoneNumber)
                        .foregroundColor(.black)
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                }
                .frame(alignment: .leading)
                .padding(.top,30)
                .padding(.horizontal, UIScreen.screenWidth/20)
                
                Spacer()
                
            }
            OTPTextFieldView(loginData: loginData, globalVM: globalVM)
                .padding(.vertical, UIScreen.screenHeight/80)
            
            HStack{
                Text("Did not receive the OTP?")
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                

                if isButtonVisible {
                    Button(action: {
                        loginData.showLoader = true
                        loginData.resendOTPCode(loginData: loginData)
                    }, label: {
                        Text("Resend OTP")
                            .foregroundColor(greenUi)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                    })
                } else {
                    Text("\(countdown)")
                        .foregroundColor(greenUi)
                        .font(.body)
                        .fontWeight(.medium)
                        .padding()
                }
                
                Spacer()
                
            }
            .padding(.horizontal, UIScreen.screenWidth/20)
            .onReceive(timer) { _ in
                if countdown > 0 {
                    countdown -= 1
                } else {
                    // Countdown reached 0, show the button
                    isButtonVisible = true
                    timer.upstream.connect().cancel() // Stop the timer
                }
            }
//            Button(action: {
//                Task{
//                    loginData.showLoader = true
//                    loginData.showSheet = false
//                    loginData.verifyOTPCode(trylogindata: loginData)
//                }
//                isKeyboardShowing = false
//            }){
//                Text("Verify")
//                    .foregroundColor(.black)
//                    .font(.system(size: 29))
//                    .fontWeight(.light)
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, UIScreen.screenWidth/4)
//                    .background(greenUi)
//                }
//                .background(Color.white)
//                .cornerRadius(10)
//                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
//                .disableWithOpacity(loginData.otpCode.count < 6)
//                .frame(alignment: .top)
//                .padding(.bottom,10)
//                .navigationDestination(isPresented: $loginData.logStatusviaNumber) {
//                    ProfileCreationNumberView(loginData: loginData, globalVM: globalVM)
//                        .navigationBarHidden(true)
//                        .navigationBarBackButtonHidden(true)
//                }
                
                Spacer()
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
        }
    }
}

//struct OTPVerificationSecondHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        OTPVerificationSecondHalfView()
//    }
//}
