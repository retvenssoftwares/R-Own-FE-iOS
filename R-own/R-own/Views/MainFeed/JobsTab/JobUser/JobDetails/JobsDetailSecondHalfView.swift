//
//  JobsDetailSecondHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI

struct JobsDetailSecondHalfView: View {
    
    @StateObject var jobsVM: JobsViewModel
    
    
    var body: some View {
        HStack(spacing: 0){
            Text("Description")
                .foregroundColor(jobsVM.jobsDetailTabSelected == "Description" ? .white : .black)
                .font(.system(size: UIScreen.screenHeight/50))
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
                .frame(alignment: .leading)
                .padding(.vertical, UIScreen.screenHeight/50)
                .padding(.horizontal, UIScreen.screenWidth/20)
                .background(jobsVM.jobsDetailTabSelected == "Description" ? jobsDarkBlue : jobsGreyUi)
                .cornerRadius(jobsVM.jobsDetailTabSelected == "Description" ? 15 : 0)
                .onTapGesture {
                    withAnimation(.linear){
                        jobsVM.jobsDetailTabSelected = "Description"
                    }
                }
            Spacer()
            Text("Company")
                .foregroundColor(jobsVM.jobsDetailTabSelected == "Company" ? .white : .black)
                .font(.system(size: UIScreen.screenHeight/50))
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
                .frame(alignment: .leading)
                .padding(.vertical, UIScreen.screenHeight/50)
                .padding(.horizontal, UIScreen.screenWidth/20)
                .background(jobsVM.jobsDetailTabSelected == "Company" ? jobsDarkBlue : jobsGreyUi)
                .cornerRadius(jobsVM.jobsDetailTabSelected == "Company" ? 15 : 0)
                .onTapGesture {
                    withAnimation(.linear){
                        jobsVM.jobsDetailTabSelected = "Company"
                    }
                }
            Spacer()
            if jobsVM.jobApplied {
                Text("People")
                    .foregroundColor(jobsVM.jobsDetailTabSelected == "People" ? .white : .black)
                    .font(.system(size: UIScreen.screenHeight/50))
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .leading)
                    .padding(.vertical, UIScreen.screenHeight/50)
                    .padding(.horizontal, UIScreen.screenWidth/20)
                    .background(jobsVM.jobsDetailTabSelected == "People" ? jobsDarkBlue : jobsGreyUi)
                    .cornerRadius(jobsVM.jobsDetailTabSelected == "People" ? 15 : 0)
                    .onTapGesture {
                        withAnimation(.linear){
                            jobsVM.jobsDetailTabSelected = "People"
                        }
                    }
            } else {
                Text("Activities")
                    .foregroundColor(jobsVM.jobsDetailTabSelected == "Activities" ? .white : .black)
                    .font(.system(size: UIScreen.screenHeight/50))
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .leading)
                    .padding(.vertical, UIScreen.screenHeight/50)
                    .padding(.horizontal, UIScreen.screenWidth/20)
                    .background(jobsVM.jobsDetailTabSelected == "Activities" ? jobsDarkBlue : jobsGreyUi)
                    .cornerRadius(jobsVM.jobsDetailTabSelected == "Activities" ? 15 : 0)
                    .onTapGesture {
                        withAnimation(.linear){
                            jobsVM.jobsDetailTabSelected = "Activities"
                        }
                    }
            }
        }
        .background(jobsGreyUi)
        .frame(width: UIScreen.screenWidth/1.2)
        .cornerRadius(15)
    }
}

//struct JobsDetailSecondHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobsDetailSecondHalfView()
//    }
//}
