//
//  VendorNBusinessCard.swift
//  R-own
//
//  Created by Aman Sharma on 23/05/23.
//

import SwiftUI

struct VendorNBusinessCard: View {
    var body: some View {
        HStack{
            ProfilePictureView(profilePic: "", verified: false, height: UIScreen.screenHeight/50, width: UIScreen.screenHeight/50)
            
            VStack(alignment: .leading, spacing: 4){
                Text("Paradise Inn")
                    .font(.body)
                    .fontWeight(.regular)
                HStack(spacing: 2){
                    Image(systemName: "location.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                    Text("Indore")
                        .font(.body)
                }
                Spacer()
                RatingStarCard(ratingNumber: 3, cardSize: UIScreen.screenHeight/100)
            }
        }
        .frame(width: UIScreen.screenWidth/1.4, height: UIScreen.screenHeight/30)
        .background(.white)
        .cornerRadius(15)
        .padding(.horizontal, UIScreen.screenWidth/40)
    }
}

//struct VendorNBusinessCard_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorNBusinessCard()
//    }
//}
