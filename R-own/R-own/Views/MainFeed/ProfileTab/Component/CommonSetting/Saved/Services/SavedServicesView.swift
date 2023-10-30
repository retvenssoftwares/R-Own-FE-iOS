//
//  SavedServicesView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct SavedServicesView: View {
    
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        SavedServicesListView(loginData: loginData, globalVM: globalVM)
    }
}

//struct SavedServicesView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedServicesView()
//    }
//}
