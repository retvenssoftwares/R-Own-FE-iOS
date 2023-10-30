//
//  SuggestedJobListView.swift
//  R-own
//
//  Created by Aman Sharma on 26/05/23.
//

import SwiftUI

struct SuggestedJobListView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Suggested Jobs For You")
                
                ScrollView{
                    //Tabs
                    VStack {
                        ForEach(1...10, id: \.self) {_ in
                            
                            //Card
//                            RecentJobView(loginData: loginData, jobsVM: jobsVM)
                            
                        }
                    }
                }
                .padding(.trailing, UIScreen.screenWidth/15)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct SuggestedJobListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SuggestedJobListView()
//    }
//}
