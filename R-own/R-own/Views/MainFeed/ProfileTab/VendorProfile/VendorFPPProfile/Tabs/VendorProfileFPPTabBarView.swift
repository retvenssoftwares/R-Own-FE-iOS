//
//  VendorProfileFPPTabBarView.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import SwiftUI

struct VendorProfileFPPTabBarView: View {
    
    @Binding var profileTabSelected: String
    
    var body: some View {
        HStack{
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
                            .background(profileTabSelected == "Media" ? .white : .white.opacity(0))
                            .cornerRadius(15)
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
                            .background(profileTabSelected == "Polls" ? .white : .white.opacity(0))
                            .cornerRadius(15)
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
                            .background(profileTabSelected == "Status" ? .white : .white.opacity(0))
                            .cornerRadius(15)
                    })
                    
                    Button(action: {
                        withAnimation{
                            profileTabSelected = "Services"
                        }
                    }, label: {
                        Text("Services")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/40)
                            .background(profileTabSelected == "Services" ? .white : .white.opacity(0))
                            .cornerRadius(15)
                    })
                    
                }
                .padding(.vertical, UIScreen.screenHeight/60)
            }
        }
        .frame(width: UIScreen.screenWidth)
        .padding(.leading, UIScreen.screenWidth/30)
    }
}

//struct VendorProfileFPPTabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorProfileFPPTabBarView()
//    }
//}
