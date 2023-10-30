//
//  BlogsDetailFirstHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI
import Shimmer

struct BlogsDetailFirstHalfView: View {
    
    @StateObject var globalVM: GlobalViewModel
    
    @State private var currentUrl: URL?
    
    var body: some View {
        ZStack(alignment: .bottom){
            if globalVM.blogByBlogID.count > 0 {
                if globalVM.blogByBlogID[0].blogImage != "" {
                    AsyncImage(url: currentUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/3)
                            .cornerRadius(10, corners: .bottomLeft)
                            .cornerRadius(10, corners: .bottomRight)
                            .overlay{
                                HStack{
                                    //                            HStack{
                                    //                                Image("EyeIcon")
                                    //                                    .resizable()
                                    //                                    .scaledToFit()
                                    //                                    .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                    //                                Text("1.5k Reads")
                                    //                                    .font(.system(size: UIScreen.screenHeight/100))
                                    //                                    .fontWeight(.regular)
                                    //                                    .foregroundColor(.white)
                                    //                            }
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 3){
                                        ProfilePictureView(profilePic: globalVM.blogByBlogID[0].profilePic, verified: false, height: UIScreen.screenHeight/30, width: UIScreen.screenHeight/30)
                                        Text(globalVM.blogByBlogID[0].fullName)
                                            .font(.footnote)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        Text("|")
                                            .font(.footnote)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        Text(convertToRelativeDateString(from: globalVM.blogByBlogID[0].dateAdded))
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                            .foregroundColor(.white)
                                        
                                    }
                                }
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/12)
                                .background(.black.opacity(0.5))
                                .cornerRadius(10, corners: .bottomLeft)
                                .cornerRadius(10, corners: .bottomRight)
                                .offset(y: UIScreen.screenHeight/8)
                            }    // Error here
                    } placeholder: {
                        Rectangle()
                            .fill(lightGreyUi)
                            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/3)
                            .shimmering(active: true)
                    }
                    .onAppear {
                        if currentUrl == nil {
                            DispatchQueue.main.async {
                                currentUrl = URL(string: globalVM.blogByBlogID[0].blogImage.replacingOccurrences(of: " ", with: "%20"))
                            }
                        }
                    }
                }
            }
        }
        
    }
}

//struct BlogsDetailFirstHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        BlogsDetailFirstHalfView()
//    }
//}
