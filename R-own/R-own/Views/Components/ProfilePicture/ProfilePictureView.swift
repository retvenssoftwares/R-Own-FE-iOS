//
//  ProfilePictureView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI
import Shimmer

struct ProfilePictureView: View {
    
    @State var profilePic: String
    @State var verified: Bool
    @State var height: CGFloat
    @State var width: CGFloat
    
    @State private var currentUrl: URL?
    
    var body: some View {
        VStack{
            //profilepic
            if profilePic == "" {
                Image("UserIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
            } else {
                ZStack{
                    AsyncImage(url: currentUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Circle()
                            .fill(lightGreyUi)
                            .frame(width: width, height: height)
                            .shimmering(active: true)
                    }
                    .frame(width: width, height: height)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.black, lineWidth: 0.8))
                    .clipped()
                    .overlay{
                        if verified {
                            Image("VerifiedIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width/2.5, height: height/2.5)
                                .offset(x: width/2.7, y: -height/2.7)
                            
                        }
                    }
                    .onAppear {
                        if currentUrl == nil {
                            DispatchQueue.main.async {
                                currentUrl = URL(string: profilePic.replacingOccurrences(of: " ", with: "%20"))
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct ProfilePictureView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfilePictureView()
//    }
//}
