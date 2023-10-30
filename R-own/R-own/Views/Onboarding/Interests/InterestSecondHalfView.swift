//
//  InterestSecondHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 09/04/23.
//

import SwiftUI

struct InterestSecondHalfView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    var body: some View {
        VStack{
            Rectangle()
                .fill(.white)
                .cornerRadius(20, corners: .allCorners)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/1.7)
                .overlay(
                    InterestSearchView(loginData: loginData, globalVM: globalVM)
                )
        }
    }
}

//struct InterestSecondHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        InterestSecondHalfView()
//    }
//}
