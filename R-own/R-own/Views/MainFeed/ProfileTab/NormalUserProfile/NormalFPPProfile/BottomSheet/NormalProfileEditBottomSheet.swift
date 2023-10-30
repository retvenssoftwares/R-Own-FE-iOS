//
//  NormalProfileEditBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI

struct NormalProfileEditBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var mesiboVM: MesiboViewModel
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    
    @State var navigateToRolenProfileChange: Bool = false
    @State var navigateToSetting: Bool = false
    @State var navigateToEditProfile: Bool = false
    @State var navigateToSaved: Bool = false
    @State var navigateToDiscoverPeople: Bool = false
    
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
                                
                                    navigateToSetting.toggle()
                            }, label: {
                                
                                HStack{
                                    Image("SettingIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                    Text("Setting")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding(.leading, UIScreen.screenWidth/20)
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
                            })
                            .navigationDestination(isPresented: $navigateToSetting, destination: {
                                ProfileSettingView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                            })
                            Divider()
                        }
                        VStack(alignment: .leading){
                            Button(action: {
                                
                                    navigateToEditProfile.toggle()
                            }, label: {
                                
                                HStack{
                                    Image("PostDiscardEditing")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                    Text("Edit Profile")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding(.leading, UIScreen.screenWidth/20)
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
                            })
                            .navigationDestination(isPresented: $navigateToEditProfile, destination: {
                                EditFPPProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
                            })
                            Divider()
                        }
                        VStack(alignment: .leading){
                            Button(action: {
                                print("opening saved")
                                navigateToSaved.toggle()
                            }, label: {
                                HStack{
                                    Image("EditProfileSaveIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                    Text("Saved")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .foregroundColor(.black)
                                        .fontWeight(.regular)
                                    Spacer()
                                }
                                .padding(.leading, UIScreen.screenWidth/20)
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
                            })
                            .navigationDestination(isPresented: $navigateToSaved, destination: {
                                ProfileSavedView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                            })
                            Divider()
                        }
                        VStack(alignment: .leading){
                            Button(action: {
                                
                                    navigateToDiscoverPeople.toggle()
                            }, label: {
                                HStack{
                                    Image("SidebarBecomeOurPartner")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                    Text("Discover People")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.regular)
                                    Spacer()
                                }
                                .padding(.leading, UIScreen.screenWidth/20)
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
                            })
                            .navigationDestination(isPresented: $navigateToDiscoverPeople, destination: {
                                DiscoverPeopleView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                            })
                            Divider()
                        }
                    }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/2.8)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: profileVM.showNormalProfileEditBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(profileVM.showNormalProfileEditBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        profileVM.showNormalProfileEditBottomSheet.toggle()
                    }
                }
            )
        }
        .onDisappear{
            profileVM.showNormalProfileEditBottomSheet = false
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
                    profileVM.showNormalProfileEditBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct NormalProfileEditBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileEditBottomSheet()
//    }
//}
