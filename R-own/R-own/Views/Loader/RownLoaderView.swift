//
//  RownLoaderView.swift
//  R-own
//
//  Created by Aman Sharma on 19/04/23.
//

import SwiftUI
import AlertToast

struct RownLoaderView: View {
    
    @StateObject var loginData: LoginViewModel
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            ZStack{
                BlurView()
                    .opacity(0.5)
                VStack {
//                    Text("Hi")
//                    LottieView(filename: "RownLoader", isPaused: false)
//                        .frame(width:UIScreen.screenWidth/4.5, height: UIScreen.screenWidth/4)
//                    Text("HiBack")
                    
                    
//                    GIFImageView("RownLoader")
//                        .frame(width:UIScreen.screenWidth/4.5, height: UIScreen.screenWidth/4)
//                        .padding(.horizontal, 20)
//                    .frame(alignment: .center)
//                    Image("RownIcon")
//                        .frame(width: UIScreen.screenWidth/5)
//                    GIFView(gifName: "RownLoader")
//                        .frame(width: 50, height: 50)
                    AlertToast(type: .loading)
                        .frame(width: UIScreen.screenWidth/5)
                }
            }
            .offset(y: offset)
            .offset(y: loginData.showLoader ? 0 : UIScreen.screenHeight)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
            .ignoresSafeArea()
    }
    
//    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIVisualEffectView {
//        let effect = UIBlurEffect(style: .systemMaterial)
//        let view = UIVisualEffectView(effect: effect)
//        view.isUserInteractionEnabled = false
//        return view
//    }
}

//struct RownLoaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        RownLoaderView()
//    }
//}
