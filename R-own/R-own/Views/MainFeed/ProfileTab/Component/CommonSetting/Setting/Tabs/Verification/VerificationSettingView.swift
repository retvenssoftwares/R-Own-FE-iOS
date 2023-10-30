//
//  VerificationSettingView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct VerificationSettingView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @StateObject var verificationService = VerificationService()
    @State var navigateToProfileCompletionView: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Verification")
                ScrollView{
                    VStack{
                        if loginData.profileCompletionPercentage != "100" {
                            VStack{
                                Image("ProfileNotCompletedIllustration")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/2)
                                Button(action: {
                                    navigateToProfileCompletionView = true
                                }, label: {
                                    Text("Complete Your Profile")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, UIScreen.screenWidth/10)
                                        .padding(.vertical, UIScreen.screenHeight/80)
                                        .background(greenUi)
                                        .cornerRadius(15)
                                    
                                })
                                .navigationDestination(isPresented: $navigateToProfileCompletionView, destination: {
                                    if loginData.profileCompletionPercentage == "90"{
                                        if loginData.mainUserRole == "Normal User" {
                                            NormalUserBasicInfoView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                        } else if loginData.mainUserRole == "Hospitality Expert" {
                                            HospitalityExpertBasicInfoView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                        } else if loginData.mainUserRole == "Business Vendor / Freelancer" {
                                            VendorBasicInfoView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                        } else if loginData.mainUserRole == "Hotel Owner" {
                                            HotelOwnerBasicInfoView(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
                                        }
                                    } else if loginData.profileCompletionPercentage == "60" {
                                        UserBioAndGenderProfileCompletion(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                    } else if loginData.profileCompletionPercentage == "80" {
                                        UserRoleView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                    } else if loginData.profileCompletionPercentage == "70" {
                                        LocationProfileCompletionView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                    } else if loginData.profileCompletionPercentage == "50"{
                                        BasicInfoProfileView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                    }
                                })
                            }
                        } else if globalVM.verificationStatusResponse == "applied" {
                            
                            Image("UserVerificationApplied")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/2)
                            
                        } else if globalVM.verificationStatusResponse == " not applied"{
                            
                            ApplyVerificationSettingView(loginData: loginData, globalVM: globalVM)
                            
                        }
                    }
                }
            }
        }
        .onAppear{
            verificationService.checkVerificationStatus(globalVM: globalVM, userID: loginData.mainUserID)
        }
        .navigationBarBackButtonHidden()
    }
}

//struct VerificationSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        VerificationSettingView()
//    }
//}
