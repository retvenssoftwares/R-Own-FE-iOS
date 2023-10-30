//
//  AppliedJobsCardView.swift
//  R-own
//
//  Created by Aman Sharma on 26/05/23.
//

import SwiftUI
import Shimmer

struct AppliedJobsCardView: View {
    
    @State var jobs: AppliedJobsModel
    
    
    @State private var currentUrl: URL?
    var body: some View {
        VStack{
            VStack{
                HStack{
                    AsyncImage(url: URL(string: jobs.jobData.hotelLogoURL)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                            .cornerRadius(5)
                    } placeholder: {
                        //put your placeholder here
                        Rectangle()
                            .fill(lightGreyUi)
                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                            .shimmering(active: true)
                    }
                    VStack(alignment: .leading){
                        Text(jobs.jobData.jobTitle)
                            .font(.system(size: UIScreen.screenHeight/60))
                        Text(jobs.jobData.companyName)
                            .font(.system(size: UIScreen.screenHeight/90))
                    }
                    .padding(.horizontal, UIScreen.screenWidth/30)
                    Spacer()
                    Text(jobs.status)
                        .font(.system(size: UIScreen.screenHeight/80))
                        .fontWeight(.bold)
                        .padding(.horizontal ,UIScreen.screenHeight/50)
                        .padding(.vertical, UIScreen.screenHeight/90)
                        .background(jobsBrightGreen)
                        .cornerRadius(5)
                        .padding(.horizontal,  UIScreen.screenWidth/30)
                }
                .padding(.horizontal, UIScreen.screenWidth/40)
                HStack{
                    Text(jobs.jobData.jobType)
                        .font(.system(size: UIScreen.screenHeight/110))
                        .foregroundColor(.white)
                        .padding(.horizontal ,UIScreen.screenHeight/50)
                        .padding(.vertical, UIScreen.screenHeight/90)
                        .background(jobsDarkBlue)
                        .cornerRadius(5)
                        .padding(5)
                    Text(jobs.jobData.jobCategory)
                        .font(.system(size: UIScreen.screenHeight/110))
                        .foregroundColor(.white)
                        .padding(.horizontal ,UIScreen.screenHeight/50)
                        .padding(.vertical, UIScreen.screenHeight/90)
                        .background(jobsDarkBlue)
                        .cornerRadius(5)
                        .padding(5)
                }
            }
            .padding(.vertical, UIScreen.screenHeight/50)
            .padding(.horizontal, UIScreen.screenWidth/20)
            .background(.white)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.5), radius: 5)
            .padding(.horizontal, UIScreen.screenWidth/10)
            Divider()
                .padding(.vertical, UIScreen.screenHeight/50)
        }
    }
}
//
//struct AppliedJobsCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppliedJobsCardView()
//    }
//}
