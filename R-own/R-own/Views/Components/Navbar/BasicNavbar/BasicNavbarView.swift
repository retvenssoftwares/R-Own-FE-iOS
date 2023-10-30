//
//  BasicNavbarView.swift
//  R-own
//
//  Created by Aman Sharma on 16/05/23.
//

import SwiftUI

struct BasicNavbarView: View {
    
    @State var navbarTitle: String
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        //Navbar
        HStack{
            //button
            
            Spacer()
            //text
            Text(navbarTitle)
                .font(.body)
                .fontWeight(.bold)
            
            Spacer()
            
        }
        .overlay{
            HStack{
                
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.backward.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                        .foregroundColor(.black)
                        .padding(.leading, UIScreen.screenWidth/30)
                })
                Spacer()
            }
        }
        .padding(.horizontal, UIScreen.screenWidth/40)
        .padding(.vertical, UIScreen.screenHeight/70)
        .border(width: 1, edges: [.bottom], color: .black)
    }
}

//struct BasicNavbarView_Previews: PreviewProvider {
//    static var previews: some View {
//        BasicNavbarView()
//    }
//}
