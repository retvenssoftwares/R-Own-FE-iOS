//
//  CommunityImageDetailView.swift
//  R-own
//
//  Created by Aman Sharma on 23/05/23.
//

import SwiftUI

struct CommunityImageDetailView: View {
    
    @State var imageLink: String
    
    var body: some View {
        VStack {
            BasicNavbarView(navbarTitle: "")
            Spacer()
            Image(imageLink)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.screenWidth/1.2)
                .cornerRadius(15)
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

//struct CommunityImageDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityImageDetailView()
//    }
//}
