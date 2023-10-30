//
//  ProfileCreationNumFirstHalf.swift
//  R-own
//
//  Created by Aman Sharma on 08/04/23.
//

import SwiftUI

struct ProfileCreationNumFirstHalf: View {
    var body: some View {
        VStack{
            HStack(alignment: .center, spacing: .zero){
                Text("Welcome On")
                    .foregroundColor(.black)
                    .font(.title)
                    .padding(.top, UIScreen.screenHeight/12)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("Board")
                    .foregroundColor(greenUi)
                    .font(.title)
                    .padding(.top, UIScreen.screenHeight/12)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
            Text("Please provide some details about your self, how you want us to remember.")
                .foregroundColor(.black)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.vertical, UIScreen.screenHeight/90)
                .frame(width: UIScreen.screenWidth/1.1)
        }
    }
}

//struct ProfileCreationNumFirstHalf_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileCreationNumFirstHalf()
//    }
//}
