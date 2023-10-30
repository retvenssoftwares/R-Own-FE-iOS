//
//  JobsHotelierView.swift
//  R-own
//
//  Created by Aman Sharma on 06/05/23.
//

import SwiftUI

struct JobsHotelierView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var createPostVM: CreatePostViewModel
    
    var body: some View {
        VStack{
            JobHotelierFIrstHalfView(jobsVM: jobsVM, loginData: loginData)
            JobHotelierSecondHalfView(jobsVM: jobsVM)
            
            ZStack{
                TabView(selection: $jobsVM.jobsHotelierTabSelected){
                        
                    JobPostedView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, createPostVM: createPostVM)
                            .ignoresSafeArea(.all, edges: .all)
                            .tag("Job Posted")
                    
                    ExploreRequestingView(globalVM: globalVM, loginData: loginData, jobsVM: jobsVM)
                        .ignoresSafeArea(.all, edges: .all)
                        .tag("Explore Requesting")
                    
                    ExploreEmoloyeesView(loginData: loginData, jobsVM: jobsVM)
                        .ignoresSafeArea(.all, edges: .all)
                        .tag("Explore Employees")
                }
            }
            Spacer()
        }
    }
}

//struct JobsHotelierView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobsHotelierView()
//    }
//}
