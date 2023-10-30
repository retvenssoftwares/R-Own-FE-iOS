//
//  NormalProfileMediaTabView.swift
//  R-own
//
//  Created by Aman Sharma on 12/05/23.
//

import SwiftUI

struct NormalProfileMediaTabView: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(1...20, id: \.self) { item in
                    NormalProfileImageView()
                }
            }
            .padding(.horizontal)
        }
        .background(profilePostBG)
    }
}

//struct NormalProfileMediaTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileMediaTabView()
//    }
//}
