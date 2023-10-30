//
//  JobsView.swift
//  R-own
//
//  Created by Aman Sharma on 11/04/23.
//

import SwiftUI

struct JobsView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var createPostVM: CreatePostViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel

    
    var body: some View {
        if loginData.mainUserRole == "Hotelier" {
            JobUserView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
        } else if loginData.mainUserRole == "Business Vendor / Freelancer" {
            JobUserView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
        } else if loginData.mainUserRole == "Hotel Owner" {
            JobsHotelierView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, createPostVM: createPostVM)
        } else if loginData.mainUserRole == "Normal User"{
            JobUserView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
        } else {
            JobsProfileNotCompletedView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
        }
    }
}

//struct JobsView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobsView()
//    }
//}
