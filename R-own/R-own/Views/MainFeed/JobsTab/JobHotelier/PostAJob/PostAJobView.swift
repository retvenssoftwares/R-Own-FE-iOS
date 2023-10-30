//
//  PostAJobView.swift
//  R-own
//
//  Created by Aman Sharma on 01/06/23.
//

import SwiftUI

struct PostAJobView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var createPostVM: CreatePostViewModel
    
    
    @StateObject var hotelService = HotelService()
    @StateObject var hotelierJobService = HotelierJobService()
    @StateObject var userJobService = UserJobService()
    
    @FocusState private var isKeyboardShowing: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    BasicNavbarView(navbarTitle: "Post A Job")
                    ScrollView {
                        VStack{
                            HStack{
                                Text("Add job details")
                                    .font(.system(size: UIScreen.screenHeight/60))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding(.horizontal, UIScreen.screenWidth/40)
                            
                            TextField("Job job title", text: $jobsVM.postAjobTitle)
                                .disabled(true)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                    Text("Job Title")
                                        .font(.system( size: 14))
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/2.9, y: -27)
                                    
                                }
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            TextField("Job company", text: $jobsVM.postAcompany)
                                .disabled(true)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                    Text("Company Name")
                                        .font(.system( size: 14))
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/2.9, y: -27)
                                    
                                }
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                .onTapGesture {
                                    hotelService.getHotelsByUserID(globalVM: globalVM, loginData: loginData, userID: loginData.mainUserID, viewerID: loginData.mainUserID)
                                    jobsVM.showCompanyNameBottomSheet = true
                                }
                            
                            TextField("Job Designation", text: $jobsVM.postAJobDesignation)
                                .disabled(true)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                    Text("Designation")
                                        .font(.system( size: 14))
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/2.9, y: -27)
                                    
                                }
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                .onTapGesture {
                                    jobsVM.requestedDesignationBottomSheet = true
                                }
                            
                        TextField("Job description", text: $jobsVM.postAjobDescription)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                Text("Job Description")
                                    .font(.system( size: 14))
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: -UIScreen.screenWidth/2.9, y: -27)
                                
                            }
                            .focused($isKeyboardShowing)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                        
                        TextField("Skill Required", text: $jobsVM.postAskillRecquired)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                Text("Skill Recquired")
                                    .font(.system( size: 14))
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: -UIScreen.screenWidth/2.9, y: -27)
                                
                            }
                            .focused($isKeyboardShowing)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                        
                            
                            TextField("Job location", text: $jobsVM.postAjobLocation)
                                .disabled(true)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                    Text("Job Location")
                                        .font(.system( size: 14))
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/2.9, y: -27)
                                    
                                }
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                .onTapGesture {
                                    loginData.mainLocationBottomSheet.toggle()
                                }
                            
                            TextField("Job Notice Period", text: $jobsVM.postAJobNoticePeriod)
                                .disabled(true)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                    Text("Notice Period")
                                        .font(.system( size: 14))
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/2.9, y: -27)
                                    
                                }
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                .onTapGesture {
                                    jobsVM.requestedNoticePeriodBottomSheet.toggle()
                                }
                            HStack{
                                //TextField
                                    TextField("Select workplace type", text: $jobsVM.postAworkplaceType)
                                        .padding()
                                        .keyboardType(.numberPad)
                                        .cornerRadius(7)
                                        .overlay{
                                            // apply a rounded border
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(.gray, lineWidth: 0.5)
                                            Text("Workplace type")
                                                .font(.system( size: 14))
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: -UIScreen.screenWidth/8, y: -27)
                                            
                                        }
                                        .focused($isKeyboardShowing)
                                        .padding(.vertical, UIScreen.screenHeight/50)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                
                                //TextField
                                    TextField("Job type", text: $jobsVM.postAjobType)
                                    .disabled(true)
                                        .padding()
                                        .keyboardType(.numberPad)
                                        .cornerRadius(7)
                                        .overlay{
                                            // apply a rounded border
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(.gray, lineWidth: 0.5)
                                            Text("Job Type")
                                                .font(.system( size: 14))
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: -UIScreen.screenWidth/8, y: -27)
                                            
                                        }
                                        .padding(.vertical, UIScreen.screenHeight/50)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                        .onTapGesture {
                                            jobsVM.shoJobPostJobTypeBottomSheet.toggle()
                                        }
                            }
                            
                            HStack{
                                //TextField
                                    TextField("Job min salary", text: $jobsVM.postAminSalary)
                                        .padding()
                                        .keyboardType(.numberPad)
                                        .cornerRadius(7)
                                        .overlay{
                                            // apply a rounded border
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(.gray, lineWidth: 0.5)
                                            Text("Min Salary")
                                                .font(.system( size: 14))
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: -UIScreen.screenWidth/8, y: -27)
                                            
                                        }
                                        .focused($isKeyboardShowing)
                                        .padding(.vertical, UIScreen.screenHeight/50)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                
                                //TextField
                                    TextField("Job max Salary", text: $jobsVM.postAmaxSalary)
                                        .padding()
                                        .keyboardType(.numberPad)
                                        .cornerRadius(7)
                                        .overlay{
                                            // apply a rounded border
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(.gray, lineWidth: 0.5)
                                            Text("Max Salary")
                                                .font(.system( size: 14))
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: -UIScreen.screenWidth/8, y: -27)
                                            
                                        }
                                        .focused($isKeyboardShowing)
                                        .padding(.vertical, UIScreen.screenHeight/50)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                            }
                            
                        }
                    }
                    
                    Button(action: {
                        hotelierJobService.postJob(loginData: loginData, jobsVM: jobsVM)
                        dismiss()
                    }, label: {
                        Text("Post Job")
                            .font(.system(size: UIScreen.screenHeight/70))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .padding(.horizontal, UIScreen.screenWidth/4)
                            .padding(.vertical, UIScreen.screenHeight/40)
                            .background(greenUi)
                            .background()
                    })
                }
                .padding(.horizontal, UIScreen.screenWidth/50)
                .padding(.vertical, UIScreen.screenHeight/70)
                EmploymentTypeBottomSheet(loginData: loginData)
                JobPostCompanyListBottomSheet(globalVM: globalVM, jobsVM: jobsVM, hotelName: $jobsVM.postAcompany, hotelID: $jobsVM.postAcompanyID)
                JobPostJobTypeBottomSheet(jobsVM: jobsVM, jobType: $jobsVM.postAjobType)
                MainLocationBottomSheetView(loginData: loginData, globalVM: globalVM, location: $jobsVM.postAjobLocation)
                JobPostDesignationList(loginData: loginData, jobsVM: jobsVM, globalVM: globalVM)
                JobPostNoticePeriodBottomSheet(loginData: loginData, jobsVM: jobsVM)
//                CountryBottomSheetView(loginData: loginData, globalVM: globalVM, country: $country, countryCode: $countryCode)
//                StateBottomSheetView(loginData: loginData, globalVM: globalVM, state: $state, stateCode: $stateCode, countryCode: $countryCode)
//                CityBottomSheetView(loginData: loginData, globalVM: globalVM, city: $city, countryCode: $countryCode, stateCode: $stateCode)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            userJobService.getDesignations(globalVM: globalVM, loginData: loginData)
        }
    }
}

//struct PostAJobView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostAJobView()
//    }
//}
