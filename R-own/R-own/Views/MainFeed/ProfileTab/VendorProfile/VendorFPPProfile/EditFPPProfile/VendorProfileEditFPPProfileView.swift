//
//  VendorProfileEditFPPProfileView.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import SwiftUI

struct VendorProfileEditFPPProfileView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    @State private var newProfilePic: UIImage?
    
    @StateObject var vendorService = VendorProfileService()
    
    var body: some View {
        NavigationStack{
            if loginData.profileCompletionPercentage == "100" {
            ScrollView {
                ZStack{
                        VStack{
                            //nav
                            BasicNavbarView(navbarTitle: "Edit Your Profile")
                            
                            //profile picture
                            EditFPPProfilePicView(loginData: loginData, globalVM: globalVM, newHotelLogo: $newProfilePic, currentLogoURL: globalVM.getVendorProfileHeader.roleDetails.profilePic)
                            
                            //Details
                            EditVendorFPPProfileDetails(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
                            
                            //Save button
                            Button(action: {
                                print("navigating back to profile page")
                                vendorService.updateVendorProfileData(userID: loginData.mainUserID, bio: globalVM.getVendorProfileHeader.roleDetails.userBio, profileImage: newProfilePic)
                            }, label: {
                                Text("SAVE")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(jobsDarkBlue)
                                    .frame(width: UIScreen.screenWidth/1.3)
                                    .padding(.vertical, UIScreen.screenHeight/60)
                                    .background(greenUi)
                                    .cornerRadius(5)
                                    .padding()
                            })
                        }
                    }
                }
            } else {
                Spacer()
                Image("ProfileNotCompletedIllustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/1.5)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct VendorProfileEditFPPProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorProfileEditFPPProfileView()
//    }
//}
