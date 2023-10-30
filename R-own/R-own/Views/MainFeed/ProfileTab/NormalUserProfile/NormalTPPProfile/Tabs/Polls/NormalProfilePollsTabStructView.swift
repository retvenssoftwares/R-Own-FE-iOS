//
//  NormalProfilePollsTabStructView.swift
//  R-own
//
//  Created by Aman Sharma on 12/05/23.
//

import SwiftUI

struct NormalProfilePollsTabStructView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Hostels")
                    .font(.body)
                    .fontWeight(.light)
                Image("PollsUnselected")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenHeight/90, height: UIScreen.screenHeight/90)
                Text("13 votes")
                    .font(.body)
                    .fontWeight(.thin)
                Spacer()
                Text("50%")
                    .font(.body)
                    .fontWeight(.light)
            }
            ProgressView("", value: 50, total: 100)
                .tint(greenUi)
                .frame(width: UIScreen.screenWidth/7)
        }
        .padding(.horizontal, UIScreen.screenWidth/40)
        .padding(.vertical, UIScreen.screenHeight/80)
        .background(.white)
        .cornerRadius(5)
        .border(.black)
    }
}

//struct NormalProfilePollsTabStructView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfilePollsTabStructView()
//    }
//}
