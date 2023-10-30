//
//  InterestFirstHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 09/04/23.
//

import SwiftUI

struct InterestFirstHalfView: View {
    
    @StateObject var loginData = LoginViewModel()
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: UIScreen.screenHeight/70){
                
                Text("Hello, " + loginData.mainUserFullName + "!")
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                
                
                Text("Tell us what interests you ?")
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
            }
            .padding(.top, UIScreen.screenHeight/9)
            Spacer()
        }
        .frame(width: UIScreen.screenWidth/1.3)
    }
}

//struct InterestFirstHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        InterestFirstHalfView()
//    }
//}
