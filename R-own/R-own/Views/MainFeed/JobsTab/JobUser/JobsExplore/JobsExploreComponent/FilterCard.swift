//
//  FilterCard.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct FilterCard: View {
    var body: some View {
        Text("Front Office")
            .font(.system(size: UIScreen.screenHeight/80))
            .fontWeight(.regular)
            .foregroundColor(.white)
            .padding(.horizontal ,UIScreen.screenHeight/50)
            .padding(.vertical, UIScreen.screenHeight/90)
            .background(jobsDarkBlue)
            .cornerRadius(10)
    }
}

//struct FilterCard_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterCard()
//    }
//}
