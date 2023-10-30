//
//  LastSeenSettingView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct LastSeenSettingView: View {
    
    @State var lastSeenSelected = "Everyone"
    
    var body: some View {
        VStack{
            BasicNavbarView(navbarTitle: "Last Seen")
                .padding(.bottom, UIScreen.screenHeight/40)
            VStack{
                HStack{
                    Image(lastSeenSelected == "Everyone" ? "PollsSelected" : "PollsUnselected")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                    Text("Everyone")
                        .font(.body)
                        .fontWeight(.regular)
                    Spacer()
                }
                .padding(.bottom, UIScreen.screenHeight/50)
                .padding(.horizontal, UIScreen.screenWidth/40)
                .onTapGesture {
                    lastSeenSelected = "Everyone"
                }
                
                Divider()
                
                HStack{
                    Image(lastSeenSelected == "My Connections" ? "PollsSelected" : "PollsUnselected")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                    Text("My Connections")
                        .font(.body)
                        .fontWeight(.regular)
                    Spacer()
                }
                .padding(.bottom, UIScreen.screenHeight/50)
                .padding(.horizontal, UIScreen.screenWidth/40)
                .onTapGesture {
                    lastSeenSelected = "My Connections"
                }
                
                Divider()
                
                HStack{
                    Image(lastSeenSelected == "Nobody" ? "PollsSelected" : "PollsUnselected")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                    Text("Nobody")
                        .font(.body)
                        .fontWeight(.regular)
                    Spacer()
                }
                .padding(.bottom, UIScreen.screenHeight/50)
                .padding(.horizontal, UIScreen.screenWidth/40)
                .onTapGesture {
                    lastSeenSelected = "Nobody"
                }
                
                Divider()
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct LastSeenSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LastSeenSettingView()
//    }
//}
