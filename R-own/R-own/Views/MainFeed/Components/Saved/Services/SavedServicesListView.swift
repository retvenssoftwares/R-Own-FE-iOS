//
//  SavedServicesListView.swift
//  R-own
//
//  Created by Aman Sharma on 18/06/23.
//

import SwiftUI

struct SavedServicesListView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var saveService = SaveElemetsIDService()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
        ]
    
    @State var counter: Int = 1
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, spacing: 20) {
                
                if globalVM.getSaveServiceList[0].services.count > 0 {
                    ForEach(0..<globalVM.getSaveServiceList[0].services.count, id: \.self) { id in
                        SavedServicesCardView(service: globalVM.getSaveServiceList[0].services[id])
                            .onAppear{
                                if id == globalVM.getSaveServiceList[0].services.count - 2 {
                                    counter = counter + 1
                                    saveService.getSaveService(globalVM: globalVM, userID: loginData.mainUserID, pageNo: counter)
                                }
                            }
                    }
                }else {
                    Text("No Services to show")
                }
            }
            .padding(.bottom, UIScreen.screenHeight/9)
        }
        .onAppear{
            globalVM.getSaveServiceList = [GetSaveServiceModel(page: 0, pageSize: 0, services: [ServiceSave]())]
            saveService.getSaveService(globalVM: globalVM, userID: loginData.mainUserID, pageNo: 1)
        }
    }
}
//
//struct SavedServicesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedServicesListView()
//    }
//}
