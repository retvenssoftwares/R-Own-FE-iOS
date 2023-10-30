//
//  VideoFrameView.swift
//  R-own
//
//  Created by Aman Sharma on 25/04/23.
//

import SwiftUI

struct VideoFrameView: View {
    var image: CGImage?
    private let label = Text("frame")
    
    var body: some View {
        if let image = image {
            Image(image, scale: 1.0, orientation: .up, label: label)
        } else {
            Color.black
        }
    }
}

//struct VideoFrameView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoFrameView()
//    }
//}
