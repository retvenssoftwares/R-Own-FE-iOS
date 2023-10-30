//
//  JobPostedView.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct JobPostedView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var createPostVM: CreatePostViewModel
    
    @State var navigateToPostAJob: Bool = false
    
    @FocusState private var isKeyboardShowing: Bool
    
    @StateObject var hotelierService = HotelierJobService()
    
    var body: some View {
            ZStack {
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
                                    .shadow(radius: 10)
                            })
                            .padding(.leading, 10)
                            
                            
                            //Filter Tabs
//                            ScrollView(.horizontal){
//                                HStack{
//                                    //Tabs
//                                    ForEach(1...10, id: \.self) {_ in
//
//                                        //Card
//                                        FilterCard()
//
//                                    }
//                                }
//                            }
                            
                        }
                        
                        //Suggested
//                        HStack{
//                            //Text
//                            Text("Recently Viewed Jobs")
//                                .font(.system(size: UIScreen.screenHeight/80))
//                                .fontWeight(.bold)
//
//
//                            Spacer()
//
//
//                        }
//                        .padding(.top, UIScreen.screenHeight/50)
//                        .padding(.trailing, UIScreen.screenWidth/15)
//
//                        ScrollView(.horizontal){
//                            //Tabs
//                            HStack {
//                                ForEach(1...10, id: \.self) { id in
//
//                                    //Card
//                                    //                                SuggestedJobCard(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, id: id)
//
//
//                                }
//                            }
//                        }
                        
                        
                        //Recent
                        HStack{
                            //Text
                            Text("Jobs You Posted")
                                .font(.system(size: UIScreen.screenHeight/60))
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            //Text n icon ViewAll
//                            Button(action: {
//
//                            }, label: {
//                                HStack{
//                                    Text("View All")
//                                        .font(.system(size: UIScreen.screenHeight/80))
//                                        .foregroundColor(jobsBrightGreen)
//                                    Image(systemName: "chevron.forward")
//                                        .foregroundColor(jobsBrightGreen)
//                                }
//                            })
//                            .padding(.trailing, UIScreen.screenWidth/30)
                        }
                        .padding(.trailing, UIScreen.screenWidth/15)
                        .padding(.vertical, UIScreen.screenHeight/60)
                        
                        ScrollView{
                            //Tabs
                            VStack {
                                if globalVM.jobListByHotelOwner.count > 0 {
                                    ForEach(0..<globalVM.jobListByHotelOwner.count, id: \.self) { count in
                                        
                                        //Card
                                        PostedJobsCard(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, jobs: globalVM.jobListByHotelOwner[count])
                                        
                                    }
                                } else {
                                    Text(("You havent posted any jobs yet"))
                                }
                            }
                        }
                        .padding(.trailing, UIScreen.screenWidth/15)
                    }
                    .padding(.leading, UIScreen.screenWidth/15)
                }
            Button(action: {
                print("Post a job")
                navigateToPostAJob.toggle()
            }, label: {
                HStack{
                    Image("EditProfileIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                    Text("Post A Job")
                        .font(.system(size: UIScreen.screenHeight/90))
                        .fontWeight(.thin)
                        .foregroundColor(.black)
                }
                .padding()
                .background(greenUi)
                .cornerRadius(5)
            })
            .offset(x: UIScreen.screenWidth/4, y: UIScreen.screenHeight/4)
            .navigationDestination(isPresented: $navigateToPostAJob, destination: {
                PostAJobView(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM, createPostVM: createPostVM)
            })
        }
        .padding(.top, UIScreen.screenHeight/60)
        .onAppear{
            hotelierService.getJobsByUserID(globalVM: globalVM, loginData: loginData)
        }
    }
}

//struct JobPostedView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobPostedView()
//    }
//}
