//
//  GroupChatTabView.swift
//  R-own
//
//  Created by Aman Sharma on 27/06/23.
//

import SwiftUI

struct GroupChatTabView: View {
    
    @Binding var communityTabSelected: String
    @State var adminStatus: Bool
    @State var memberStatus: Bool
    
    var body: some View {
        VStack{
            HStack(spacing: 10){
                
                Button(action: {
                    communityTabSelected = "Members"
                }, label: {
                    HStack{
                        Text("Members")
                            .foregroundColor(.black)
                            .font(.body)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .padding()
                    .background(communityTabSelected == "Members" ? .white : .white.opacity(0))
                    .cornerRadius(10)
                    .clipped()
                    .shadow(radius: communityTabSelected == "Members" ? 4 : 0)
                    .padding(.vertical, UIScreen.screenHeight/60)
                    
                })
                
                if memberStatus {
                    Button(action: {
                        communityTabSelected = "Media"
                    }, label: {
                        HStack{
                            Text("Media")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .frame(alignment: .leading)
                        }
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        .padding()
                        .background(communityTabSelected == "Media" ? .white : .white.opacity(0))
                        .cornerRadius(10)
                        .clipped()
                        .shadow(radius: communityTabSelected == "Media" ? 4 : 0)
                        .padding(.vertical, UIScreen.screenHeight/60)
                        
                    })
                }
            }
            .frame(width: UIScreen.screenWidth)
            .background(lightGreyUi)
            .padding(.vertical, 4)
        }
    }
}

//struct GroupChatTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupChatTabView()
//    }
//}
