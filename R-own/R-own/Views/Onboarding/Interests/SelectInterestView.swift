//
//  SelectInterestView.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//

import SwiftUI

struct SelectInterestView: View {
    
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var userVM = UserViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    InterestFirstHalfView()
                    InterestSecondHalfView(loginData: loginData, globalVM: globalVM)
    //                    .background(
    //                        Rectangle()
    //                            .foregroundColor(.white)
    //                            .shadow(color: .black, radius: 2)
    //                            .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/2)
    //                    )
                }
                .frame(height: UIScreen.screenHeight, alignment: .topLeading)
                .edgesIgnoringSafeArea(.top)
                .background(
                    Image("InterestBG1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenWidth)
                        .offset(y: -10)
                        .overlay(){
                            Image("InterestBG2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth)
                                .offset(y: -67)
                        }, alignment: .top
            )
                RownLoaderView(loginData: loginData)
            }
            .onAppear{
                print("On Appear interest View")
                loginData.showLoader = true
                userVM.getInterestDetailsAfterLogin(loginData: loginData)
                
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

