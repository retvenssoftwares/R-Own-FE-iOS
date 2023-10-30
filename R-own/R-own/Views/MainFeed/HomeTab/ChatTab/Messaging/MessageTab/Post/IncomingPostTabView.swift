//
//  IncomingPostTabView.swift
//  R-own
//
//  Created by Aman Sharma on 02/07/23.
//

import SwiftUI
import Shimmer
import mesibo

struct IncomingPostTabView: View {
    
    @State var caption: String
    @State var fullname: String
    @State var username: String
    @State var profilePictureLink: String
    @State var userId: String
    @State var firstImageLink: String
    @State var postId: String
    @State var verificationStatus: String
    @State var message: MesiboMessage
    
    @State var navigateToPostView: Bool = false
    
    @State private var currentUrl: URL?
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading, spacing: 0){
                    HStack{
                        ProfilePictureView(profilePic: profilePictureLink, verified: verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                        
                        Text(fullname == "" ? username : fullname)
                            .font(.body)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.vertical, UIScreen.screenHeight/90)
                    AsyncImage(url: currentUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenWidth/1.9)
                            .clipped()
                    } placeholder: {
                        Rectangle()
                            .fill(lightGreyUi)
                            .frame(width: UIScreen.screenWidth/1.9)
                            .shimmering(active: true)
                    }
                    .onAppear {
                        if currentUrl == nil {
                            DispatchQueue.main.async {
                                currentUrl = URL(string: profilePictureLink.replacingOccurrences(of: " ", with: "%20"))
                            }
                        }
                    }
                    HStack{
                        Text(fullname == "" ? username : fullname)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text(caption)
                            .font(.footnote)
                            .fontWeight(.thin)
                        Spacer()
                    }
                    .padding(.vertical, UIScreen.screenHeight/90)
                    HStack{
                        Spacer()
                        Text(convertTo12HourClock(message.getTimestamp().getTime(true))!)
                            .font(.footnote)
                    }
                }
                .padding()
                .frame(width: UIScreen.screenWidth/1.7)
                .background(.white)
                .cornerRadius(10, corners: .bottomLeft)
                .cornerRadius(10, corners: .topLeft)
                .cornerRadius(10, corners: .topRight)
                .shadow(color: .black.opacity(0.3), radius: 4, x: 3, y: 4)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .onTapGesture {
                    navigateToPostView.toggle()
                }
                
                Spacer(minLength: UIScreen.screenWidth/3)
            }
        }
    }
}

//struct IncomingPostTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncomingPostTabView()
//    }
//}
