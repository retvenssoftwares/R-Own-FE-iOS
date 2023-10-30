//
//  CommunityImageListView.swift
//  R-own
//
//  Created by Aman Sharma on 23/05/23.
//

import SwiftUI

struct CommunityImageListView: View {
    
    @State var navigateToImageDetailView: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack {
                    BasicNavbarView(navbarTitle: "Today")
                    VStack(spacing: 5){
                        ForEach(1...3, id: \.self){_ in
                            Image("GalleryImageDemo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/1.2)
                                .cornerRadius(15)
                                .onTapGesture {
                                    navigateToImageDetailView.toggle()
                                }
                                .navigationDestination(isPresented: $navigateToImageDetailView, destination: {
                                    CommunityImageDetailView(imageLink: "GalleryImageDemo")
                                })
                            Image("EventBGIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/1.2)
                                .cornerRadius(15)
                                .onTapGesture {
                                    navigateToImageDetailView.toggle()
                                }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct CommunityImageListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityImageListView()
//    }
//}
