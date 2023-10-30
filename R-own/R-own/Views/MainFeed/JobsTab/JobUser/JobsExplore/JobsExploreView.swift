//
//  JobsExploreView.swift
//  R-own
//
//  Created by Aman Sharma on 07/05/23.
//

import SwiftUI

struct JobsExploreView: View {
    
    @StateObject var loginData: LoginViewModel
    
    @StateObject var jobsVM: JobsViewModel
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var userJobService = UserJobService()
    
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        ScrollView {
            VStack{
                //Search Field
                TextField("Search", text: $jobsVM.jobsSearchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                    .padding()
                    .frame(width: UIScreen.screenWidth/1.2)
                    .cornerRadius(5)
                    .overlay{
                        Image("ExploreSearchIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .offset(x: UIScreen.screenWidth/2.9)
                    }
                    .focused($isKeyboardShowing)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                            }
                        }
                    }
                //Filter
                HStack{
                    
                    //Filter Icon
                    Button(action: {
                        jobsVM.filterBottomSheet.toggle()
                    }, label: {
                        Image("JobsFilterIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .padding(.horizontal ,UIScreen.screenHeight/50)
                            .padding(.vertical, UIScreen.screenHeight/90)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(0.5), lineWidth: 1))
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    })
                    .padding(.leading, 10)
                    
                    Spacer()
                    //Filter Tabs
//                    ScrollView(.horizontal){
//                        HStack{
//                            //Tabs
//                            ForEach(1...10, id: \.self) {_ in
//
//                                //Card
//                                FilterCard()
//
//                            }
//                        }
//                    }
                    
                }
                
                //Suggested
                HStack{
                    //Text
                    Text("Suggested Jobs For You ")
                        .font(.system(size: UIScreen.screenHeight/80))
                        .fontWeight(.bold)
                    
                    
                    Spacer()
                    
                    //Text n icon ViewAll
                    Button(action: {
                        
                    }, label: {
                        HStack{
                            Text("View All")
                                .font(.system(size: UIScreen.screenHeight/80))
                                .foregroundColor(jobsBrightGreen)
                            Image(systemName: "chevron.forward")
                                .foregroundColor(jobsBrightGreen)
                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                        }
                    })
                    .padding(.trailing, UIScreen.screenWidth/30)
                    
                }
                .padding(.top, UIScreen.screenHeight/50)
                .padding(.trailing, UIScreen.screenWidth/15)
                
                ScrollView(.horizontal){
                    //Tabs
                    HStack {
                        if globalVM.recentJobs.count > 0{
                            ForEach(0..<globalVM.recentJobs.count, id: \.self) { count in
                                
                                //Card
                                SuggestedJobCard(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, jobs: globalVM.recentJobs[count], profileVM: profileVM, mesiboVM: mesiboVM, id: count)
                                
                                
                            }
                        }
                    }
                }
                
                
                //Recent
                HStack{
                    //Text
                    Text("Recent Job")
                        .font(.system(size: UIScreen.screenHeight/60))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    //Text n icon ViewAll
                    Button(action: {
                        
                    }, label: {
                        HStack{
                            Text("View All")
                                .font(.system(size: UIScreen.screenHeight/80))
                                .foregroundColor(jobsBrightGreen)
                            Image(systemName: "chevron.forward")
                                .foregroundColor(jobsBrightGreen)
                        }
                    })
                    .padding(.trailing, UIScreen.screenWidth/30)
                }
                .padding(.trailing, UIScreen.screenWidth/15)
                
                ScrollView{
                    //Tabs
                    VStack {
                        if globalVM.recentJobs.count > 0{
                            ForEach(0..<globalVM.recentJobs.count, id: \.self) { count in
                                
                                //Card
                                RecentJobView(loginData: loginData, globalVM: globalVM, jobsVM: jobsVM, jobs: globalVM.recentJobs[count], profileVM: profileVM, mesiboVM: mesiboVM)
                                
                            }
                        }
                    }
                }
                .padding(.trailing, UIScreen.screenWidth/15)
            }
            .padding(.leading, UIScreen.screenWidth/15)
        }
        .padding(.top, UIScreen.screenHeight/60)
        .padding(.bottom, UIScreen.screenHeight/10)
        .onAppear{
            userJobService.getRecentJobs(globalVM: globalVM, loginData: loginData)
        }
    }
}

//struct JobsExploreView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobsExploreView()
//    }
//}
