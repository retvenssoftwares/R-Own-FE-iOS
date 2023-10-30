//
//  HotelOwnerProfileEditBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import SwiftUI

struct HotelOwnerProfileEditBottomSheet: View {
    
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
    @State var navigateToEditHotelProfile: Bool = false
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
                                HotelUserEditProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
                            })
                            Divider()
                        }
                        VStack(alignment: .leading){
                            
                                Button(action: {
                                    navigateToEditHotelProfile.toggle()
                                }, label: {
                                    HStack{
                                        Image("PostDiscardEditing")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                        Text("Edit Hotel Profile")
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    .padding(.leading, UIScreen.screenWidth/20)
                                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
                                })
                            .navigationDestination(isPresented: $navigateToEditHotelProfile, destination: {
                                HotelOwnerEditProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
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
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
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
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
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
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/2.5)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: profileVM.showHotelOwnerProfileEditBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(profileVM.showHotelOwnerProfileEditBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        profileVM.showHotelOwnerProfileEditBottomSheet.toggle()
                    }
                }
            )
        }
        .onDisappear{
            profileVM.showHotelOwnerProfileEditBottomSheet = false
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
                    profileVM.showHotelOwnerProfileEditBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct HotelOwnerProfileEditBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelOwnerProfileEditBottomSheet()
//    }
//}
