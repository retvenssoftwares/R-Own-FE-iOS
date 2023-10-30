//
//  CommuityOthersListView.swift
//  R-own
//
//  Created by Aman Sharma on 23/05/23.
//

import SwiftUI

struct CommuityOthersListView: View {
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Others in the community")
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

//struct CommuityOthersListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommuityOthersListView()
//    }
//}
