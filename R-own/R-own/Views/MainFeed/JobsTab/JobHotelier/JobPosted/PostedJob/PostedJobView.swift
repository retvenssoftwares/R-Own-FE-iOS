//
//  PostedJobView.swift
//  R-own
//
//  Created by Aman Sharma on 26/05/23.
//

import SwiftUI

struct PostedJobView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Recently Posted Jobs")
                
                ScrollView{
                    //Tabs
                    VStack {
                        ForEach(1...10, id: \.self) {_ in
                            
                            //Card
//                            PostedJobsCard(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM)
                            
                        }
                    }
                }
                .padding(.trailing, UIScreen.screenWidth/15)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct PostedJobView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostedJobView()
//    }
//}
