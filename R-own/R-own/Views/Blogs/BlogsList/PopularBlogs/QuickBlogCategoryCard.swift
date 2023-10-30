//
//  QuickBlogCategoryCard.swift
//  R-own
//
//  Created by Aman Sharma on 26/05/23.
//

import SwiftUI

struct QuickBlogCategoryCard: View {
    
    @State var categoryName: String
    
    @Binding var selected: String
    
    var body: some View {
        Button(action: {
            selected = categoryName
        }, label: {
            Text(categoryName)
                .font(.body)
                .foregroundColor(selected == categoryName ? .white : .black)
                .padding(7)
                .background(selected == categoryName ? .black : .white)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(.black, lineWidth: 2))
                .padding(.horizontal, 5)
        })
    }
}

//struct QuickBlogCategoryCard_Previews: PreviewProvider {
//    static var previews: some View {
//        QuickBlogCategoryCard()
//    }
//}
