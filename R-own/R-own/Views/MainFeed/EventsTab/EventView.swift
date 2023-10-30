//
//  EventView.swift
//  R-own
//
//  Created by Aman Sharma on 11/04/23.
//

import SwiftUI

struct EventView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var eventVM: EventViewModel
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        ZStack {
            VStack{
//                if loginData.mainUserRole == "Business Vendor / Freelancer" {
//                    EventFPPView()
//                } else {
//                    EventTPPView()
//                }
                EventFPPView(loginData: loginData, eventVM: eventVM, globalVM: globalVM)
            }
        }
    }
}

//struct EventView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventView()
//    }
//}
