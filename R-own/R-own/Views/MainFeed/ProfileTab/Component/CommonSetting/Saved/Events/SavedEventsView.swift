//
//  SavedEventsView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct SavedEventsView: View {
    
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        SavedEventsListView(loginData: loginData, globalVM: globalVM)
    }
}

//struct SavedEventsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedEventsView()
//    }
//}
