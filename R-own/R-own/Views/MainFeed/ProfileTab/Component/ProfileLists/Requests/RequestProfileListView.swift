//
//  RequestListView.swift
//  R-own
//
//  Created by Aman Sharma on 16/05/23.
//

import SwiftUI

struct RequestProfileListView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var mainUser: Bool
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var profileService = ProfileService()
    @State var isDataLoading: Bool = false
    
    var body: some View {
        VStack{
            BasicNavbarView(navbarTitle: "My Requests")
            ScrollView{
                if isDataLoading {
                    VStack{
                        if globalVM.getRequestList.conns.count > 0{
                            ForEach(0..<globalVM.getRequestList.conns.count, id: \.self){ id in
                                RequestListTabView(globalVM: globalVM, requestedConnection: globalVM.getRequestList.conns[id], loginData: loginData, mainUser: mainUser, profileVM: profileVM, mesiboVM: mesiboVM, isDataLoading: $isDataLoading)
                                Divider()
                            }
                        } else {
                            Text("There are no requests to show")
                        }
                    }
                } else {
                    ProgressView("Loading...")
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            Task{
                isDataLoading = false
                globalVM.getRequestList = ProfileRequestListModel(conns: [Conn342]())
                let response = await profileService.getRequestsList(globalVM: globalVM, userID: loginData.mainUserID)
                if response == "Success" {
                    isDataLoading = true
                } else {
                    let response = await profileService.getRequestsList(globalVM: globalVM, userID: loginData.mainUserID)
                    if response == "Success" {
                        isDataLoading = true
                    } else {
                        isDataLoading = true
                    }
                }
            }
        }
    }
}

//struct RequestListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestListView()
//    }
//}
