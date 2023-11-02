//
//  ProfileNavbarView.swift
//  R-own
//
//  Created by Aman Sharma on 16/05/23.
//

import SwiftUI

struct ProfileNavbarView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @Binding var navigateToBottomSheet: Bool
    @State var role: String
    @State var mprofile: String
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        //Navbar
        HStack{
            //button
            if mprofile != "mainUser" {
                Button(action: {
                    if loginData.notificationProfileView {
                        loginData.notificationProfileView.toggle()
                    } else {
                        dismiss()
                    }
                }, label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                        .foregroundColor(.black)
                })
            }
            
            //text
            if role == "Hotel Owner" {
                Text(globalVM.getHotelOwnerProfileHeader.profiledata.userName)
                    .font(.body)
                    .fontWeight(.bold)
            } else if role == "Business Vendor / Freelancer" {
                Text(globalVM.getVendorProfileHeader.roleDetails.userName)
                    .font(.body)
                    .fontWeight(.bold)
            } else {
                Text(globalVM.getNormalProfileHeader.data.profile.userName)
                    .font(.body)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            //Setting icon
            Button(action: {
                print("opening setting bottom sheet")
                if mprofile == "mainUser" {
                    navigateToBottomSheet.toggle()
                } else {
                    loginData.nTPPProfileSettingBottomSheet.toggle()
                }
            }, label: {
                Image("ThreeDotsIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenWidth/60, height: UIScreen.screenHeight/60)
            })
        }
        .padding(.horizontal, UIScreen.screenWidth/30)
        .padding(.top, mprofile != "mainUser" ? UIScreen.screenHeight/100 : UIScreen.screenHeight/20)
        .padding(.bottom, UIScreen.screenHeight/40)
    }
}

//struct ProfileNavbarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileNavbarView()
//    }
//}
