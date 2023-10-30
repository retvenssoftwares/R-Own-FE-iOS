//
//  ProfileCreationNumSecondHalf.swift
//  R-own
//
//  Created by Aman Sharma on 08/04/23.
//

import SwiftUI

struct ProfileCreationNumSecondHalf: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    @State private var profilePic: UIImage?
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    var body: some View {
        VStack{
            ProfileImageHandler(loginData: loginData, profilePic: $profilePic)
            
            ProfileFieldsHandler(loginData: loginData, profilePic: $profilePic, globalVM: globalVM, profileVM: profileVM)
        }
    }
}

//struct ProfileCreationNumSecondHalf_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileCreationNumSecondHalf()
//    }
//}
