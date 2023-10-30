//
//  EventFPPView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI

struct EventFPPView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var eventVM: EventViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var eventService = UserEventService()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack{
                    EventFPPFirstHalfView(loginData: loginData, eventVM: eventVM)
                    EventFPPSecondHalfView(loginData: loginData, eventVM: eventVM, globalVM: globalVM)
                        .padding(.leading, UIScreen.screenWidth/30)
                    EventFPPThirdHalfView(loginData: loginData, eventVM: eventVM, globalVM: globalVM)
                        .padding(.horizontal, UIScreen.screenWidth/60)
                    EventFPPFourthHalfView(loginData: loginData, globalVM: globalVM)
                        .padding(.horizontal, UIScreen.screenWidth/60)
                    EventFPPFifthHalfView(globalVM: globalVM, loginData: loginData)
                        .padding(.horizontal, UIScreen.screenWidth/60)
                }
                .padding(.leading, UIScreen.screenWidth/30)
            }
//            if loginData.mainUserRole == "Hotel Owner" {
                Button(action: {
                    eventVM.showAddEventBottomSheet.toggle()
                }, label: {
                    Circle()
                        .fill(jobsDarkBlue)
                        .frame(width: UIScreen.screenHeight/18, height: UIScreen.screenHeight/18)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                        .overlay{
                            Text("Add \n Event")
                                .font(.system(size: UIScreen.screenHeight/80))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                })
                .offset(x: UIScreen.screenHeight/3.2, y: UIScreen.screenWidth/2.3)
//            }
        }
        .onAppear{
            eventService.getEventCategory(globalVM: globalVM, loginData: loginData, userID: "")
            eventService.getNearestConcertsList(globalVM: globalVM, loginData: loginData, userID: loginData.mainUserID)
            eventService.getOngoingEvent(globalVM: globalVM, loginData: loginData, userID: loginData.mainUserID)
        }
    }
}

//struct EventFPPView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventFPPView()
//    }
//}
