//
//  NormalProfileImageView.swift
//  R-own
//
//  Created by Aman Sharma on 12/05/23.
//

import SwiftUI

struct NormalProfileImageView: View {
    var body: some View {
        Image("GalleryImageDemo")
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.screenWidth/3.3, height: UIScreen.screenHeight/5)
    }
}

//struct NormalProfileImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileImageView()
//    }
//}
