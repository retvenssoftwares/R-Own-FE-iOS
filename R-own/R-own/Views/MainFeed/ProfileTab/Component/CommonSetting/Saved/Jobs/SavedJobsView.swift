//
//  SavedJobsView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct SavedJobsView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    var body: some View {
        ScrollView{
            VStack{
                JobsProfileListView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
            }
        }
    }
}

//struct SavedJobsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedJobsView()
//    }
//}
