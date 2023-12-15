//
//  MediaPostView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI
import Shimmer

struct MediaProfilePostView: View {
    
    @State var post: Post643
    
    @State var imgData: [Media643]
    
    @State var loginData: LoginViewModel
    @State var profileVM: ProfileViewModel
    @State var mesiboVM: MesiboViewModel
    
    @State var navigateToImagePostDetailScreen: Bool = false
    @State var globalVM: GlobalViewModel
    @State var mainUser: Bool
    
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            NavigationLink(isActive: $navigateToImagePostDetailScreen, destination: {
                ProfilePostDetailView( post: post, loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM, mainUser: mainUser)
            }, label: {Text("")})
            AsyncImage(url: currentUrl) { image in
                image
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth/3.5, height: (UIScreen.screenWidth/3.5)*1.33)
                .clipped()
                .padding(.horizontal, UIScreen.screenWidth/30)
                .onTapGesture {
                    print("imagePost is tapped")
                    navigateToImagePostDetailScreen = true
                }
                .navigationDestination(isPresented: $navigateToImagePostDetailScreen, destination: {
                    ProfilePostDetailView( post: post, loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM, mainUser: mainUser)
                })
            } placeholder: {
                Rectangle()
                    .fill(lightGreyUi)
                    .frame(width: UIScreen.screenWidth/3.5, height: (UIScreen.screenWidth/3.5)*1.33)
                    .shimmering(active: true)
            }
            .onAppear {
                if currentUrl == nil {
                    DispatchQueue.main.async {
                        currentUrl = URL(string: imgData[0].post)
                    }
                }
            }
        }
        .onAppear{
            navigateToImagePostDetailScreen = false
        }
    }
}

//struct MediaPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        MediaPostView()
//    }
//}
