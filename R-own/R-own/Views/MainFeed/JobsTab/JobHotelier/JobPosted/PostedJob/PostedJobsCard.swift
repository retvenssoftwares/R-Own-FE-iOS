//
//  PostedJobsTab.swift
//  R-own
//
//  Created by Aman Sharma on 26/05/23.
//

import SwiftUI
import Shimmer

struct PostedJobsCard: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var jobs: JobsByHotelOwnerModel
    
    @State var navigateToJobDetailsView: Bool = false
    @State var bookmarkedJob: Bool = false
    @State var saveService = SaveElemetsIDService()
    
    var body: some View {
        VStack{
            HStack{
                AsyncImage(url: URL(string: jobs.hotelLogoURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                        .cornerRadius(5)
                        .padding(10)
                } placeholder: {
                    Rectangle()
                        .fill(greyUi)
                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                        .shimmering(active: true)
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
//                            JobDetailsView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, jobID: jobs.jid)
                        })
                }
                Spacer()
                Button(action: {
                    saveService.saveJobID(loginData: loginData, jobID: jobs.jid)
                }, label: {
                    Image(bookmarkedJob ? "JobsBookMarkedIcon" : "JobsExploreIcon")
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
                    Text("Job Category")
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
            
            Button(action: {
                navigateToJobDetailsView.toggle()
            }, label: {
                Text("View Details")
                    .font(.system(size: UIScreen.screenHeight/60))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.horizontal, UIScreen.screenWidth/10)
                    .padding(.vertical, UIScreen.screenHeight/60)
                    .background(greenUi)
                    .padding()
            })
            .navigationDestination(isPresented: $navigateToJobDetailsView, destination: {
//                JobDetailsView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, jobID: jobs.jid)
            })
            
            Divider()
        }
        .padding(.bottom, UIScreen.screenHeight/60)
        
    }
}

//struct PostedJobsTab_Previews: PreviewProvider {
//    static var previews: some View {
//        PostedJobsTab()
//    }
//}
