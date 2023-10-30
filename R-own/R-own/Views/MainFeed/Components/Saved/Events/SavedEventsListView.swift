//
//  SavedEventsListView.swift
//  R-own
//
//  Created by Aman Sharma on 18/06/23.
//

import SwiftUI

struct SavedEventsListView: View {
    
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
            LazyVGrid(columns: columns, spacing: 20) {
                if globalVM.getSaveEventList[0].events.count > 0 {
                    ForEach(0..<globalVM.getSaveEventList[0].events.count, id: \.self) { count in
                        SavedEventsCardView(event: globalVM.getSaveEventList[0].events[count])
                            .padding()
                            .onAppear{
                                if count == globalVM.getSaveEventList[0].events.count - 2 {
                                    counter = counter + 1
                                    saveService.getSaveEvent(globalVM: globalVM, userID: loginData.mainUserID, pageNo: counter)
                                }
                            }
                        
                    }
                } else {
                    Text("No events to show")
                }
            }
            .padding(.horizontal)
        }
        .onAppear{
            globalVM.getSaveEventList = [GetSaveEventModel(page: 0, pageSize: 0, events: [EventSave]())]
            saveService.getSaveEvent(globalVM: globalVM, userID: loginData.mainUserID, pageNo: 1)
        }
    }
}

//struct SavedEventsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedEventsListView()
//    }
//}
