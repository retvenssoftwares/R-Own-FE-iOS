//
//  HotelOwnerJobsTabView.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import SwiftUI

struct HotelOwnerEventsTabView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @State var userID: String
    @State var role: String
    @State var mainUser: Bool
    @StateObject var eventService = UserEventService()
    
    var body: some View {
        VStack{
            ScrollView{
                if globalVM.eventInfo.count > 0 {
                    VStack{
                        ForEach(0..<globalVM.eventInfo.count){ count in
                            EventProfilePostView(event: globalVM.eventInfo[count], mainUser: true)
                        }
                        Spacer(minLength: UIScreen.screenHeight/10)
                    }
                } else {
                    if mainUser {
                        Image("NoPostScreen")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                            .overlay{
                                Text("You have not posted any events yet")
                                    .font(.body)
                                    .frame(width: UIScreen.screenWidth/4)
                                    .fontWeight(.bold)
                                    .foregroundColor(greenUi)
                                    .multilineTextAlignment(.leading)
                                    .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                            }
                    } else {
                            if role == "Hotelier" {
                                Image("NoPostScreen")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                        .overlay{
                                            Text("\(globalVM.getNormalProfileHeader.data.profile.fullName) have not posted any events yet")
                                                .font(.body)
                                                .frame(width: UIScreen.screenWidth/4)
                                                .fontWeight(.bold)
                                                .foregroundColor(greenUi)
                                                .multilineTextAlignment(.leading)
                                                .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                        }
                            } else if role == "Business Vendor / Freelancer" {
                                Image("NoPostScreen")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                        .overlay{
                                            Text("\(globalVM.getVendorProfileHeader.roleDetails.fullName) have not posted any events yet")
                                                .font(.body)
                                                .frame(width: UIScreen.screenWidth/4)
                                                .fontWeight(.bold)
                                                .foregroundColor(greenUi)
                                                .multilineTextAlignment(.leading)
                                                .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                        }
                            } else if role == "Hotel Owner" {
                                Image("NoPostScreen")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                        .overlay{
                                            Text("\(globalVM.getHotelOwnerProfileHeader.profiledata.fullName) have not posted any events yet")
                                                .font(.body)
                                                .frame(width: UIScreen.screenWidth/4)
                                                .fontWeight(.bold)
                                                .foregroundColor(greenUi)
                                                .multilineTextAlignment(.leading)
                                                .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                        }
                            } else {
                                Image("NoPostScreen")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                        .overlay{
                                            Text("\(globalVM.getNormalProfileHeader.data.profile.fullName) have not posted any events yet")
                                                .font(.body)
                                                .frame(width: UIScreen.screenWidth/4)
                                                .fontWeight(.bold)
                                                .foregroundColor(greenUi)
                                                .multilineTextAlignment(.leading)
                                                .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                        }
                            }
                    }
                }
            }
        }
        .onAppear{
            eventService.getEventInfoByUserID(globalVM: globalVM, loginData: loginData, userID: userID)
        }
    }
    
}

//struct HotelOwnerJobsTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelOwnerJobsTabView()
//    }
//}
