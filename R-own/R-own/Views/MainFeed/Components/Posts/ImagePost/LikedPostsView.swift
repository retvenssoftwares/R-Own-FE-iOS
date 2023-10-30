//
//  LikedPostsView.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import SwiftUI

struct LikedPostsView: View {
    var body: some View {
        VStack{
            BasicNavbarView(navbarTitle: "Likes")
            ScrollView{
                VStack{
                    ForEach(1...30, id: \.self){_ in
                        
                    }
                }
            }
        }
    }
}

//struct LikedPostsView_Previews: PreviewProvider {
//    static var previews: some View {
//        LikedPostsView()
//    }
//}
