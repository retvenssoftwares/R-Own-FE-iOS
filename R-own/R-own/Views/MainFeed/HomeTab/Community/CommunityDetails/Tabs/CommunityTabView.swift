//
//  CommunityTabView.swift
//  R-own
//
//  Created by Aman Sharma on 23/05/23.
//

import SwiftUI

struct CommunityTabView: View {
    
    @StateObject var communityVM: CommunityViewModel
    
    var body: some View {
        HStack(spacing: 10){
            Button(action: {
                communityVM.selectedCommunityTab = "Users"
            }, label: {
                if communityVM.selectedCommunityTab == "Users" {
                    Text("Users")
                        .font(.body)
                        .fontWeight(.light)
                        .padding(.horizontal, UIScreen.screenWidth/3)
                        .foregroundColor(.black)
                        .background(.white)
                        .cornerRadius(15)
                }
                else if communityVM.selectedCommunityTab == "Media" {
                    Text("Users")
                        .font(.body)
                        .fontWeight(.light)
                        .padding(.horizontal, UIScreen.screenWidth/3)
                        .foregroundColor(.black)
                }
            })
            
            Button(action: {
                communityVM.selectedCommunityTab = "Media"
            }, label: {
                if communityVM.selectedCommunityTab == "Media" {
                    Text("Media")
                        .font(.body)
                        .fontWeight(.light)
                        .padding(.horizontal, UIScreen.screenWidth/3)
                        .foregroundColor(.black)
                        .background(.white)
                        .cornerRadius(15)
                }
                else if communityVM.selectedCommunityTab == "Users" {
                    Text("Media")
                        .font(.body)
                        .fontWeight(.light)
                        .padding(.horizontal, UIScreen.screenWidth/3)
                        .foregroundColor(.black)
                }
            })
        }
    }
}

