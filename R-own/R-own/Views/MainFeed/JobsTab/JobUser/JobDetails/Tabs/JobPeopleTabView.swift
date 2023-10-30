//
//  JobPeopleTabView.swift
//  R-own
//
//  Created by Aman Sharma on 09/05/23.
//

import SwiftUI

struct JobPeopleTabView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        ScrollView {
            VStack {
                PeopleSubTabView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, userID: globalVM.jobDetails.userID, user: globalVM.getHotelOwnerProfileHeader, mesiboVM: mesiboVM)
//                ForEach(0...10, id: \.self){_ in
//                    PeopleSubTabView()
//                }
            }
            .padding(.horizontal, UIScreen.screenWidth/7)
        }
        .onAppear{
            Task{
                let res = await profileService.getHotelOwnerProfileHeader(globalVM: globalVM, userID: globalVM.jobDetails.userID, connectionUserID: globalVM.jobDetails.userID)
            }
        }
    }
}

//struct JobPeopleTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobPeopleTabView()
//    }
//}
