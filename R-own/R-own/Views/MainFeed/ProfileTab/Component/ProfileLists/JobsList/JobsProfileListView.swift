//
//  JobsProfileListView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct JobsProfileListView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var saveService = SaveElemetsIDService()
    @State var counter: Int = 0
    
    var body: some View {
        ScrollView{
            if globalVM.getSavePostList[0].posts.count > 0 {
                ForEach(0..<globalVM.getSavePostList[0].posts.count, id: \.self) { id in
                    
                    SavedJobsTabView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM, companyLogo: "")
                        .padding()
                        .onAppear{
                            if id == globalVM.getSavePostList[0].posts.count - 2 {
                                counter = counter + 1
                                saveService.getSaveJob(globalVM: globalVM, userID: loginData.mainUserID, pageNo: counter)
                            }
                        }
                }
            } else {
                Text("You've not saved any jobs yet!")
            }
        }
        .onAppear{
            saveService.getSaveJob(globalVM: globalVM, userID: loginData.mainUserID, pageNo: 1)
        }
    }
}

//struct JobsProfileListView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobsProfileListView()
//    }
//}
