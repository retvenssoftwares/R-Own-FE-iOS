//
//  JobDetailsView.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct JobDetailsView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var jobID: String
    @State var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var bookmarkedJob: Bool = false
    @State var appliedJob: Bool = false
    @StateObject var userJobServices = UserJobService()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    JobDetailsNavbar(jobsVM: jobsVM)
                    
                    JobDetailFirstHalfView(jobsVM: jobsVM, globalVM: globalVM)
                    
                    JobsDetailSecondHalfView(jobsVM: jobsVM)
                    
                    TabView(selection: $jobsVM.jobsDetailTabSelected){
                        JobDescriptionTabView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM)
                            .ignoresSafeArea(.all, edges: .all)
                            .tag("Description")
                        
                        JobCompanyTabView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM)
                            .ignoresSafeArea(.all, edges: .all)
                            .tag("Company")
                        
                        JobActivitiesTabView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM)
                                    .ignoresSafeArea(.all, edges: .all)
                                    .tag("Activities")
                        
                        JobPeopleTabView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                            .ignoresSafeArea(.all, edges: .all)
                            .tag("People")
                        
                    }
                    
                    Button(action: {
                        jobsVM.applyJobBottomSheet.toggle()
                    }, label: {
                        Text(jobsVM.jobApplied ? "Apply" : "Applied")
                            .font(.system(size: UIScreen.screenHeight/60))
                            .foregroundColor(.black)
                            .padding(.horizontal, UIScreen.screenWidth/10)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .background(jobsVM.jobApplied ? jobsBrightGreen : .gray)
                    })
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .padding(.vertical, UIScreen.screenHeight/50)
                }
                .padding(UIScreen.screenWidth/40)
                ApplyJobBottomSheet(loginData: loginData, jobsVM: jobsVM)
            }
            .onAppear{
                userJobServices.getSpecificJobByID(globalVM: globalVM, loginData: loginData, jobID: jobID)
            }
        .navigationBarBackButtonHidden()
        }
    }
}

//struct JobDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobDetailsView()
//    }
//}
