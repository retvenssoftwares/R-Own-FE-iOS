//
//  VotersListTabsView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct VotersListTabsView: View {
    
    @State var voters: Vote234
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var navigateToProfile: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                ProfilePictureView(profilePic: voters.profilePic, verified: false, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                    .padding(.horizontal, UIScreen.screenWidth/40)
                VStack(alignment: .leading){
                    Text(voters.fullName)
                        .font(.body)
                        .fontWeight(.bold)
                    if voters.jobTitle != "" {
                        Text(voters.jobTitle)
                            .font(.footnote)
                            .fontWeight(.regular)
                    }
                }
                Spacer()
            }
            .padding(.vertical, UIScreen.screenHeight/70)
            .onTapGesture {
                navigateToProfile = true
            }
            .navigationDestination(isPresented: $navigateToProfile, destination: {
                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: voters.role, mainUser: false, userID: voters.userID)
            })
            NavigationLink(isActive: $navigateToProfile, destination: {
                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: voters.role, mainUser: false, userID: voters.userID)
            }, label: {
                Text("")
            })
        }
        .onAppear{
            navigateToProfile = false
        }
    }
}

//struct VotersListTabsView_Previews: PreviewProvider {
//    static var previews: some View {
//        VotersListTabsView()
//    }
//}
