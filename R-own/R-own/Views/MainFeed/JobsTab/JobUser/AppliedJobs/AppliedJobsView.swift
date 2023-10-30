//
//  AppliedJobsView.swift
//  R-own
//
//  Created by Aman Sharma on 07/05/23.
//

import SwiftUI

struct AppliedJobsView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var userJobService = UserJobService()
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        VStack{
            //Search Field
            TextField("Search", text: $jobsVM.jobsSearchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.default)
                .padding()
                .frame(width: UIScreen.screenWidth/1.2)
                .cornerRadius(5)
                .overlay{
                    Image("ExploreSearchIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                        .offset(x: UIScreen.screenWidth/2.9)
                }
                .focused($isKeyboardShowing)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                        }
                    }
                }
            ScrollView{
                VStack{
                    if globalVM.appliedJobs.count > 0 {
                        ForEach(0...globalVM.appliedJobs.count, id: \.self) { count in
                            //Card
                            AppliedJobsCardView(jobs: globalVM.appliedJobs[count])
                        }
                    } else {
                        Text("Looks like you havent applied for any job yet")
                    }
                }
                .padding(.top, UIScreen.screenHeight/50)
            }
        }
        .padding(.bottom, UIScreen.screenHeight/10)
        .onAppear{
            userJobService.getAppliedJobs(globalVM: globalVM, loginData: loginData)
        }
    }
}

//struct AppliedJobsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppliedJobsView()
//    }
//}
