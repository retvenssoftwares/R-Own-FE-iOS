//
//  EventProfilePostView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI
import Shimmer

struct EventProfilePostView: View {
    
    @State var event: EventsByUserIDModel
    @State var mainUser: Bool
    
    @State private var currentUrl: URL?
    
    var body: some View {
        VStack{
            AsyncImage(url: currentUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/5)
                    .clipped()
                    .overlay{
                        HStack{
                            Text(event.categoryName)
                                .font(.system(size: UIScreen.screenHeight/110))
                                .padding(5)
                                .background(.white)
                                .cornerRadius(5)
                        }
                        .offset(x: -UIScreen.screenWidth/4, y: -UIScreen.screenHeight/16)
                    }
                    .padding(.top, 5)
            } placeholder: {
                Rectangle()
                    .fill(lightGreyUi)
                    .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/5)
                    .shimmering(active: true)
            }
            .onAppear {
                if currentUrl == nil {
                    DispatchQueue.main.async {
                        currentUrl = URL(string: event.eventThumbnail)
                    }
                }
            }
            
            VStack(alignment: .leading){
                HStack{
                    VStack{
                        Text(event.eventTitle)
                            .font(.system(size: UIScreen.screenHeight/70))
                            .fontWeight(.bold)
                        HStack{
                            ProfilePictureView(profilePic: event.profilePic, verified: false, height: UIScreen.screenHeight/110, width: UIScreen.screenHeight/70)
                            Text(event.userName)
                                .font(.system(size: UIScreen.screenHeight/95))
                                .fontWeight(.light)
                        }
                    }
                    Spacer()
                }
                Divider()
                HStack{
//                    Text("182 Participants")
//                        .font(.system(size: UIScreen.screenHeight/110))
//                        .fontWeight(.light)
                    Spacer()
                    Text(event.eventStartDate)
                        .font(.system(size: UIScreen.screenHeight/95))
                        .fontWeight(.light)
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/50)
            .padding(.vertical, UIScreen.screenHeight/40)
        }
        .background(.white)
        .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/2.5)
        .cornerRadius(15)
        .clipped()
        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
    }
}

//struct EventProfilePostView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventProfilePostView()
//    }
//}
