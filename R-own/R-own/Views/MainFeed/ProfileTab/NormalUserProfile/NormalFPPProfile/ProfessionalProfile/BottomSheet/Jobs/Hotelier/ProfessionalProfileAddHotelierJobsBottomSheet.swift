//
//  ProfessionalProfileAddHotelierJobsBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 14/07/23.
//

import SwiftUI
import AlertToast

struct ProfessionalProfileAddHotelierJobsBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    
    @State var companyName: String = ""
    @State var designation: String = ""
    @State var employmentType: String = ""
    @State var jobStart: String = ""
    @State var jobEnd: String = ""
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var alertNoCompany: Bool = false
    @State var alertNoDesignation: Bool = false
    @State var alertNoEmployment: Bool = false
    @State var alertNoJobStart: Bool = false
    @State var alertNoJobEnd: Bool = false
    @State var alertApiCall: Bool = false
    @State var alertJobDiff: Bool = false
    
    @Binding var openAddEducationBottomSheet: Bool
    
    @StateObject var profileService = ProfileService()
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Add new experience")
                        .font(.headline)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                    Spacer()
                }
                VStack{
                    //TextField
                    
                    TextField("Your company name", text: $companyName)
                        .padding()
                        .cornerRadius(7)
                        .overlay{
                            // apply a rounded border
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 0.5)
                            
                        }
                        .overlay{
                            HStack{
                            Text("Company name")
                                .font(.footnote)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .padding(.horizontal,5)
                                .fontWeight(.ultraLight)
                                .offset(x: UIScreen.screenWidth/30, y: -27)
                                Spacer()
                            }
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
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    
                    TextField("Your designation name", text: $designation)
                        .padding()
                        .cornerRadius(7)
                        .overlay{
                            // apply a rounded border
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 0.5)
                            
                        }
                        .overlay{
                            HStack{
                            Text("Designation name")
                                    .font(.footnote)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .padding(.horizontal,5)
                                .fontWeight(.ultraLight)
                                .offset(x: UIScreen.screenWidth/30, y: -27)
                                Spacer()
                            }
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
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    
                    TextField("Your employment type", text: $employmentType)
                        .padding()
                        .cornerRadius(7)
                        .overlay{
                            // apply a rounded border
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 0.5)
                            
                        }
                        .overlay{
                            HStack{
                            Text("Employment Type")
                                    .font(.footnote)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .padding(.horizontal,5)
                                .fontWeight(.ultraLight)
                                .offset(x: UIScreen.screenWidth/30, y: -27)
                                Spacer()
                            }
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
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    
                    HStack{
                        //TextField
                        TextField("XXXX", text: $jobStart)
                            .padding()
                            .keyboardType(.numberPad)
                            .cornerRadius(7)
                            .onChange(of: jobStart) { newValue in
                                let filteredValue = newValue.filter { $0.isNumber }
                                if filteredValue.count > 4 {
                                    jobStart = String(filteredValue.prefix(4))
                                } else {
                                    jobStart = filteredValue
                                }
                            }
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                
                            }
                            .overlay{
                                HStack{
                                    Text("Job Start")
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/30, y: -27)
                                    Spacer()
                                }
                            }
                            .focused($isKeyboardShowing)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                        
                        //TextField
                        TextField("XXXX", text: $jobEnd)
                            .padding()
                            .keyboardType(.numberPad)
                            .cornerRadius(7)
                            .onChange(of: jobEnd) { newValue in
                                if newValue != "Present"{
                                    let filteredValue = newValue.filter { $0.isNumber }
                                    if filteredValue.count > 4 {
                                        jobEnd = String(filteredValue.prefix(4))
                                    } else {
                                        jobEnd = filteredValue
                                    }
                                }
                            }
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                
                            }
                            .overlay{
                                HStack{
                                    Text("Job End")
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/30, y: -27)
                                    Spacer()
                                }
                            }
                            .focused($isKeyboardShowing)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                    }
                    HStack{
                        Spacer()
                        Button(action: {
                            jobEnd = "Present"
                        }, label: {
                            Text("Click here if you're still persuing?")
                                .font(.footnote)
                                .foregroundColor(.black)
                                .fontWeight(.thin)
                        })
                    }
                }
                Button(action: {
                
                    if companyName == ""{
                        alertNoCompany.toggle()
                    } else if designation == "" {
                        alertNoDesignation.toggle()
                    } else if employmentType == "" {
                        alertNoEmployment.toggle()
                    } else if jobStart == ""{
                        alertNoJobStart.toggle()
                    } else if jobEnd == "" {
                        alertNoJobEnd.toggle()
                    } else if jobEnd != "Present"{
                        if Int(jobStart)! > Int(jobEnd)! {
                            alertJobDiff.toggle()
                        }
                    }
                    Task{
                        let res = await profileService.updateExperienceforHotelier(userID: loginData.mainUserID, index: String(loginData.userData.normalUserInfo.count), userDescription: "", jobType: employmentType, jobTitle: designation, hotelCompany: companyName, jobStartYear: jobStart, jobEndYear: jobEnd)
                        if res == "Success"{
                            loginData.userData.hospitalityExpertInfo.append(HospitalityExpertInfoProfile(userDescription: "", jobtype: employmentType, jobtitle: designation, hotelCompany: companyName, jobstartYear: jobStart, jobendYear: jobEnd))
                            openAddEducationBottomSheet.toggle()
                        } else {
                            alertApiCall.toggle()
                        }
                    }
                }, label: {
                    Text("Save")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(greenUi)
                        .padding(.horizontal, UIScreen.screenWidth/6)
                        .padding(.vertical, UIScreen.screenHeight/70)
                        .background(jobsDarkBlue)
                        .cornerRadius(5)
                        .padding(.vertical, UIScreen.screenHeight/80)
                })
                Spacer()
            }
            .padding(.top, UIScreen.screenHeight/30)
            .padding(.bottom, UIScreen.screenHeight/50)
            .padding(.horizontal, UIScreen.screenWidth/30)
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .toast(isPresenting: $alertNoCompany, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Enter Company Name")
        }
        .toast(isPresenting: $alertNoDesignation, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Enter your designation")
        }
        .toast(isPresenting: $alertNoEmployment, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Enter your employment type")
        }
        .toast(isPresenting: $alertNoJobStart, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Enter employment starting year", subTitle: ("Can't find your location, check your permission or enter manually"))
        }
        .toast(isPresenting: $alertNoJobEnd, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Enter employment ending year")
        }
        .toast(isPresenting: $alertApiCall, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Auto Fetch Error", subTitle: ("Can't find your location, check your permission or enter manually"))
        }
        .toast(isPresenting: $alertJobDiff, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Employment start year can't exceed end year")
        }
    }
}

//struct ProfessionalProfileAddHotelierJobsBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfessionalProfileAddHotelierJobsBottomSheet()
//    }
//}
