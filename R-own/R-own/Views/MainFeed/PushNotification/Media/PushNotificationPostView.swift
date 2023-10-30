//
//  PushNotificationMediaView.swift
//  R-own
//
//  Created by Aman Sharma on 14/07/23.
//

import SwiftUI

struct PushNotificationPostView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    
                }, label: {
                    Image(systemName: "arrow.backward.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                        .foregroundColor(.black)
                })
                Spacer()
            }
            .border(width: 1, edges: [.bottom], color: .black)
        }
    }
}
//struct PushNotificationMediaView_Previews: PreviewProvider {
//    static var previews: some View {
//        PushNotificationMediaView()
//    }
//}
