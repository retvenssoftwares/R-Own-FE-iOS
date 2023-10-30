//
//  ProfileFullView.swift
//  R-own
//
//  Created by Aman Sharma on 22/08/23.
//

import SwiftUI
import Shimmer

struct ProfileFullView: View {
    @StateObject var loginData: LoginViewModel
    
    @State private var currentUrl: URL?
    
    var body: some View {
        ZStack{
            BlurView()
                .opacity(0.8)
            VStack {
                AsyncImage(url: currentUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/5)
                        .clipped()
                        .clipShape(Circle())
                } placeholder: {
                    //put your placeholder here
                    Rectangle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenHeight/5)
                        .shimmering(active: true)
                }
                .onAppear {
                    if currentUrl == nil {
                        DispatchQueue.main.async {
                            currentUrl = URL(string: loginData.selectedProfilePicMax.replacingOccurrences(of: " ", with: "%20"))
                        }
                    }
                }
            }
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .ignoresSafeArea()
        .onTapGesture {
            loginData.showProfileMax = false
        }
}
}

//struct ProfileFullView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileFullView()
//    }
//}
