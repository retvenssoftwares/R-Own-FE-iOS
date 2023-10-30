//
//  DiscoverPeopleListTabView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct DiscoverPeopleListTabView: View {
    var body: some View {
        NavigationStack{
            HStack{
                VStack{
                    ProfilePictureView(profilePic: "", verified: false, height: UIScreen.screenHeight/30, width: UIScreen.screenHeight/30)
                }
                .onTapGesture {
                    print("switching to profile view")
                }
                
                Spacer()
                VStack(alignment: .leading){
                    Text("Aman Sharma")
                        .font(.body)
                        .fontWeight(.bold)
                    Text("Web Developer")
                        .font(.body)
                        .fontWeight(.regular)
                }
                .onTapGesture {
                    print("switching to profile view")
                }
                Spacer()
                VStack{
                    Button(action: {
                        print("message..")
                    }, label: {
                        Text("MESSAGE")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(jobsDarkBlue)
                            .padding(.horizontal, UIScreen.screenWidth/60)
                            .padding(.vertical, UIScreen.screenHeight/70)
                            .background(greenUi)
                            .cornerRadius(5)
                    })
                    
                    Button(action: {
                        print("connect..")
                    }, label: {
                        Text("CONNECT")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(greenUi)
                            .padding(.horizontal, UIScreen.screenWidth/60)
                            .padding(.vertical, UIScreen.screenHeight/70)
                            .background(jobsDarkBlue)
                            .cornerRadius(5)
                    })
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/20)
        }
    }
}

//struct DiscoverPeopleListTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiscoverPeopleListTabView()
//    }
//}
