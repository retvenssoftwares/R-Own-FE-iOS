//
//  TPPUserSettingBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 03/07/23.
//

import SwiftUI
import AlertToast
import mesibo

struct TPPUserSettingBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @State var userRole: String
    @StateObject var globalVM: GlobalViewModel
    
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    @State var navigateToAboutPage: Bool = false
    @State var navigateToReportPage: Bool = false
    
    
    @State var alertUserBlocked: Bool = false
    @State var alertUserNotBlocked: Bool = false
    
    @State var blockUserTOggle: Bool = false
    @StateObject var profileService = ProfileService()
    @StateObject var userPCS = UserCreationService()
    
    @StateObject var mesiboVM: MesiboViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                    VStack(alignment: .leading){
                        VStack(alignment: .leading){
                            Button(action: {
                                navigateToAboutPage.toggle()
                                
                            }, label: {
                                
                                HStack{
                                    Image("SettingIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                    Text("About")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                }
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
                            })
                            .navigationDestination(isPresented: $navigateToAboutPage, destination: {
                                ProfileAboutView(globalVM: globalVM)
                            })
                            Divider()
                        }
                        VStack(alignment: .leading){
                            Button(action: {
                                
                                    navigateToReportPage.toggle()
                            }, label: {
                                
                                HStack{
                                    Image("SettingIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                    Text("Report")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                }
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
                            })
                            .navigationDestination(isPresented: $navigateToReportPage, destination: {
                                ProfileReportView(loginData: loginData, globalVM: globalVM)
                            })
                            Divider()
                        }
//                        VStack(alignment: .leading){
//                            HStack{
//                                Image("SettingIcon")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
//                                Text("Sharw QR Code")
//                                    .font(.system(size: UIScreen.screenHeight/80))
//                                    .fontWeight(.regular)
//                            }
//                            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
//                            Divider()
//                        }
                        VStack(alignment: .leading){
                            Button(action: {
                                    loginData.openShareToConnectionBottomSheet.toggle()
                            }, label: {
                                
                                HStack{
                                    Image("SettingIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                    Text("Share Profile via message")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                }
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
                            })
                            .sheet(isPresented: $loginData.openShareToConnectionBottomSheet) {
                                SendProfileToConnectionBottomSheet(loginData: loginData, globalVM: globalVM, userRole: userRole)
                            }
                            Divider()
                        }
//                        VStack(alignment: .leading){
//                            HStack{
//                                Image("SettingIcon")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
//                                Text("Share Profile via...")
//                                    .font(.system(size: UIScreen.screenHeight/80))
//                                    .fontWeight(.regular)
//                            }
//                            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
//                            Divider()
//                        }
//                        VStack(alignment: .leading){
//                            HStack{
//                                Image("SettingIcon")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
//                                Text("Copy Profile URL")
//                                    .font(.system(size: UIScreen.screenHeight/80))
//                                    .fontWeight(.regular)
//                            }
//                            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
//                            Divider()
//                        }
                        
                        VStack(alignment: .leading){
                            Button(action: {
                                blockUserTOggle = true
                            }, label: {
                                
                                HStack{
                                    Image("SettingIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                    Text("Block User")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                }
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
                            })
                            .sheet(isPresented: $blockUserTOggle) {
                                VStack{
                                    Text("Do you really want to block this user?")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .padding(.vertical, UIScreen.screenHeight/60)
                                    
                                    Button(action: {
                                        blockUserTOggle = false
                                        Task{
                                            if userRole == "Normal User" || userRole == "Hotelier"{
                                                let res = await userPCS.blockUserAPI(blockedID: globalVM.getNormalProfileHeader.data.profile.userID, blockerID: loginData.mainUserID)
                                                if res == "Success"{
                                                    globalVM.getNormalProfileHeader.data.connectionStatus = "Blocked"
                                                    
                                                    mesiboVM.mesiboSetTPPUser(globalVM.getNormalProfileHeader.data.profile.mesiboAccount[0].address)
                                                    mesiboVM.mProfile.block(true)
                                                    mesiboVM.mProfile.save()
                                                
                                                    alertUserBlocked = true
                                                    
                                                } else {
                                                    alertUserNotBlocked = true
                                                }
                                            } else if userRole == "Business Vendor / Freelancer" {
                                                let res = await userPCS.blockUserAPI(blockedID: globalVM.viewingVendorUserID, blockerID: loginData.mainUserID)
                                                if res == "Success"{
                                                    globalVM.getVendorProfileHeader.connectionStatus = "Blocked"
                                                    
                                                    mesiboVM.mesiboSetTPPUser(globalVM.getVendorProfileHeader.roleDetails.mesiboAccount[0].address)
                                                    mesiboVM.mProfile.block(true)
                                                    mesiboVM.mProfile.save()
                                                    
                                                    alertUserBlocked = true
                                                } else {
                                                    alertUserNotBlocked = true
                                                }
                                            } else if userRole == "Hotel Owner" {
                                                let res = await userPCS.blockUserAPI(blockedID: globalVM.viewingHotelOwnerUserID, blockerID: loginData.mainUserID)
                                                if res == "Success"{
                                                    globalVM.getHotelOwnerProfileHeader.connectionStatus = "Blocked"
                                                    
                                                    mesiboVM.mesiboSetTPPUser(globalVM.getHotelOwnerProfileHeader.profiledata.mesiboAccount[0].address)
                                                    mesiboVM.mProfile.block(true)
                                                    mesiboVM.mProfile.save()
                                                
                                                    alertUserBlocked = true
                                                } else {
                                                    alertUserNotBlocked = true
                                                }
                                            }
                                        }
                                    }, label: {
                                        Text("Yes")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                            .frame(width: UIScreen.screenWidth/2)
                                            .padding(.vertical, UIScreen.screenHeight/100)
                                            .background(greenUi)
                                            .padding(.vertical, UIScreen.screenHeight/70)
                                    })
                                    
                                    Button(action: {
                                        blockUserTOggle = false
                                    }, label: {
                                        Text("No")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                            .frame(width: UIScreen.screenWidth/2)
                                            .padding(.vertical, UIScreen.screenHeight/100)
                                            .background(greenUi)
                                            .padding(.vertical, UIScreen.screenHeight/70)
                                    })
                                }
                            }
                            Divider()
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
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: loginData.nTPPProfileSettingBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .toast(isPresenting: $alertUserNotBlocked, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try Again")
            }
            .toast(isPresenting: $alertUserBlocked, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("checkmark.square.fill", greenUi), title: "Blocked")
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.nTPPProfileSettingBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.nTPPProfileSettingBottomSheet.toggle()
                    }
                }
            )
        }
    }
    func onChanged(value: DragGesture.Value){
        if value.translation.height > 0{
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value){
        if value.translation.height > 0{
            withAnimation(Animation.easeInOut(duration: 0.2)){
                
                //onChecking
                
                let height = UIScreen.screenHeight/3
                
                if value.translation.height > height/1.5 {
                    loginData.nTPPProfileSettingBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct TPPUserSettingBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        TPPUserSettingBottomSheet()
//    }
//}
