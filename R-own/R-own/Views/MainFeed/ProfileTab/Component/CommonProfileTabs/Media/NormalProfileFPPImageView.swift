//
//  NormalProfileFPPImageView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI

struct NormalProfileFPPImageView: View {
    var body: some View {
        Image("GalleryImageDemo")
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.screenWidth/3.3, height: UIScreen.screenHeight/5)
    }
}

//struct NormalProfileFPPImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileFPPImageView()
//    }
//}
