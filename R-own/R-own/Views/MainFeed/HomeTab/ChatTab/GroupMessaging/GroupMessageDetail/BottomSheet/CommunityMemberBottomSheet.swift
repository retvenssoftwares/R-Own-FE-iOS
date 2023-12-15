//
//  MemberBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 28/06/23.
//

import SwiftUI

struct CommunityMemberBottomSheet: View {
    
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var communityVM: CommunityViewModel
    
    @StateObject var communityService = CommunityService()
    
    
    @State var totalUsers: [MesiboGroupUser]
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var navigateToMessageView: Bool = false
    @State var navigateTOProfileView: Bool = false
    
    @State var offset : CGFloat = 0
    @State var groupID: String
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                    
                    VStack(spacing: 20){
                        
                        VStack{
                            Button(action: {
                                print("removing member with userid \(communityVM.selectedGroupUserID)")
                                communityVM.showRemoveMemberBottomSheet = true
                            }, label: {
                                Text("Remove")
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
                            
//                            Button(action: {
//                                navigateToMessageView.toggle()
//                            }, label: {
//                                Text("MESSAGE")
//                                    .font(.system(size: UIScreen.screenHeight/60))
//                                    .fontWeight(.thin)
//                                    .padding(.horizontal, UIScreen.screenWidth/30)
//                                    .padding(.vertical, UIScreen.screenHeight/60)
//                                    .overlay{
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .stroke(Color.black, lineWidth: 1)
//                                    }
//                            })
//                            .navigationDestination(isPresented: $navigateToMessageView, destination: {
//                                MessageView(loginData: loginData, mesiboAddress: communityVM.selectedGRoupUserAddress, mesiboData: mesiboVM, profileVM: profileVM, globalVM: globalVM)
//                            })
                            
                            
                            Button(action: {
                                navigateTOProfileView = true
                            }, label: {
                                Text("View Profile")
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
                            .navigationDestination(isPresented: $navigateTOProfileView, destination: {
                                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: communityVM.selectedGroupUserRole, mainUser: false, userID: communityVM.selectedGroupUserID)
                            })
                            NavigationLink(isActive: $navigateTOProfileView, destination: {
                                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: communityVM.selectedGroupUserRole, mainUser: false, userID: communityVM.selectedGroupUserID)
                            }, label: {
                                Text("")
                            })
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.bottom,edges?.bottom)
                    .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/4)
                    .onDisappear{
                        communityVM.showAdminMemberSettingBottomSheet = false
                    }
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .offset(y: communityVM.showAdminMemberSettingBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(communityVM.showAdminMemberSettingBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        communityVM.showAdminMemberSettingBottomSheet.toggle()
                    }
                }
            )
            RemoveCommunityMemberBottomSheet(communityVM: communityVM, totalUsers: totalUsers, globalVM: globalVM, loginData: loginData, groupID: groupID)
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .onAppear{
            navigateTOProfileView = false
        }
    }
}

//struct CommunityMemberBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberBottomSheet()
//    }
//}
