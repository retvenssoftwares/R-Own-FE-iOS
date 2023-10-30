//
//  NoInternetView.swift
//  R-own
//
//  Created by Aman Sharma on 10/06/23.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        VStack{
            Image("NoInternetIllustration")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/1.5)
        }
    }
}

//struct NoInternetView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoInternetView()
//    }
//}
