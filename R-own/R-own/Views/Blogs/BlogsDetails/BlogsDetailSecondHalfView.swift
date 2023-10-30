//
//  BlogsDetailSecondHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct BlogsDetailSecondHalfView: View {
    
    @StateObject var globalVM: GlobalViewModel
    
    
    var body: some View {
        
        if globalVM.blogByBlogID.count > 0 {
            
            Text(globalVM.blogByBlogID[0].blogTitle)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, UIScreen.screenWidth/40)
                .padding(.vertical, UIScreen.screenHeight/50)
            
        }
        if globalVM.blogByBlogID.count > 0 {
            Text(globalVM.blogByBlogID[0].blogContent)
                .font(.body)
                .fontWeight(.thin)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, UIScreen.screenWidth/40)
                .padding(.bottom, UIScreen.screenHeight/40)
        }
    }
}

//struct BlogsDetailSecondHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        BlogsDetailSecondHalfView()
//    }
//}
