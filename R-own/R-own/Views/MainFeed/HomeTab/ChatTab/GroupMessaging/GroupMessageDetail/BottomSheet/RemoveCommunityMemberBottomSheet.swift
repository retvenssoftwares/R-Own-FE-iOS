//
//  RemoveCommunityMemberBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 28/06/23.
//

import SwiftUI

struct RemoveCommunityMemberBottomSheet: View {
    
    @StateObject var communityVM: CommunityViewModel
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @FocusState private var isKeyboardShowing: Bool
    
    @StateObject var communityService = CommunityService()
    @State var totalUsers: [MesiboGroupUser]
    @State var offset : CGFloat = 0
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @State var groupID: String
    
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            
                            Text("Do you really want to remove this member ?")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            HStack{
                                Button(action: {
                                    Task {
                                        loginData.showLoader = true
                                        let res = await communityService.removeCommunityMember(groupID: communityVM.selectedGroupID, userID: communityVM.selectedGroupUserID)
                                        if res == "Success" {
                                            let res = await communityService.getCommunityDetailByGroupID(globalVM: globalVM, groupID: groupID)
                                            if res == "Success"{
                                                loginData.showLoader = false
                                            }
                                            communityVM.showAdminMemberSettingBottomSheet = false
                                            communityVM.showRemoveMemberBottomSheet = false
                                        }
                                    }
                                    
                                }, label: {
                                    Text("YES, I am sure")
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                        .padding(.vertical, UIScreen.screenHeight/60)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 1)
                                        }
                                })
                                
                                Button(action: {
                                    communityVM.showRemoveMemberBottomSheet.toggle()
                                }, label: {
                                    Text("No, Keep this member")
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                        .padding(.vertical, UIScreen.screenHeight/60)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 1)
                                        }
                                })
                            }
                            
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/3)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .offset(y: communityVM.showRemoveMemberBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(communityVM.showRemoveMemberBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        communityVM.showRemoveMemberBottomSheet.toggle()
                    }
                }
            )
    }
}

//struct RemoveCommunityMemberBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        RemoveCommunityMemberBottomSheet()
//    }
//}
