//
//  BlockedUsersListView.swift
//  R-own
//
//  Created by Aman Sharma on 27/07/23.
//

import SwiftUI
import AlertToast
import mesibo

struct BlockedUsersListView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var userPCS = UserCreationService()
    
    @State var alertUnblocked: Bool = false
    @State var alertError: Bool = false
    
    @State var loadingData: Bool = false
    @StateObject var mesiboVM: MesiboViewModel
    
    var body: some View {
        VStack{
            BasicNavbarView(navbarTitle: "Blocked Users")
            if loadingData{
                ScrollView{
                    VStack{
                        if globalVM.blockedUserList.count > 0{
                            ForEach(0..<globalVM.blockedUserList.count, id: \.self){ count in
                                BlockedUsersTab(blockedUser: globalVM.blockedUserList[count], count: count, loginData: loginData, globalVM: globalVM, mesiboVM: mesiboVM, alertUnblocked: $alertUnblocked, alertError: $alertError)
                            }
                        } else {
                            Text("You haven't blocked anyone yet")
                        }
                        Spacer()
                    }
                }
            } else {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
        .toast(isPresenting: $alertError, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try Again")
        }
        .toast(isPresenting: $alertUnblocked, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("checkmark.square.fill", greenUi), title: "Unblocked")
        }
        .onAppear{
            globalVM.blockedUserList = [BlockedUserListModel]()
            loadingData = false
            Task{
                let res = await  userPCS.getBlockedUsers(userID: loginData.mainUserID, globalVM: globalVM)
                if res == "Success"{
                    loadingData = true
                } else {
                    loadingData = true
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct BlockedUsersListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BlockedUsersListView()
//    }
//}
