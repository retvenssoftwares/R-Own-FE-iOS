//
//  JobUserView.swift
//  R-own
//
//  Created by Aman Sharma on 06/05/23.
//

import SwiftUI

struct JobUserView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    var body: some View {
        ZStack {
            VStack{
                VStack{
                    JobUserFirstHalfView(jobsVM: jobsVM, loginData: loginData)
                        .padding(.leading, UIScreen.screenWidth/30)
                    JobUserSecondHalfView(jobsVM: jobsVM)
                    
                    TabView(selection: $jobsVM.jobsUserTabSelected){
                            
                        JobsExploreView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                                .ignoresSafeArea(.all, edges: .all)
                                .tag("Jobs Explore")
                            
                        RequestJobView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM)
                                .ignoresSafeArea(.all, edges: .all)
                                .tag("Request a Job")
                            
                            AppliedJobsView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM)
                                .ignoresSafeArea(.all, edges: .all)
                                .tag("AppliedJobs")
                        }
                }
            }
            
        }
    }
}

//struct JobUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobUserView()
//    }
//}
