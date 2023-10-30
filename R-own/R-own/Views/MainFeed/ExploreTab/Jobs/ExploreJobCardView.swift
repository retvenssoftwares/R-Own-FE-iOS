//
//  ExploreJobCardView.swift
//  R-own
//
//  Created by Aman Sharma on 31/05/23.
//

import SwiftUI
import Shimmer

struct ExploreJobCardView: View {
    
    
    @State var job: ExploreJobPost
    @StateObject var jobsVM: JobsViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var bookmarkedJob: Bool = false
    @State var navigateToJobDetailsView: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    
                    AsyncImage(url: URL(string: job.hotelLogoURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                            .clipped()
                            .cornerRadius(5)
                            .padding(10)
                    }placeholder: {
                        Rectangle()
                            .fill(lightGreyUi)
                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                            .shimmering(active: true)
                    }
                    VStack(alignment: .leading){
                        Text(job.jobTitle)
                            .font(.system(size: UIScreen.screenHeight/40))
                            .foregroundColor(.black)
                        Text(job.companyName)
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
//                    Button(action: {
//                        saveService.saveJobID(loginData: loginData, jobID: job.id)
//                        bookmarkedJob.toggle()
//                    }, label: {
//                        Image(bookmarkedJob ? "JobsBookMarkedIcon" : "JobsExploreIcon")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
//                            .padding(.trailing, UIScreen.screenWidth/40)
//                    })
                }
                HStack{
                    
                    HStack{
                        Text(job.jobType)
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
                    Text("12-15K/Month")
                        .font(.body)
                        .foregroundColor(.black)
                        .padding(20)
                }
                .padding(.horizontal, UIScreen.screenWidth/20)
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
//
//struct ExploreJobCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreJobCardView()
//    }
//}
