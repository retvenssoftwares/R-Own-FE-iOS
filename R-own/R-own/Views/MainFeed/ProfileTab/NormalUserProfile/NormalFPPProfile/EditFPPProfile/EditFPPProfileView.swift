//
//  EditFPPProfileView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI
import AlertToast

struct EditFPPProfileView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State private var newProfilePic: UIImage?
    
    @StateObject var profileService = ProfileService()
    
    @State var alertDeleted: Bool = false
    @State var alertFailed: Bool = false
    
    var body: some View {
        NavigationStack{
            if loginData.profileCompletionPercentage == "100" {
            ScrollView {
                ZStack{
                        VStack{
                            //nav
                            BasicNavbarView(navbarTitle: "Edit Your Profile")
                            ScrollView{
                                //profile picture
                                EditFPPProfilePicView(loginData: loginData, globalVM: globalVM, newHotelLogo: $newProfilePic, currentLogoURL: globalVM.getNormalProfileHeader.data.profile.profilePic)
                                
                                //Details
                                EditFPPProfileDetailsView(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
                                
                                //Save button
                                Button(action: {
                                    print("navigating back to profile page")
                                    Task{
                                        let res = await profileService.updateEditNormalUser(userID: loginData.mainUserID, userBio: globalVM.getNormalProfileHeader.data.profile.userBio, userIdentity: profileVM.mainUserGender, profileImage: newProfilePic)
                                        if res == "Success"{
                                            alertDeleted = true
                                        } else {
                                            alertFailed = true
                                        }
                                    }
                                }, label: {
                                    Text("SAVE")
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(jobsTextDarkBlue)
                                        .frame(width: UIScreen.screenWidth/1.3)
                                        .padding(.vertical, UIScreen.screenHeight/60)
                                        .background(greenUi)
                                        .cornerRadius(5)
                                        .padding()
                                })
                            }
                        }
                    }
//                    DesignationBottomSheetView(globalVM: globalVM, designation: $profileVM.mainUserBio)
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
        .toast(isPresenting: $alertFailed, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try Again")
        }
        .toast(isPresenting: $alertDeleted, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("checkmark.square.fill", greenUi), title: "Updated")
        }
        .navigationBarBackButtonHidden()
    }
}

//struct EditFPPProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditFPPProfileView()
//    }
//}
