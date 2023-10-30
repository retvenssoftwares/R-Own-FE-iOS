//
//  ExploreHotelsView.swift
//  R-own
//
//  Created by Aman Sharma on 29/04/23.
//

import SwiftUI

struct ExploreHotelsView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var exploreVM: ExploreViewModel
    @StateObject var exploreService = ExploreService()
    
    var body: some View {
        VStack{
            ExploreHotelsListView(loginData: loginData, globalVM: globalVM,exploreVM: exploreVM)
        }
        .onAppear{
            globalVM.exploreSearchHotelList = [ExploreHotelModel(page: 0, pageSize: 0, posts: [ExploreHotelPost]())]
            globalVM.exploreHotelList = [ExploreHotelModel(page: 0, pageSize: 0, posts: [ExploreHotelPost]())]
            exploreService.getExploreHotel(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: "1")
        }
    }
}

//struct ExploreHotelsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreHotelsView()
//    }
//}
