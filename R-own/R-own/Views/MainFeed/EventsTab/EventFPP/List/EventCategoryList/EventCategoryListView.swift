//
//  EventCategoryListView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct EventCategoryListView: View {
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        VStack{
            VStack{
                
                BasicNavbarView(navbarTitle: "Category List")
                
                VStack {
                    ScrollView{
                        if globalVM.eventCategoryList.count > 0 {
                            ForEach(0..<globalVM.eventCategoryList.count, id: \.self){ count in
                                EventCategoryTabView( loginData: loginData, globalVM: globalVM, event: globalVM.eventCategoryList[count])
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct EventCategoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventCategoryListView()
//    }
//}
