//
//  MessageDateTab.swift
//  R-own
//
//  Created by Aman Sharma on 20/07/23.
//

import SwiftUI

struct MessageDateTab: View {
    
    @State var date: String
    
    var body: some View {
        if date != "" {
            Text(date)
                .font(.body)
                .fontWeight(.regular)
                .padding(.horizontal, UIScreen.screenWidth/60)
                .padding(.vertical, UIScreen.screenHeight/110)
                .background(chatLightGreenColorUI)
                .cornerRadius(15)
        }
    }
}

//struct MessageDateTab_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageDateTab()
//    }
//}
