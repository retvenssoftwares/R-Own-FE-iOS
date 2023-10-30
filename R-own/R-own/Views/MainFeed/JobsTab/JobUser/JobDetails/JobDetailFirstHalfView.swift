//
//  JobDetailFirstHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 09/05/23.
//

import SwiftUI
import Shimmer

struct JobDetailFirstHalfView: View {
    
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack{
            VStack{
                AsyncImage(url: URL(string: globalVM.jobDetails.hotelLogoURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                        .padding(UIScreen.screenHeight/50)
                } placeholder: {
                    //put your placeholder here
                    Rectangle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                        .shimmering(active: true)
                }
                
                Text(globalVM.jobDetails.jobTitle)
                    .font(.system(size: UIScreen.screenHeight/35))
                    .fontWeight(.semibold)
                Text(globalVM.jobDetails.designationType)
                    .font(.system(size: UIScreen.screenHeight/60))
                    .fontWeight(.semibold)
            }
            
            HStack{
                Text(globalVM.jobDetails.companyName)
                    .font(.system(size: UIScreen.screenHeight/80))
                    .fontWeight(.thin)
                Text(".")
                    .font(.system(size: UIScreen.screenHeight/80))
                    .fontWeight(.thin)
                Text(globalVM.jobDetails.jobLocation)
                    .font(.system(size: UIScreen.screenHeight/80))
                    .fontWeight(.thin)
            }
            .padding()
            
            HStack{
                Text(globalVM.jobDetails.jobType)
                    .font(.system(size: UIScreen.screenHeight/90))
                    .fontWeight(.thin)
                    .foregroundColor(jobsTextDarkBlue)
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .padding(.vertical, UIScreen.screenHeight/80)
                    .background(jobsTextLightBlue)
                    .cornerRadius(15)
                    .padding(10)
//                Text(globalVM.jobDetails.jobCategory)
//                    .font(.system(size: UIScreen.screenHeight/90))
//                    .fontWeight(.thin)
//                    .foregroundColor(jobsTextDarkBlue)
//                    .padding(.horizontal, UIScreen.screenWidth/40)
//                    .padding(.vertical, UIScreen.screenHeight/80)
//                    .background(jobsTextLightBlue)
//                    .cornerRadius(15)
//                    .padding(10)
            }
        }
        
    }
}

//struct JobDetailFirstHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobDetailFirstHalfView()
//    }
//}
