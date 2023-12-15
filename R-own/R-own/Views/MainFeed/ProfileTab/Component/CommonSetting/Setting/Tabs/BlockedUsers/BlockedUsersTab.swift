//
//  BlockedUsersTab.swift
//  R-own
//
//  Created by Aman Sharma on 19/08/23.
//

import SwiftUI

struct BlockedUsersTab: View {
    
    @State var blockedUser: BlockedUserListModel
    @State var count: Int
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @Binding var alertUnblocked: Bool
    @Binding var alertError: Bool
    
    
    @StateObject var userPCS = UserCreationService()
    
    var body: some View {
        
        VStack{
            HStack{
                ProfilePictureView(profilePic: blockedUser.profilePic, verified: false, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                Text(blockedUser.fullName)
                    .font(.body)
                    .fontWeight(.bold)
                    .padding(.horizontal, UIScreen.screenWidth/40)
                Spacer()
                Button(action: {
                    Task{
                        let blockedUserID = blockedUser.userID
                        let res = await userPCS.unblockUserAPI(blockedID: blockedUserID, blockerID: loginData.mainUserID)
                        if res == "Success"{
                            globalVM.blockedUserList.remove(at: count)
                            
                            mesiboVM.mesiboSetTPPUser(blockedUser.mesiboAccount.address)
                            mesiboVM.mProfile.block(false)
                            mesiboVM.mProfile.save()
                            
                            alertUnblocked = true
                        } else {
                            alertError = true
                        }
                    }
                }, label: {
                    Text("Unblock")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .padding(.vertical, UIScreen.screenHeight/90)
                        .background(greenUi)
                        .cornerRadius(10)
                })
            }
            .padding(.horizontal, UIScreen.screenWidth/30)
            Divider()
        }
    }
}

//struct BlockedUsersTab_Previews: PreviewProvider {
//    static var previews: some View {
//        BlockedUsersTab()
//    }
//}
