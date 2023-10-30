//
//  CommonProfileFPPServicesTab.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import SwiftUI

struct CommonProfileFPPServicesTab: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var role: String
    @State var mainUser: Bool
    @State var userID: String
    @StateObject var vendorProfileService = VendorProfileService()
    
    
    var body: some View {
        VStack{
            ServiceProfileListView(loginData: loginData, globalVM: globalVM, role: role, mainUser: mainUser)
        }
        .onAppear{
            vendorProfileService.getVendorServicesByID(loginData: loginData, globalVM: globalVM, userID: userID)
        }
    }
}

//struct CommonProfileFPPServicesTab_Previews: PreviewProvider {
//    static var previews: some View {
//        CommonProfileFPPServicesTab()
//    }
//}
