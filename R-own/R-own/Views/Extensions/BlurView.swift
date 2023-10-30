//
//  BlurView.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
        
        func makeUIView(context: Context) -> UIVisualEffectView {
            
            let view = UIVisualEffectView(effect: UIBlurEffect(
                style : .systemMaterialLight
            ))
            
            return view
            
        }
        
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    }
}

//struct BlurView_Previews: PreviewProvider {
//    static var previews: some View {
//        BlurView()
//    }
//}
