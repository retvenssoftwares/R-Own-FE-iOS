//
//  OTPTextFieldView.swift
//  R-own
//
//  Created by Aman Sharma on 08/04/23.
//

import SwiftUI

struct OTPTextFieldView: View {
    
    //Login Var
    @ObservedObject var loginData = LoginViewModel()
    
    //Curr-View Var
    @FocusState private var isKeyboardShowing: Bool
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                ForEach(0..<6, id: \.self){ index in
                    OTPTextBox(index)
                }
            }
            .background(content: {
                TextField("", text: $loginData.otpCode.limit(6))
                    .blendMode(.screen)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .onChange(of: loginData.otpCode) { newText in
                        if newText.count == 6 {
                            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                            Task{
                                loginData.showLoader = true
                                loginData.showSheet = false
                                loginData.verifyOTPCode(trylogindata: loginData)
                            }
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
            })
            .padding(.horizontal, UIScreen.screenWidth/20)
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
    }
    
    //Otp Text Box
    @ViewBuilder
    func OTPTextBox(_ index: Int)->some View{
            if loginData.otpCode.count > index{
                //Finding char at index
                let startIndex = loginData.otpCode.startIndex
                let charIndex = loginData.otpCode.index(startIndex, offsetBy: index)
                let charToString = String(loginData.otpCode[charIndex])
                ZStack{
                    Text(charToString)
                }
                .frame(width: 45,height: 45)
                .background{
                    RoundedRectangle(cornerRadius: 6,style: .continuous)
                        .stroke(.green,lineWidth: 0.5)
                }
                .frame(maxWidth: .infinity)
            }else{
                if loginData.wrongOTP {
                    ZStack{
                        Text("")
                    }
                    .frame(width: 45,height: 45)
                    .background{
                        RoundedRectangle(cornerRadius: 6,style: .continuous)
                            .stroke(.red,lineWidth: 0.5)
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    ZStack{
                        Text("")
                    }
                    .frame(width: 45,height: 45)
                    .background{
                        RoundedRectangle(cornerRadius: 6,style: .continuous)
                            .stroke(.gray,lineWidth: 0.5)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
    }
}

//struct OTPTextFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        OTPTextFieldView()
//    }
//}
