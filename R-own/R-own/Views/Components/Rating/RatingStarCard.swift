//
//  RatingStarCard.swift
//  R-own
//
//  Created by Aman Sharma on 23/05/23.
//

import SwiftUI

struct RatingStarCard: View {
    
    @State var ratingNumber: Int
    
    @State var cardSize: CGFloat
    
    var body: some View {
        HStack(spacing: 3){
            HStack(spacing: 3){
                ForEach(0..<ratingNumber, id: \.self){_ in
                    Image("HotelStarFilledIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: cardSize, height: cardSize)
                }
            }
            HStack(spacing: 3){
                ForEach(1...(5 - ratingNumber), id: \.self){_ in
                    Image("HotelStarEmptyIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: cardSize, height: cardSize)
                }
            }
//            Text("\(ratingNumber) Star")
//                .font(.system(size: (cardSize * 1.3)))
//                .fontWeight(.thin)
        }
    }
}

//struct RatingStarCard_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingStarCard()
//    }
//}
