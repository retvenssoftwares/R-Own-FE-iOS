//
//  SendOTPBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 08/04/23.
//


import SwiftUI
import AlertToast

struct SendOTPBottomSheetView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    @FocusState private var isKeyboardShowing: Bool
    
    @State var alertForRetry: Bool = false
    
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                    ScrollView(.vertical, showsIndicators: false, content: {
                        VStack{
                            VStack(spacing: UIScreen.screenHeight/110){
                                Text("OTP will be sent to")
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.center)
                                
                                Text(loginData.mainUserPhoneNumber)
                                    .foregroundColor(.black)
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                            .padding(.vertical, UIScreen.screenHeight/80)
                            
                            VStack(spacing: UIScreen.screenHeight/100){
                            
                                CustomGreenButton(title: "Send OTP", action: {
                                    loginData.showLoader = true
                                    Task {
                                        let res = await loginData.getOTPCode(loginData: loginData)
                                        if res == "Success" {
                                            loginData.otpSent = true
                                            loginData.showLoader = false
                                        } else {
                                            alertForRetry = true
                                        }
                                    }})
                                .background(Color.white)
                                .cornerRadius(10)
                                .navigationDestination(isPresented: $loginData.otpSent) {
                                    OTPVerificationView(loginData:loginData, globalVM: globalVM)
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true)
                                }
                                
                                CustomBlueButton(title: "Change Phone Number") {
                                    loginData.showSheet.toggle()
                                }
                                .background(Color.white)
                                .cornerRadius(10)
                            }
                            .padding(.horizontal)
                            .padding(.bottom)
                            .padding(.bottom,edges?.bottom)
                        }
                    })
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/3.5)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: loginData.showSheet ? 0 : UIScreen.main.bounds.height)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
            .frame(width: UIScreen.screenWidth)
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showSheet.toggle()
                    }
                }
            )
            .toast(isPresenting: $alertForRetry, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try again")
            }
    }
    func onChanged(value: DragGesture.Value){
        if value.translation.height > 0{
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value){
        if value.translation.height > 0{
            withAnimation(Animation.easeInOut(duration: 0.2)){
                
                //onChecking
                
                let height = UIScreen.screenHeight/3
                
                if value.translation.height > height/1.5 {
                    loginData.showSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct SendOTPBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        SendOTPBottomSheetView()
//    }
//}
