//
//  LoginView.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//


import SwiftUI
import AlertToast

struct LoginView: View {
    
    
    //Toast Var
    @State var numberNotPresetToast: Bool = false
    @State var lessNumberToast: Bool = false
    
    //Multi-Language Var
    @StateObject var languageData: LanguageViewModel
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var locationServices = LocationService()
    @StateObject var contactService = ContactService()
    
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    VStack{
                        LoginFirstHalfView(languageData: languageData)
                        LoginSecondHalfView(loginData: loginData, numberNotPresetToast: $numberNotPresetToast, lessNumberToast: $lessNumberToast, globalVM: globalVM)
                    }
                    .frame(height: UIScreen.screenHeight)
                    LanguageBottomSheetView(languageData: languageData)
                    SendOTPBottomSheetView(loginData: loginData, globalVM: globalVM)
                    RownLoaderView(loginData: loginData)
                }
            }
            .toast(isPresenting: $numberNotPresetToast, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Number not found", subTitle: ("Enter your number to proceed"))
//                AlertToast(displayMode: .banner(.pop), type: .regular, title: "Message Sent!")
                //toggle command to pop toast
                // {showToast.toggle()}
            }
            .toast(isPresenting: $lessNumberToast, duration: 2, tapToDismiss: true){
                AlertToast(type: .systemImage("exclamationmark.triangle.fill", .red), title: "Invalid Number", subTitle: ("Enter atleast 10 digits"))
//                AlertToast(displayMode: .banner(.pop), type: .regular, title: "Message Sent!")
                //toggle command to pop toast
                // {showToast.toggle()}
            }
            .frame(height: UIScreen.screenHeight)
            .edgesIgnoringSafeArea(.top)
            .ignoresSafeArea(.all)
        }
        .onAppear{
            locationServices.getCountriesForBar(loginData: loginData)
            contactService.getContactSyncText(loginData: loginData)
            print(loginData.apnToken)
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
