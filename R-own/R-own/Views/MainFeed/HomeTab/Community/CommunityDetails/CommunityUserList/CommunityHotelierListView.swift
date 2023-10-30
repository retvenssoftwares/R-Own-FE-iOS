//
//  CommunityHotelierListView.swift
//  R-own
//
//  Created by Aman Sharma on 23/05/23.
//

import SwiftUI

struct CommunityHotelierListView: View {
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Hoteliers in the community")
                ScrollView{
                    VStack(spacing: 5){
                        ForEach(1...20, id: \.self){_ in
                            HoteliersNOthersCard()
                        }
                    }
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct CommunityHotelierListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityHotelierListView()
//    }
//}
