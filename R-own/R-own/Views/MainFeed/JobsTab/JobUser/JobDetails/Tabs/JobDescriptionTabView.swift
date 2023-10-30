//
//  JobDescriptionTabView.swift
//  R-own
//
//  Created by Aman Sharma on 09/05/23.
//

import SwiftUI

struct JobDescriptionTabView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading){
                    Text("Job Description")
                        .font(.system(size: UIScreen.screenHeight/60))
                        .fontWeight(.regular)
                        .padding()
                    
                    Text(globalVM.jobDetails.jobDescription)
                        .font(.system(size: UIScreen.screenHeight/90))
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                .padding(.top, UIScreen.screenHeight/60)
            VStack(alignment: .leading){
                Text("Skill Required")
                    .font(.system(size: UIScreen.screenHeight/60))
                    .fontWeight(.regular)
                    .padding()
                
                Text(globalVM.jobDetails.skillsRecq)
                    .font(.system(size: UIScreen.screenHeight/90))
                    .multilineTextAlignment(.leading)
                    .padding()
                }
            }
        }
    }
}

//struct JobDescriptionTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobDescriptionTabView()
//    }
//}
