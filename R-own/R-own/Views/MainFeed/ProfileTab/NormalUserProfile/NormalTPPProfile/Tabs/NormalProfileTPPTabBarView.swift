//
//  NormalProfileTabBarView.swift
//  R-own
//
//  Created by Aman Sharma on 12/05/23.
//

import SwiftUI

struct NormalProfileTPPTabBarView: View {
    
    @Binding var profileTabSelected: String
    
    var body: some View {
        HStack{
            Button(action: {
                withAnimation{
                    profileTabSelected = "Media"
                }
            }, label: {
                Text("Media")
                    .font(.body)
                    .fontWeight(.light)
                    .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/50)
                    .background(profileTabSelected == "Media" ? .white : .white.opacity(0))
            })
            
            Button(action: {
                withAnimation{
                    profileTabSelected = "Polls"
                }
            }, label: {
                Text("Polls")
                    .font(.body)
                    .fontWeight(.light)
                    .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/50)
                    .background(profileTabSelected == "Polls" ? .white : .white.opacity(0))
            })
            
        }
        .frame(width: UIScreen.screenWidth)
        .padding(.vertical, UIScreen.screenHeight/60)
        .background(profilePostBG)
    }
}

//struct NormalProfileTabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileTabBarView()
//    }
//}
