//
//  RequestJobView.swift
//  R-own
//
//  Created by Aman Sharma on 07/05/23.
//

import SwiftUI

struct RequestJobView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var userJobService = UserJobService()
    @StateObject var locationVM = LocationViewModel()
    
    var body: some View {
        ZStack{
            
            VStack{
                //textfield of deppt youre requesting for
                
                TextField("Enter Department You’re Requesting For", text: $jobsVM.departmentRequestedFor)
                    .disabled(true)
                    .padding()
                    .cornerRadius(7)
                    .overlay{
                        // apply a rounded border
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 0.5)
                        Text("Department You’re Requesting For")
                            .font(.system( size: 14))
                            .foregroundColor(.black)
                            .background(Color.white)
                            .padding(.horizontal,5)
                            .fontWeight(.ultraLight)
                            .offset(x: -UIScreen.screenWidth/3.5, y: -27)
                        
                    }
                    .padding(.vertical, UIScreen.screenHeight/50)
                    .padding(.horizontal, UIScreen.screenWidth/30)
                    .onTapGesture {
                        jobsVM.requestedDepartmentBottomSheet.toggle()
                    }
                
                // textfield for designation
                
                TextField("Designation You’re Requesting For", text: $jobsVM.designationRequestedFor)
                    .disabled(true)
                    .padding()
                    .cornerRadius(7)
                    .overlay{
                        // apply a rounded border
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 0.5)
                        Text("Enter Designation You’re Requesting For")
                            .font(.system( size: 14))
                            .foregroundColor(.black)
                            .background(Color.white)
                            .padding(.horizontal,5)
                            .fontWeight(.ultraLight)
                            .offset(x: -UIScreen.screenWidth/3.6, y: -27)
                        
                    }
                    .padding(.vertical, UIScreen.screenHeight/50)
                    .padding(.horizontal, UIScreen.screenWidth/30)
                    .onTapGesture {
                        jobsVM.requestedDesignationBottomSheet.toggle()
                    }
                
                // employment type
                
                TextField("Employment Type", text: $jobsVM.employmentTypeRequestedFor)
                    .disabled(true)
                    .padding()
                    .cornerRadius(7)
                    .overlay{
                        // apply a rounded border
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 0.5)
                        Text("Enter Employment Type")
                            .font(.system( size: 14))
                            .foregroundColor(.black)
                            .background(Color.white)
                            .padding(.horizontal,5)
                            .fontWeight(.ultraLight)
                            .offset(x: -UIScreen.screenWidth/3, y: -27)
                        
                    }
                    .padding(.vertical, UIScreen.screenHeight/50)
                    .padding(.horizontal, UIScreen.screenWidth/30)
                    .onTapGesture {
                        jobsVM.requestedEmploymentBottomSheet.toggle()
                    }
                
                //preffered job location
                
                TextField("Preferred Job Location", text: $jobsVM.jobLocationRequestedFor)
                    .disabled(true)
                    .padding()
                    .cornerRadius(7)
                    .overlay{
                        // apply a rounded border
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 0.5)
                        Text("Enter Preferred Job Location")
                            .font(.system( size: 14))
                            .foregroundColor(.black)
                            .background(Color.white)
                            .padding(.horizontal,5)
                            .fontWeight(.ultraLight)
                            .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                        
                    }
                    .padding(.vertical, UIScreen.screenHeight/50)
                    .padding(.horizontal, UIScreen.screenWidth/30)
                    .onTapGesture {
//                        locationVM.getCountry(globalVM: globalVM)
                        jobsVM.requestedLocationBottomSheet.toggle()
                    }
                
                //notice period
                
                TextField("Notice Period", text: $jobsVM.noticePeriodRequestedFor)
                    .disabled(true)
                    .padding()
                    .cornerRadius(7)
                    .overlay{
                        // apply a rounded border
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 0.5)
                        Text("Enter Notice Period")
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
                
                //expected ctc
                
                TextField("Expected CTC", text: $jobsVM.expectedCTCRequestedFor)
                    .disabled(true)
                    .padding()
                    .cornerRadius(7)
                    .overlay{
                        // apply a rounded border
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 0.5)
                        Text("Enter Expected CTC")
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
                        jobsVM.requestedCTCBottomSheet.toggle()
                    }
                Spacer()
                
                //button post
                if loginData.jobRequested {
                    Button(action: {
                        userJobService.updateJobRequest(loginData: loginData, designationType: jobsVM.designationRequestedFor, noticePeriod: jobsVM.noticePeriodRequestedFor, preferredLocation: jobsVM.jobLocationRequestedFor, expectedCTC: jobsVM.expectedCTCRequestedFor, employmentType: jobsVM.employmentTypeRequestedFor, department: jobsVM.departmentRequestedFor)
                    }) {
                        Text("Update Job")
                            .foregroundColor(.black)
                            .font(.system(size: 25))
                            .fontWeight(.light)
                            .padding(.vertical, 10)
                            .padding(.horizontal, UIScreen.screenWidth/5)
                            .background(greenUi)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                    .padding(.bottom, UIScreen.screenHeight/40)
                } else {
                    Button(action: {
                        userJobService.postRequestJob(loginData: loginData, designationType: jobsVM.designationRequestedFor, noticePeriod: jobsVM.noticePeriodRequestedFor, preferredLocation: jobsVM.jobLocationRequestedFor, expectedCTC: jobsVM.expectedCTCRequestedFor, employmentType: jobsVM.employmentTypeRequestedFor, department: jobsVM.departmentRequestedFor)
                        loginData.jobRequested = true
                    }) {
                        Text("Post My Request")
                            .foregroundColor(.black)
                            .font(.system(size: 25))
                            .fontWeight(.light)
                            .padding(.vertical, 10)
                            .padding(.horizontal, UIScreen.screenWidth/5)
                            .background(greenUi)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                    .padding(.bottom, UIScreen.screenHeight/40)
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/40)
            .padding(.top, UIScreen.screenHeight/50)
            .padding(.bottom, UIScreen.screenHeight/10)
        }
        .onAppear{
            userJobService.getJobRequest(globalVM: globalVM, loginData: loginData, jobsVM: jobsVM)
            userJobService.getDepartment(globalVM: globalVM, loginData: loginData)
            userJobService.getDesignations(globalVM: globalVM, loginData: loginData)
        }
    }
}

//struct RequestJobView_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestJobView()
//    }
//}
