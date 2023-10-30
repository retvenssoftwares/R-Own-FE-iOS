//
//  CommunityBusinessListView.swift
//  R-own
//
//  Created by Aman Sharma on 23/05/23.
//

import SwiftUI

struct CommunityBusinessListView: View {
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Businesses in the community")
                ScrollView{
                    VStack(spacing: 5){
                        ForEach(1...20, id: \.self){_ in
                            VendorNBusinessCard()
                        }
                    }
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct CommunityBusinessListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityBusinessListView()
//    }
//}
