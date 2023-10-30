//
//  SavedHotelListView.swift
//  R-own
//
//  Created by Aman Sharma on 18/06/23.
//

import SwiftUI

struct SavedHotelListView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var saveService = SaveElemetsIDService()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var counter: Int = 1
    
    var body: some View {
        ScrollView {
            if globalVM.getSaveHotelList[0].hotels.count > 0 {
                LazyVGrid(columns: columns, spacing: 10) {
                    
                    ForEach(0..<globalVM.getSaveHotelList[0].hotels.count, id: \.self) { id in
                        SavedHotelCardView(hotel: globalVM.getSaveHotelList[0].hotels[id], globalVM: globalVM)
                            .onAppear{
                                if id == globalVM.exploreHotelList[0].posts.count - 2 {
                                    counter = counter + 1
                                    saveService.getSaveHotel(globalVM: globalVM, userID: loginData.mainUserID, pageNo: counter)
                                }
                            }
                            .padding()
                    }
                }
                .padding(.bottom, UIScreen.screenHeight/9)
                .padding(.horizontal, UIScreen.screenWidth/30)
            } else {
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Image("NothingToSeeHereIllustration")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .onAppear{
            globalVM.getSaveHotelList = [GetSaveHotelModel(page: 0, pageSize: 0, hotels: [HotelSave]())]
            saveService.getSaveHotel(globalVM: globalVM, userID: loginData.mainUserID, pageNo: 1)
        }
    }
}

//struct SavedHotelListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedHotelListView()
//    }
//}
