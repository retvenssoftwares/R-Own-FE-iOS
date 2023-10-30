//
//  ExploreEventsView.swift
//  R-own
//
//  Created by Aman Sharma on 29/04/23.
//

import SwiftUI

struct ExploreEventsView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var exploreService = ExploreService()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
        ]
    @State var counter: Int = 1
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, spacing: 20) {
                
                if globalVM.exploreEventList.count == 1 {
                    ForEach(0..<globalVM.exploreEventList[0].events.count, id: \.self) { id in
                        ExploreEventsCard(event: globalVM.exploreEventList[0].events[id])
                            .onAppear{
                                if id == globalVM.exploreEventList[0].events.count - 2 {
                                    counter = counter + 1
                                    exploreService.getExploreEvent(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(counter))
                                }
                            }
                    }
                }else {
                    Text("No Events to show")
                }
            }
            .padding(.bottom, UIScreen.screenHeight/9)
        }
        .onAppear{
            globalVM.exploreEventList = [ExploreEventModel(events: [ExploreEvent]())]
            exploreService.getExploreEvent(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: "1")
            
        }
    }
}

//struct ExploreEventsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreEventsView()
//    }
//}
