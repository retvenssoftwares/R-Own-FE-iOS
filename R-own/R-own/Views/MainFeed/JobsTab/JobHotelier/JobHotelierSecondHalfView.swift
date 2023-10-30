//
//  JobHotelierSecondHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct JobHotelierSecondHalfView: View {
    
    @StateObject var jobsVM: JobsViewModel
    
    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                jobsVM.jobsHotelierTabSelected = "Job Posted"
            }, label: {
                HStack{
                    Image("JobsExploreIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                    Text("Job Posted")
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
                .border(width: jobsVM.jobsHotelierTabSelected == "Job Posted" ? 2 : 0,edges: [.top], color: greenUi)
                
            })
            Spacer()
            Button(action: {
                jobsVM.jobsHotelierTabSelected = "Explore Requesting"
            }, label: {
                HStack{
                    Image("JobsUserIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                    Text("Explore Requesting")
                        .foregroundColor(.black)
                        .font(.body)
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
                .border(width: jobsVM.jobsHotelierTabSelected == "Explore Requesting" ? 2 : 0,edges: [.top], color: greenUi)
                
            })
            Spacer()
//            Button(action: {
//                jobsVM.jobsHotelierTabSelected = "Explore Employees"
//            }, label: {
//                HStack{
//                    Image("JobsUserIcon")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
//                    Text("Explore Employees")
//                        .foregroundColor(.black)
//                        .font(.system(size: UIScreen.screenHeight/100))
//                        .fontWeight(.bold)
//                        .multilineTextAlignment(.leading)
//                        .frame(alignment: .leading)
//                }
//                .padding(.horizontal, 10)
//                .padding()
//                .background(.white)
//                .cornerRadius(4)
//                .clipped()
//                .shadow(radius: 4)
//                .border(width: jobsVM.jobsHotelierTabSelected == "Explore Employees" ? 2 : 0,edges: [.top], color: greenUi)
//            })
            Spacer()
        }
    }
}
//struct JobHotelierSecondHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobHotelierSecondHalfView()
//    }
//}
