//
//  EmailSentBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 08/04/23.
//

import SwiftUI

struct EmailSentBottomSheetView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var userVM = UserViewModel()
    
    @State var isLoading: Bool = true
    
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        VStack(spacing: 20){
                            Text("Verification code has been sent to")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            
                            Text(loginData.mainUserEmail)
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                            
                            Button(action:{
                                if  loginData.userAlreadyExist{
                                    loginData.loginStatusFinal = true
                                } else {
                                    loginData.navigateToInterestView.toggle()
                                }
//                                loginData.testverifyemail(loginData: loginData)
                            } ){
                                
                                Text("Let's Go")
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .fontWeight(.light)
                                    .padding(.vertical, 7)
                                    .padding(.horizontal, UIScreen.screenWidth/4)
                                    .background(greenUi)
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                            .navigationDestination(isPresented: $loginData.navigateToInterestView) {
                                if loginData.userAlreadyExist{
                                    MainFeedView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, isLoading: $isLoading)
                                }else {
                                    SelectInterestView(loginData:loginData, globalVM: globalVM)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                    })
                    .frame(width: UIScreen.screenWidth,height: UIScreen.screenHeight/3)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: loginData.showSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showSheet.toggle()
                    }
                }
            )
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

//struct EmailSentBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmailSentBottomSheetView()
//    }
//}
