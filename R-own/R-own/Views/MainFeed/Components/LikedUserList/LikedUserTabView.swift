//
//  LikedUserTabView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct LikedUserTabView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @State var likedUser: Like0343
    
    
    
    @State var navigateToProfile: Bool = false
    
    var body: some View {
        NavigationStack {
            NavigationLink(isActive: $navigateToProfile, destination: {
                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: likedUser.role, mainUser: false, userID: likedUser.userID)
            }, label: {Text("")})
            
            HStack{
                ProfilePictureView(profilePic: likedUser.profilePic, verified: likedUser.verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                    .padding(.horizontal, UIScreen.screenWidth/40)
                VStack(alignment: .leading){
                    if likedUser.fullName != "" {
                        Text(likedUser.fullName)
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                    if likedUser.jobTitle != "" {
                        Text(likedUser.jobTitle)
                            .font(.body)
                            .fontWeight(.light)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
            }
            .padding(.vertical, UIScreen.screenHeight/60)
            .onTapGesture {
                navigateToProfile = true
            }
            .navigationDestination(isPresented: $navigateToProfile, destination: {
                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: likedUser.role, mainUser: false, userID: likedUser.userID)
            })
        }
        .onAppear{
            navigateToProfile = false
        }
    }
}

//struct LikedUserTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        LikedUserTabView()
//    }
//}
