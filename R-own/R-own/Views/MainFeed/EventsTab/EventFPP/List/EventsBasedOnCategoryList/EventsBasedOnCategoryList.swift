//
//  EventsBasedOnCategoryList.swift
//  R-own
//
//  Created by Aman Sharma on 31/05/23.
//

import SwiftUI

struct EventsBasedOnCategoryList: View {
    
    
    @State var categoryID: String
    @State var categoryName: String
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            BasicNavbarView(navbarTitle: categoryName)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    if globalVM.eventsByCategory.count > 0 {
                        ForEach(0..<globalVM.eventsByCategory.count, id: \.self) { count in
                            NearestConcertCard(loginData: loginData, globalVM: globalVM, event: globalVM.eventsByCategory[count])
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

//struct EventsBasedOnCategoryList_Previews: PreviewProvider {
//    static var previews: some View {
//        EventsBasedOnCategoryList()
//    }
//}
