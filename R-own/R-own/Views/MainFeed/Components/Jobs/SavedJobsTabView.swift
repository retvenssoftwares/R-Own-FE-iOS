//
//  SavedJobsTabView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct SavedJobsTabView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var companyLogo: String
    @State var navigateToJobDetails: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack{
                HStack{
                    Image(companyLogo == "" ? "JobsCompanyDemoLogo" : "companyLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                        .cornerRadius(5)
                    VStack{
                        Text("Front Office Research")
                            .font(.system(size: UIScreen.screenHeight/60))
                            .foregroundColor(.black)
                        Text("Mariott Hotels")
                            .font(.system(size: UIScreen.screenHeight/110))
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Image("JobsExploreIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                }
                HStack{
                    Text("Full Time")
                        .font(.system(size: UIScreen.screenHeight/110))
                        .foregroundColor(.white)
                        .padding(20)
                        .background(.white.opacity(0.5))
                    Text("Remote")
                        .font(.system(size: UIScreen.screenHeight/110))
                        .foregroundColor(.white)
                        .padding(20)
                        .background(.white.opacity(0.5))
                }
                HStack{
                    Text("$12-15K/Month")
                        .font(.system(size: UIScreen.screenHeight/80))
                        .foregroundColor(.black)
                        .padding(20)
                        .background(.white.opacity(0.5))
                    Spacer()
                    Button(action: {
                        navigateToJobDetails = true
                    }, label: {
                        Text("Apply Now")
                            .font(.system(size: UIScreen.screenHeight/80))
                            .foregroundColor(.black)
                            .fontWeight(.light)
                            .padding(20)
                            .background(jobsBrightGreen)
                            .cornerRadius(5)
                    })
                    .navigationDestination(isPresented: $navigateToJobDetails, destination: {
                        JobDetailsView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, jobID: "", profileVM: profileVM, mesiboVM: mesiboVM)
                    })
                    NavigationLink(isActive: $navigateToJobDetails, destination: {
                        JobDetailsView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, jobID: "", profileVM: profileVM, mesiboVM: mesiboVM)
                    }, label: {
                        Text("")
                    })
                }
            }
            .frame(width: UIScreen.screenWidth/1.3)
            .padding(10)
            .background(.white)
            .cornerRadius(5)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
        .padding(20)
        }
        .onAppear{
            navigateToJobDetails = false
        }
    }
}

//struct SavedJobsTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedJobsTabView()
//    }
//}
