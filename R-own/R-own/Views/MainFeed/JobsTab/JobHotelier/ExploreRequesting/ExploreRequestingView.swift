//
//  ExploreRequestingView.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct ExploreRequestingView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @State var appliedJob: Bool = false
    
    @FocusState private var isKeyboardShowing: Bool
    
    @StateObject var hotelierJobService = HotelierJobService()
    
    var body: some View {
        VStack {
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
                            .shadow(radius: 10)
                    })
                    .padding(.leading, 10)
                    
                    
                    //Filter Tabs
                    ScrollView(.horizontal){
                        HStack{
                            //Tabs
                            ForEach(1...10, id: \.self) {_ in
                                
                                //Card
                                FilterCard()
                                
                            }
                        }
                    }
                    
                }
                ScrollView {
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Lot of Employees are waiting to be hired!")
                                    .font(.system(size: UIScreen.screenHeight/60))
                                    .fontWeight(.bold)
                                Text("Find out employees waiting to be hired ")
                                    .font(.system(size: UIScreen.screenHeight/80))
                                    .fontWeight(.bold)
                            }
                            Spacer()
                        }
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        
                        //Suggested
                        HStack{
                            //Text
                            Text("Popular in their fields")
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
                            
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .padding(.vertical, UIScreen.screenHeight/70)
                        
                        ScrollView(.horizontal){
                            //Tabs
                            HStack {
                                if globalVM.requestedUsersList.count > 0 {
                                    ForEach(0..<(globalVM.requestedUsersList.count < 6 ? globalVM.requestedUsersList.count : 5), id: \.self) { count in
                                        
                                        //Card
//                                        if globalVM.requestedUsersList[count].status == "requested" {
                                            PopularInTheirFieldCard(jobProfile: globalVM.requestedUsersList[count])
//                                        }
                                    }
                                } else {
                                    Text("There are no candidates right now")
                                }
                            }
                        }
                        
                        VStack{
                            //Recent
                            HStack{
                                //Text
                                Text("Matches Job Criteria")
                                    .font(.system(size: UIScreen.screenHeight/70))
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
                            }
                            
                            //Tabs
                            VStack {
                                if globalVM.requestedUsersList.count > 0 {
                                    ForEach(0..<(globalVM.requestedUsersList.count < 9 ? globalVM.requestedUsersList.count : 8), id: \.self) { count in
                                        
                                        //Card
//                                        if globalVM.requestedUsersList[count].status == "requested" {
                                            MatchesJobCriteriaCard(jobProfile: globalVM.requestedUsersList[count])
//                                        }
                                    }
                                } else {
                                    Text("There are no candidates right now")
                                }
                            }
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    }
                }
            }
            .padding(.leading, UIScreen.screenWidth/15)
        }
        .padding(.top, UIScreen.screenHeight/60)
        .onAppear{
            hotelierJobService.getJobRequests(globalVM: globalVM, loginData: loginData)
        }
    }
}

//struct ExploreRequestingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreRequestingView()
//    }
//}
