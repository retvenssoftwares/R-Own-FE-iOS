//
//  ExploreJobsView.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import SwiftUI

struct ExploreJobsView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var exploreService = ExploreService()
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var counter: Int = 1
    
    var body: some View {
        VStack{
            ScrollView{
                if globalVM.exploreJobList.count == 1 {
                    ForEach(0..<globalVM.exploreJobList[0].posts.count, id: \.self){ id in
                        ExploreJobCardView(job: globalVM.exploreJobList[0].posts[id],jobsVM: jobsVM, loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .onAppear{
                                if id == globalVM.exploreJobList[0].posts.count - 2 {
                                    counter = counter + 1
                                    exploreService.getExploreJobs(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(counter))
                                }
                            }
                    }
                } else {
                    Text("No Jobs to show")
                }
            }
        }
        .onAppear{
            globalVM.exploreJobList = [ExploreJobModel(posts: [ExploreJobPost]())]
            exploreService.getExploreJobs(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: "1")
        }
    }
}

//struct ExploreJobsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreJobsView()
//    }
//}
