//
//  BlogCategoryCard.swift
//  R-own
//
//  Created by Aman Sharma on 26/05/23.
//

import SwiftUI

struct BlogCategoryCard: View {
    
    @State var blogCategory: BlogsCategoryModel
    
    var body: some View {
        VStack{
            HStack{
                if blogCategory.image ?? "" != "" {
                    ProfilePictureView(profilePic: blogCategory.image ?? "cfefve", verified: false, height: UIScreen.screenHeight/25, width: UIScreen.screenHeight/25)
                        .padding(.horizontal, UIScreen.screenWidth/40)
                } else {
                    Circle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenHeight/25, height: UIScreen.screenHeight/25)
                        .padding(.horizontal, UIScreen.screenWidth/40)
                }
                VStack(alignment: .leading, spacing: 5){
                    
                    Text(blogCategory.categoryName)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("\(blogCategory.blogCount) Blogs")
                        .font(.body)
                        .fontWeight(.light)
                        .foregroundColor(.black)
                    
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                    .padding(3)
            }
            .padding(.vertical, UIScreen.screenHeight/50)
            .padding(.horizontal, UIScreen.screenWidth/50)
        }
    }
}

//struct BlogCategoryCard_Previews: PreviewProvider {
//    static var previews: some View {
//        BlogCategoryCard()
//    }
//}
