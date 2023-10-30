//
//  SavedHotelView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct SavedHotelView: View {
    
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        SavedHotelListView(loginData: loginData, globalVM: globalVM)
    }
}

//struct SavedHotelView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedHotelView()
//    }
//}
