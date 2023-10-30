//
//  IncomingVideoCallView.swift
//  R-own
//
//  Created by Aman Sharma on 24/04/23.
//

import SwiftUI

struct IncomingVideoCallView: View {
    
    var image: CGImage?
    private let label = Text("frame")
    
    var body: some View {
        HostedViewController()
            .ignoresSafeArea()
    }
}

//struct IncomingVideoCallView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncomingVideoCallView()
//    }
//}
