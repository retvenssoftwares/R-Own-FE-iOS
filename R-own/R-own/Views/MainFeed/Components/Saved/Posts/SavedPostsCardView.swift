//
//  SavedPostsCardView.swift
//  R-own
//
//  Created by Aman Sharma on 19/06/23.
//

import SwiftUI

struct SavedPostsCardView: View {
    
    @State var post: PostSave
    
    @State var loginData: LoginViewModel
    
    @State var navigateToImagePostDetailScreen: Bool = false
    @State var globalVM: GlobalViewModel
    @State var profileVM: ProfileViewModel
    @State var mesiboVM: MesiboViewModel
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            if post.media.count > 0 {
                AsyncImage(url: currentUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth/3.5, height: (UIScreen.screenWidth/3.5)*1.33)
                        .clipped()
                        .onTapGesture {
                            print("imagePost is tapped")
                            navigateToImagePostDetailScreen.toggle()
                        }
                        .navigationDestination(isPresented: $navigateToImagePostDetailScreen, destination: {
                            SavedPostDetailView(postID: post.postid, loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                        })
                } placeholder: {
                    Rectangle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenWidth/4, height: (UIScreen.screenWidth/4)*1.33)
                        .shimmering(active: true)
                }
                .onAppear {
                    if currentUrl == nil {
                        DispatchQueue.main.async {
                            currentUrl = URL(string: post.media[0].post)
                        }
                    }
                }
            }
        }
        .padding(10)
    }
}

//struct SavedPostsCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedPostsCardView()
//    }
//}
