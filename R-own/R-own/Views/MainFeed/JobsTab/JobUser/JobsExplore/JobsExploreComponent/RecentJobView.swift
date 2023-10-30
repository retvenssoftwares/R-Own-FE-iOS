//
//  RecentJobView.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI
import Shimmer

struct RecentJobView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var jobsVM: JobsViewModel
    @State var jobs: RecentJobsModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var bookmarkedJob: Bool = false
    @State var navigateToJobDetailsView: Bool = false
    @State var saveService = SaveElemetsIDService()
    
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    
                    AsyncImage(url: URL(string: jobs.hotelLogoURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                            .clipped()
                            .cornerRadius(5)
                            .padding(10)
                    }placeholder: {
                        //put your placeholder here
                        Rectangle()
                            .fill(lightGreyUi)
                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                            .shimmering(active: true)
                            .padding(10)
                            
                    }
                    VStack(alignment: .leading){
                        Text(jobs.designationType)
                            .font(.system(size: UIScreen.screenHeight/40))
                            .foregroundColor(.black)
                        Text(jobs.companyName)
                            .font(.system(size: UIScreen.screenHeight/80))
                            .foregroundColor(greyUi)
                            .onTapGesture {
                                navigateToJobDetailsView.toggle()
                            }
                            .navigationDestination(isPresented: $navigateToJobDetailsView, destination: {
//                                JobDetailsView(job: job)
                            })
                    }
                    Spacer()
                    Button(action: {
                        if jobs.saved == "saved"{
                            saveService.unsaveJobID(loginData: loginData, jobID: jobs.jid)
                            jobs.saved = "not saved"
                        } else {
                            saveService.saveJobID(loginData: loginData, jobID: jobs.jid)
                            jobs.saved = "saved"
                        }
                    }, label: {
                        Image(jobs.saved == "saved" ? "JobsBookMarkedIcon" : "JobsExploreIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .padding(.trailing, UIScreen.screenWidth/40)
                    })
                }
                HStack{
                    
                    HStack{
                        Text(jobs.jobType)
                            .font(.system(size: UIScreen.screenHeight/110))
                            .foregroundColor(.white)
                            .padding(.horizontal ,UIScreen.screenHeight/50)
                            .padding(.vertical, UIScreen.screenHeight/90)
                            .background(jobsDarkBlue)
                            .cornerRadius(25)
                        Text("jobCategory")
                            .font(.system(size: UIScreen.screenHeight/110))
                            .foregroundColor(.white)
                            .padding(.horizontal ,UIScreen.screenHeight/50)
                            .padding(.vertical, UIScreen.screenHeight/90)
                            .background(jobsDarkBlue)
                            .cornerRadius(25)
                    }
                    .padding(.leading, UIScreen.screenWidth/40)
                    Spacer()
                    Text(jobs.expectedCTC)
                        .font(.system(size: UIScreen.screenHeight/70))
                        .foregroundColor(.black)
                        .padding(20)
                }
                .padding(.trailing, UIScreen.screenWidth/40)
                Divider()
            }
            .padding(.bottom, UIScreen.screenHeight/60)
            .onTapGesture {
                navigateToJobDetailsView.toggle()
            }
            .navigationDestination(isPresented: $navigateToJobDetailsView, destination: {
                JobDetailsView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, jobID: "", profileVM: profileVM, mesiboVM: mesiboVM)
            })
        }
    }
}

//struct RecentJobView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentJobView()
//    }
//}
