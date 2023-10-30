//
//  SuggestedJobCard.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI
import Shimmer

struct SuggestedJobCard: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var jobs: RecentJobsModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var appliedJob: Bool = false
    @State var bookmarkedJob: Bool = false
    
    @State var navigateToJobDetailsView: Bool = false
    @State var id: Int
    @State var saveService = SaveElemetsIDService()
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    AsyncImage(url: URL(string: jobs.hotelLogoURL)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                            .cornerRadius(5)     // Error here
                    } placeholder: {
                        Rectangle()
                            .fill(lightGreyUi)
                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                            .shimmering(active: true)
                    }
                    VStack(alignment: .leading){
                        Text(jobs.designationType)
                            .font(.system(size: UIScreen.screenHeight/60))
                            .foregroundColor((id % 2) == 0 ? .black : .white)
                            .onTapGesture {
                                navigateToJobDetailsView.toggle()
                            }
                            .navigationDestination(isPresented: $navigateToJobDetailsView, destination: {
                                JobDetailsView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, jobID: jobs.jid, profileVM: profileVM, mesiboVM: mesiboVM)
                            })
                        Text(jobs.companyName)
                            .font(.system(size: UIScreen.screenHeight/110))
                            .foregroundColor(jobsLightGrey)
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
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
                    })
                }
                HStack{
                    Text(jobs.jobType)
                        .font(.system(size: UIScreen.screenHeight/110))
                        .foregroundColor((id % 2) == 0 ? .black : .white)
                        .padding(.horizontal ,UIScreen.screenHeight/50)
                        .padding(.vertical, UIScreen.screenHeight/90)
                        .background(.white.opacity(0.2))
                        .cornerRadius(25)
                    Text("jobs.jobCategory")
                        .font(.system(size: UIScreen.screenHeight/110))
                        .foregroundColor((id % 2) == 0 ? .black : .white)
                        .padding(.horizontal ,UIScreen.screenHeight/50)
                        .padding(.vertical, UIScreen.screenHeight/90)
                        .background(.white.opacity(0.2))
                        .cornerRadius(25)
                }
                HStack{
                    Text(jobs.expectedCTC)
                        .font(.system(size: UIScreen.screenHeight/80))
                        .foregroundColor((id % 2) == 0 ? .black : .white)
                        .padding(20)
                    Button(action: {
                        print("tapped")
                    }, label: {
                        Text("Apply Now")
                            .font(.system(size: UIScreen.screenHeight/80))
                            .foregroundColor((id % 2) == 0 ? .white : .black)
                            .fontWeight(.light)
                            .padding(.horizontal ,UIScreen.screenHeight/50)
                            .padding(.vertical, UIScreen.screenHeight/90)
                            .background((id % 2) == 0 ? jobsDarkBlue : jobsBrightGreen)
                            .cornerRadius(25)
                    })
                }
            }
            .padding(10)
            .background((id % 2) == 0 ? jobsBrightGreen : jobsDarkBlue)
            .cornerRadius(12)
            .padding(20)
        }
    }
}

//struct SuggestedJobCard_Previews: PreviewProvider {
//    static var previews: some View {
//        SuggestedJobCard()
//    }
//}
