//
//  AllEventsFPPView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI

struct AllEventsFPPView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var eventVM: EventViewModel
    
    @State var navigateToAllEventView: Bool = false
    
    @StateObject var eventService = UserEventService()
    
    var body: some View {
        NavigationStack{
            VStack{
                
                //nav
                BasicNavbarView(navbarTitle: "All events posted")
                
                //for loop for cards
                ScrollView {
                    if globalVM.eventInfo.count > 0 {
                        ForEach(0..<globalVM.eventInfo.count, id: \.self) { count in
                            AllEventFPPCardView(loginData: loginData, globalVM: globalVM, eventVM: eventVM, event: globalVM.eventInfo[count])
                        }
                    } else {
                        Text("You havent posted any event yet")
                    }
                }
            }
        }
        .onAppear{
            eventService.getEventInfoByUserID(globalVM: globalVM, loginData: loginData, userID: loginData.mainUserID)
        }
        .navigationBarBackButtonHidden()
    }
}

//struct AllEventsFPPView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllEventsFPPView()
//    }
//}
