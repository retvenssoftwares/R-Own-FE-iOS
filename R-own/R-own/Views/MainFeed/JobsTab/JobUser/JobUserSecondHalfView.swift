//
//  JobUserSecondHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 07/05/23.
//

import SwiftUI

struct JobUserSecondHalfView: View {
    
    @StateObject var jobsVM: JobsViewModel
    
    var body: some View {
            HStack{
                Spacer()
                Button(action: {
                    jobsVM.jobsUserTabSelected = "Jobs Explore"
                }, label: {
                    HStack{
                        Image("JobsExploreIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                        Text("Jobs Explore")
                            .foregroundColor(.black)
                            .font(.system(size: UIScreen.screenHeight/100))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    }
                    .padding(.horizontal, 10)
                    .padding()
                    .background(.white)
                    .cornerRadius(4)
                    .clipped()
                    .shadow(radius: 4)
                    .border(width: jobsVM.jobsUserTabSelected == "Jobs Explore" ? 2 : 0,edges: [.top], color: greenUi)
                    
                })
                Spacer()
                Button(action: {
                    jobsVM.jobsUserTabSelected = "Request a Job"
                }, label: {
                    HStack{
                        Image("JobsUserIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                        Text("Request a Job")
                            .foregroundColor(.black)
                            .font(.system(size: UIScreen.screenHeight/100))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    }
                    .padding(.horizontal, 10)
                    .padding()
                    .background(.white)
                    .cornerRadius(4)
                    .clipped()
                    .shadow(radius: 4)
                    .border(width: jobsVM.jobsUserTabSelected == "Request a Job" ? 2 : 0,edges: [.top], color: greenUi)
                    
                })
                Spacer()
                Button(action: {
                    jobsVM.jobsUserTabSelected = "AppliedJobs"
                }, label: {
                    HStack{
                        Image("JobsUserIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                        Text("Applied Jobs")
                            .foregroundColor(.black)
                            .font(.system(size: UIScreen.screenHeight/100))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    }
                    .padding(.horizontal, 10)
                    .padding()
                    .background(.white)
                    .cornerRadius(4)
                    .clipped()
                    .shadow(radius: 4)
                    .border(width: jobsVM.jobsUserTabSelected == "AppliedJobs" ? 2 : 0,edges: [.top], color: greenUi)
                })
                Spacer()
        }
    }
}

//struct JobUserSecondHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobUserSecondHalfView()
//    }
//}
