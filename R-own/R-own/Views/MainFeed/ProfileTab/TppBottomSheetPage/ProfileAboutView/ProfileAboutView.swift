//
//  ProfileAboutView.swift
//  R-own
//
//  Created by Aman Sharma on 26/07/23.
//

import SwiftUI

struct ProfileAboutView: View {
    
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        VStack{
            BasicNavbarView(navbarTitle: "About")
            Spacer()
            VStack(spacing: UIScreen.screenHeight/70){
                VStack{
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 1)
                        .foregroundColor(lightGreyUi)
                        .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/20)
                        .overlay{
                            HStack{
                                if globalVM.viewingUserRole == "Normal User" {
                                    
                                    Text(globalVM.getNormalProfileHeader.data.profile.createdOn)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                } else if globalVM.viewingUserRole == "Business Vendor / Freelancer" {
                                    
                                    Text(globalVM.getVendorProfileHeader.roleDetails.createdOn)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                } else if globalVM.viewingUserRole == "Hotel Owner" {
                                    
                                    Text(globalVM.getHotelOwnerProfileHeader.profile.createdOn)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                }
                                Spacer()
                            }
                        }
                        .overlay{
                            VStack{
                                HStack{
                                    Text("Created On")
                                        .font(.body)
                                        .foregroundColor(lightGreyUi)
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                        .background(.white)
                                    Spacer()
                                }
                                Spacer()
                            }
                            .offset(y: -UIScreen.screenHeight/100)
                        }
                }
                VStack{
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 1)
                        .foregroundColor(lightGreyUi)
                        .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/20)
                        .overlay{
                            HStack{
                                if globalVM.viewingUserRole == "Normal User" {
                                    
                                    Text(globalVM.getNormalProfileHeader.data.profile.location)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                } else if globalVM.viewingUserRole == "Business Vendor / Freelancer" {
                                    
                                    Text(globalVM.getVendorProfileHeader.roleDetails.location)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                } else if globalVM.viewingUserRole == "Hotel Owner" {
                                    
                                    Text(globalVM.getHotelOwnerProfileHeader.profile.location)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                }
                                Spacer()
                            }
                        }
                        .overlay{
                            VStack{
                                HStack{
                                    Text("Profile Based In")
                                        .font(.body)
                                        .foregroundColor(lightGreyUi)
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                        .background(.white)
                                    Spacer()
                                }
                                Spacer()
                            }
                            .offset(y: -UIScreen.screenHeight/100)
                        }
                }
                VStack{
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 1)
                        .foregroundColor(lightGreyUi)
                        .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/20)
                        .overlay{
                            HStack{
                                if globalVM.viewingUserRole == "Normal User" {
                                    
                                    Text(globalVM.getNormalProfileHeader.data.profile.verificationStatus)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                } else if globalVM.viewingUserRole == "Business Vendor / Freelancer" {
                                    
                                    Text(globalVM.getVendorProfileHeader.roleDetails.verificationStatus)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                } else if globalVM.viewingUserRole == "Hotel Owner" {
                                    
                                    Text(globalVM.getHotelOwnerProfileHeader.profile.verificationStatus)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                }
                                Spacer()
                            }
                        }
                        .overlay{
                            VStack{
                                HStack{
                                    Text("Verification Status")
                                        .font(.body)
                                        .foregroundColor(lightGreyUi)
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                        .background(.white)
                                    Spacer()
                                }
                                Spacer()
                            }
                            .offset(y: -UIScreen.screenHeight/100)
                        }
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

//struct ProfileAboutView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileAboutView()
//    }
//}
