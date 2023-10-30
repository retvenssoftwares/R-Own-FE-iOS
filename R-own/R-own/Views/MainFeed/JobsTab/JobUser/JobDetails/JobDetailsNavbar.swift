//
//  JobDetailsNavbar.swift
//  R-own
//
//  Created by Aman Sharma on 27/05/23.
//

import SwiftUI

struct JobDetailsNavbar: View {
    
    
    @StateObject var jobsVM: JobsViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack{
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.backward.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenWidth/40, height: UIScreen.screenHeight/70)
                    .foregroundColor(.black)
            })
            
            Spacer()
            
            Text("Job Detail")
                .font(.system(size: UIScreen.screenHeight/60))
                .fontWeight(.semibold)
            
            
            Spacer()
            
            Button(action: {
                jobsVM.bookmarkedJob.toggle()
            }, label: {
                Image(jobsVM.bookmarkedJob ? "JobsBookMarkedIcon" : "JobsExploreIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
            })
            
        }
    }
}

//struct JobDetailsNavbar_Previews: PreviewProvider {
//    static var previews: some View {
//        JobDetailsNavbar()
//    }
//}
