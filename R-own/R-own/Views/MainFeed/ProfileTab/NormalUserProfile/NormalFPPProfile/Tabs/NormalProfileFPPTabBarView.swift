//
//  NormalProfileFPPTabBarView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI

struct NormalProfileFPPTabBarView: View {
    
    @Binding var profileTabSelected: String
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileService = ProfileService()
    
    
    var body: some View {
        
        ScrollView(.horizontal){
            HStack{
                Button(action: {
                    withAnimation{
                        profileTabSelected = "Media"
                    }
                }, label: {
                    Text("Media")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/40)
                        .padding(.horizontal, UIScreen.screenWidth/20)
                        .padding(.vertical, UIScreen.screenHeight/85)
                        .background(profileTabSelected == "Media" ? .white : .white.opacity(0))
                        .cornerRadius(8)
                })
                
                Button(action: {
                    withAnimation{
                        profileTabSelected = "Polls"
                    }
                }, label: {
                    Text("Polls")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/40)
                        .padding(.horizontal, UIScreen.screenWidth/20)
                        .padding(.vertical, UIScreen.screenHeight/85)
                        .background(profileTabSelected == "Polls" ? .white : .white.opacity(0))
                        .cornerRadius(8)
                })
                
                Button(action: {
                    withAnimation{
                        profileTabSelected = "Status"
                    }
                }, label: {
                    Text("Status")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/40)
                        .padding(.horizontal, UIScreen.screenWidth/20)
                        .padding(.vertical, UIScreen.screenHeight/85)
                        .background(profileTabSelected == "Status" ? .white : .white.opacity(0))
                        .cornerRadius(8)
                })
            }
            .frame(width: UIScreen.screenWidth)
            .padding(.vertical, UIScreen.screenHeight/60)
            .padding(.leading, UIScreen.screenWidth/30)
        }
    }
}

//struct NormalProfileFPPTabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileFPPTabBarView()
//    }
//}
