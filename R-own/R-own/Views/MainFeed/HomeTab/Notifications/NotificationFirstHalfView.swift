//
//  NotificationFirstHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI

struct NotificationFirstHalfView: View {
    var body: some View {
        //navbar
        HStack{
            Image(systemName: "chevron.backward")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
            
            Spacer()
            
            Text("Notifications")
                .font(.body)
                .fontWeight(.bold)
            
            Spacer()
        }
        .background(.white)
        .padding(.horizontal, UIScreen.screenWidth/50)
        .padding(.vertical, UIScreen.screenHeight/60)
        .border(width: 1, edges: [.bottom], color: .black)
        
    }
}

//struct NotificationFirstHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationFirstHalfView()
//    }
//}
