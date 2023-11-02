//
//  HotelOwnerEditProfileView.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import SwiftUI
import AlertToast

struct HotelOwnerEditProfileView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var hotelService = HotelService()
    
    @State private var newHotelLogo: UIImage?
    @State var newBookingEngineLink: String = ""
    
    
    @State var currentLogoURLL: String = ""
    
    @State var alertInfoUpdated = false
    @State var alertInfoCantUpdate = false
    
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                //nav
                BasicNavbarView(navbarTitle: "Edit Your Hotel Profile")
                ScrollView {
                    ZStack{
                        if loginData.profileCompletionPercentage == "100" {
                            if isLoading{
                                VStack{
                                    //profile picture
                                    EditFPPProfilePicView(loginData: loginData, globalVM: globalVM, newHotelLogo: $newHotelLogo, currentLogoURL: currentLogoURLL)
                                    
                                    //Details
                                    HotelOwnerEditFPPProfileDetailsView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, newBookingEngineLink: $newBookingEngineLink)
                                    
                                    //Save button
                                    Button(action: {
                                        Task{
                                            hotelService.updatehotelOwnerInfo(loginData: loginData, hotelOwnerName: globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.hotelownerName, hotelDescription: globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.hotelDescription, hotelType: globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.hotelType, websiteLink: globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.websiteLink)
                                            let response = await hotelService.updateHotelBEAndLogo(hotelID: globalVM.getHotelOwnerInfo.hotelID, bookingengineLink: newBookingEngineLink, hotelLogo: newHotelLogo)
                                            if response == "Success"{
                                                alertInfoUpdated.toggle()
                                            } else {
                                                alertInfoUpdated.toggle()
                                            }
                                        }
                                    }, label: {
                                        Text("SAVE")
                                            .font(.body)
                                            .fontWeight(.thin)
                                            .foregroundColor(.black)
                                            .frame(width: UIScreen.screenWidth/1.3)
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                            .background(greenUi)
                                            .cornerRadius(5)
                                            .padding()
                                    })
                                }
                            } else {
                                VStack {
                                    Spacer()
                                    ProgressView()
                                    Spacer()
                                }
                            }
                        } else {
                            Image("ProfileNotCompletedIllustration")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/1.2)
                        }
                        DesignationBottomSheetView(globalVM: globalVM, designation: $profileVM.mainUserBio)
                    }
                }
            }
        }
        .toast(isPresenting: $alertInfoUpdated, duration: 2, tapToDismiss: true){
            AlertToast( type: .complete(greenUi), title: "Hotel Updated")
        }
        .toast(isPresenting: $alertInfoCantUpdate, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try again!", subTitle: ("Unable to update"))
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            isLoading = false
            globalVM.getHotelOwnerInfo = GetHotelOwnerInfoModel(hotelOwnerInfo: [HotelOwnerInfoElement23](), hotelID: "", hotelLogoURL: "")
            Task{
                let res = await hotelService.getHotelOwnerInfoByUserID(globalVM: globalVM, loginData: loginData, userID: loginData.mainUserID)
                if res == "Success"{
                    if globalVM.getHotelOwnerInfo.hotelOwnerInfo.count > 0 {
                        newBookingEngineLink = globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.bookingEngineLink
                    }
                    loginData.showLoader = true
                    print(currentLogoURLL)
                    print(globalVM.getHotelOwnerInfo.hotelLogoURL)
                    currentLogoURLL = ""
                    currentLogoURLL = globalVM.getHotelOwnerInfo.hotelLogoURL
                    print(currentLogoURLL)
                    print(globalVM.getHotelOwnerInfo.hotelLogoURL)
                    loginData.showLoader = false
                    isLoading = true
                } else {
                    let res = await hotelService.getHotelOwnerInfoByUserID(globalVM: globalVM, loginData: loginData, userID: loginData.mainUserID)
                    if res == "Success"{
                        if globalVM.getHotelOwnerInfo.hotelOwnerInfo.count > 0 {
                            newBookingEngineLink = globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.bookingEngineLink
                        }
                        loginData.showLoader = true
                        print(currentLogoURLL)
                        print(globalVM.getHotelOwnerInfo.hotelLogoURL)
                        currentLogoURLL = ""
                        currentLogoURLL = globalVM.getHotelOwnerInfo.hotelLogoURL
                        print(currentLogoURLL)
                        print(globalVM.getHotelOwnerInfo.hotelLogoURL)
                        loginData.showLoader = false
                        isLoading = true
                    } else {
                        isLoading = false
                    }
                }
            }
        }
    }
}

//struct HotelOwnerEditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelOwnerEditProfileView()
//    }
//}
