//
//  DeleteUserAccountBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 24/07/23.
//

import SwiftUI

struct DeleteUserAccountBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    
    @StateObject var deleteService = DeleteAccountService()
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    @Binding var alertCantPost: Bool
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                    VStack(alignment: .leading){
                        
                        Text("Do you really want to delete this account?")
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .padding(.top, UIScreen.screenHeight/60)
                        
                        Spacer()
                        
                        HStack{
                            Spacer()
                            Button(action: {
                                Task{
                                    loginData.showLoader = true
                                    let response = await deleteService.deleteAccount(userID: loginData.mainUserID)
                                    if response == "Success" {
                                        loginData.notificationMessageView = false
                                        loginData.notificationPostView = false
                                        loginData.notificationProfileView = false
                                        loginData.loginStatusFinal = false
                                        loginData.userAlreadyExist = false
                                        loginData.interestSelected  = false
                                        loginData.onboardingCompleted = false
                                        loginData.logStatusviaNumber  = false
                                        loginData.showLoader = false
                                    } else {
                                        loginData.deleteAccountBottomSheetToggle.toggle()
                                        alertCantPost = true
                                        loginData.showLoader = false
                                    }
                                }
                            }, label: {
                                Text("Yes, I'm sure.")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/20)
                                    .background(greenUi)
                                    .cornerRadius(10)
                            })
                            Spacer()
                        }
                        .padding(.vertical, UIScreen.screenHeight/90)
                        
                        
                        HStack{
                            Spacer()
                            Button(action: {
                                loginData.deleteAccountBottomSheetToggle.toggle()
                            }, label: {
                                Text("No")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/20)
                                    .background(greenUi)
                                    .cornerRadius(10)
                            })
                            Spacer()
                        }
                        .padding(.vertical, UIScreen.screenHeight/110)
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.bottom,edges?.bottom)
                    .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/4)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: loginData.deleteAccountBottomSheetToggle ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.deleteAccountBottomSheetToggle ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.deleteAccountBottomSheetToggle.toggle()
                    }
                }
            )
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
                    loginData.deleteAccountBottomSheetToggle.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct DeleteUserAccountBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        DeleteUserAccountBottomSheet()
//    }
//}
