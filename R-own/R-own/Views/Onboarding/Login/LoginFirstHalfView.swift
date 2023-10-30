//
//  LoginFirstHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//

import SwiftUI

struct LoginFirstHalfView: View {
    
    //multi-language change variables
    @ObservedObject var languageData = LanguageViewModel()
    
    var body: some View {
        VStack{
            Image("LoginBG")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/2.5)
                .cornerRadius(70, corners: [.bottomLeft, .bottomRight])
//                .overlay(
//
//                    Button(action:{
//                        withAnimation{languageData.showLangBottomSheet.toggle()}
//
//                    }){
//                        LangCardView()
//                    }
//                        .background(greenUi)
//                        .offset(x: -UIScreen.screenWidth/2.5, y: -UIScreen.screenHeight/11)
//
//                )
        }
    }
}

//struct LoginFirstHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginFirstHalfView()
//    }
//}
