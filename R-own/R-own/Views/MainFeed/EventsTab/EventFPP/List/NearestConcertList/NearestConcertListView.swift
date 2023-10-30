//
//  NearestConcertListView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct NearestConcertListView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            BasicNavbarView(navbarTitle: "Events Near You")
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    if globalVM.nearestConcertList.count > 0 {
                        ForEach(0..<globalVM.nearestConcertList.count, id: \.self) { count in
                            NearestConcertCard(loginData: loginData, globalVM: globalVM, event: globalVM.nearestConcertList[count])
                                .padding(.vertical, UIScreen.screenHeight/60)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct NearestConcertListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NearestConcertListView()
//    }
//}
