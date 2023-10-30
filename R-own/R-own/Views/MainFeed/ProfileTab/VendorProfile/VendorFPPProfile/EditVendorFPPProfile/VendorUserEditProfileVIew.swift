//
//  VendorUserEditProfileVIew.swift
//  R-own
//
//  Created by Aman Sharma on 19/06/23.
//

import SwiftUI
import AlertToast

struct VendorUserEditProfileVIew: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State private var newVendorBrandLogo: UIImage?
    @State private var portfolio1: UIImage?
    @State private var portfolio2: UIImage?
    @State private var portfolio3: UIImage?
    
    @StateObject var vendorPCS = VendorUserProfileCompletionService()
    @StateObject var profileService = ProfileService()
    
    @State var alertFailed: Bool = false
    @State var alertUpdated: Bool = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                //nav
                BasicNavbarView(navbarTitle: "Edit Your Vendor Profile")
                ScrollView {
                    ZStack{
                        VStack{
                            
                            //profile picture
                            EditFPPProfilePicView(loginData: loginData, globalVM: globalVM, newHotelLogo: $newVendorBrandLogo, currentLogoURL: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorImage)
                            
                            //Details
                            VendorEditFPPProfileDetailsView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, portfolioImage1Cropped: $portfolio1, portfolioImage2Cropped: $portfolio2, portfolioImage3Cropped: $portfolio3)
                            
                            //Save button
                            Button(action: {
                                Task{
                                    let res = await vendorPCS.updateVendorInfoDetails(userID: loginData.mainUserID, brandName: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorName, brandDescription: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorDescription, brandWebsiteLink: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.websiteLink, vendorImage: newVendorBrandLogo, portfolio1img: portfolio1, portfolio2img: portfolio2, portfolio3img: portfolio3)
                                    if res == "Success"{
                                        alertUpdated = true
                                    } else{
                                        alertFailed = true
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
                        DesignationBottomSheetView(globalVM: globalVM, designation: $profileVM.mainUserBio)
                    }
                }
            }
            .toast(isPresenting: $alertFailed, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try Again")
            }
            .toast(isPresenting: $alertUpdated, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("checkmark.square.fill", greenUi), title: "Updated")
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            
        }
    }
}

//
//struct VendorUserEditProfileVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorUserEditProfileVIew()
//    }
//}
