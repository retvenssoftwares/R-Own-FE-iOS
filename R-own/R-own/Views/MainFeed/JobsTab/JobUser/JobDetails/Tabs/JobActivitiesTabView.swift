//
//  JobActivitiesTabView.swift
//  R-own
//
//  Created by Aman Sharma on 09/05/23.
//

import SwiftUI

struct JobActivitiesTabView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    
    
    var body: some View {
        ScrollView{
            VStack {
                HStack{
                    VStack(alignment: .leading){
                        Text("Applied for the job")
                            .font(.system(size: UIScreen.screenHeight/60))
                            .fontWeight(.bold)
                            .padding(.bottom, UIScreen.screenHeight/80)
                        Text("Successfully, applied for the job and uploaded the resume.")
                            .font(.system(size: UIScreen.screenHeight/90))
                            .padding(.bottom, UIScreen.screenHeight/80)
                    }
                    Spacer()
                    Image("JobActivityDone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                }
                HStack{
                    VStack(alignment: .leading){
                        Text("Employer viewed your resume ")
                            .font(.system(size: UIScreen.screenHeight/60))
                            .fontWeight(.bold)
                            .padding(.bottom, UIScreen.screenHeight/80)
                        Text("Employer, successfully viewed your resume")
                            .font(.system(size: UIScreen.screenHeight/90))
                            .padding(.bottom, UIScreen.screenHeight/80)
                    }
                    Spacer()
                    Image("JobActivityDone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                }
                HStack{
                    VStack(alignment: .leading){
                        Text("Current Status ")
                            .font(.system(size: UIScreen.screenHeight/60))
                            .fontWeight(.bold)
                            .padding(.bottom, UIScreen.screenHeight/80)
                        Text("On hold/scheduled/criteria dosen’t matched ")
                            .font(.system(size: UIScreen.screenHeight/90))
                            .padding(.bottom, UIScreen.screenHeight/80)
                    }
                    Spacer()
                    Image("JobActivityDone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                }
                HStack{
                    VStack(alignment: .leading){
                        Text("Final Status ")
                            .font(.system(size: UIScreen.screenHeight/60))
                            .fontWeight(.bold)
                            .padding(.bottom, UIScreen.screenHeight/80)
                        Text("Hired/Rejected/Further Round")
                            .font(.system(size: UIScreen.screenHeight/90))
                            .padding(.bottom, UIScreen.screenHeight/80)
                    }
                    Spacer()
                    Image("JobActivityDone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/30)
        }
    }
}

//struct JobActivitiesTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobActivitiesTabView()
//    }
//}
