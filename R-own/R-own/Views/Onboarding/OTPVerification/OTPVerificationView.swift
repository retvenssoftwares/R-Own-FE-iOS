//
//  OTPVerificationView.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//

import SwiftUI
import AlertToast

struct OTPVerificationView: View {
    
    //Multi-Language Var
    @StateObject var languageData = LanguageViewModel()
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    VStack{
                        LoginFirstHalfView(languageData: languageData)
                        OTPVerificationSecondHalfView(loginData: loginData, globalVM: globalVM)
                    }
                    LanguageBottomSheetView(languageData: languageData)
                    RownLoaderView(loginData: loginData)
                }
            }
            .toast(isPresenting: $loginData.wrongOTP, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Wrong OTP", subTitle: ("Enter your OTP again"))
            }
            .toast(isPresenting: $loginData.otpResent, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("checkmark.square.fill", greenUi), title: "OTP Sent", subTitle: ("OTP is sent again to you phone"))
            }
        }
        .frame(height: UIScreen.screenHeight, alignment: .top)
        .edgesIgnoringSafeArea(.top)
    }
}

//struct OTPVerificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        OTPVerificationView()
//    }
//}
