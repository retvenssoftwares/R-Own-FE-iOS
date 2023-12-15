//
//  VendorProfileEditBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import SwiftUI

struct VendorProfileEditBottomSheet: View {
    
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
    @State var navigateToEditVendorProfile: Bool = false
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
                                navigateToSetting = true
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
                            NavigationLink(isActive: $navigateToSetting, destination: {
                                ProfileSettingView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                            }, label: {
                                Text("")
                            })
                            Divider()
                        }
                        VStack(alignment: .leading){
                            Button(action: {
                                    navigateToEditProfile = true
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
                                VendorProfileEditFPPProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
                            })
                            NavigationLink(isActive: $navigateToEditProfile, destination: {
                                VendorProfileEditFPPProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
                            }, label: {
                                Text("")
                            })
                            Divider()
                        }
                        VStack(alignment: .leading){
                            Button(action: {
                                
                                    navigateToEditVendorProfile = true
                            }, label: {
                                
                                HStack{
                                    Image("PostDiscardEditing")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                    Text("Edit Vendor Profile")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding(.leading, UIScreen.screenWidth/20)
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
                            })
                            .navigationDestination(isPresented: $navigateToEditVendorProfile, destination: {
                                VendorUserEditProfileVIew(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
                            })
                            NavigationLink(isActive: $navigateToEditVendorProfile, destination: {
                                VendorUserEditProfileVIew(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
                            }, label: {
                                Text("")
                            })
                            Divider()
                        }
                        VStack(alignment: .leading){
                            Button(action: {
                                print("opening saved")
                                navigateToSaved = true
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
                                    Spacer()
                                }
                                .padding(.leading, UIScreen.screenWidth/20)
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
                            })
                            .navigationDestination(isPresented: $navigateToSaved, destination: {
                                ProfileSavedView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                            })
                            NavigationLink(isActive: $navigateToSaved, destination: {
                                ProfileSavedView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                            }, label: {
                                Text("")
                            })
                            Divider()
                        }
                        VStack(alignment: .leading){
                            Button(action: {
                                
                                    navigateToDiscoverPeople = true
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
                        if loginData.isHiddenKPI {
                            VStack(alignment: .leading){
                                HStack{
                                    Image(systemName: "star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                    Text("Reviews")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding(.leading, UIScreen.screenWidth/20)
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
                                .onTapGesture {
                                    navigateToDiscoverPeople = true
                                }
                                .navigationDestination(isPresented: $navigateToDiscoverPeople, destination: {
                                    DiscoverPeopleView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                                })
                                Divider()
                            }
                        }
                        
                        NavigationLink(isActive: $navigateToDiscoverPeople, destination: {
                            DiscoverPeopleView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                        }, label: {
                            Text("")
                        })
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.bottom,edges?.bottom)
                    .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/2)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: profileVM.showVendorProfileEditBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(profileVM.showVendorProfileEditBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        profileVM.showVendorProfileEditBottomSheet.toggle()
                    }
                }
            )
        }
        .onAppear{
            navigateToSetting = false
            navigateToEditProfile = false
            navigateToEditVendorProfile = false
            navigateToSaved = false
            navigateToDiscoverPeople = false
        }
        .onDisappear{
            profileVM.showVendorProfileEditBottomSheet = false
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
                    profileVM.showVendorProfileEditBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}
//struct VendorProfileEditBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorProfileEditBottomSheet()
//    }
//}
