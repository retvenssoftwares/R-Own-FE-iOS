//
//  HospitalityExpertBasicInfoView.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI
import AlertToast

struct HospitalityExpertBasicInfoView: View {
    
    //userinfo
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @StateObject var hotelExpertPCS = HotelExpertUserProfileCompletionService()
    @StateObject var userPCS = UserProfileCompletionService()
    
    @State var navigateToMainFeed: Bool = false
    
    @State var alertCompanyName: Bool = false
    @State var alertEmploymentType: Bool = false
    @State var alertJobTitlw: Bool = false
    @State var alertJobStart: Bool = false
    @State var alertJobEnd: Bool = false
    @State var alertJobEndGreaterThanStart: Bool = false
    @State var alertError: Bool = false
    
    @StateObject var profileService = ProfileService()
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var isLoading: Bool = true
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    //Text Nav
                    Text("Your information helps you discover new community, peoples and jobs")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, UIScreen.screenHeight/40)
                        .fontWeight(.bold)
                        .padding(.top, UIScreen.screenHeight/50)
                    
                    //TextField recent job title
                    
                        TextField("Select Job Title", text: $loginData.mainUserJobTitle)
                            .disabled(true)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                            .overlay{
                                // apply a rounded border
                                VStack{
                                    HStack{
                                        Text("Most recent job title")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                            .fontWeight(.ultraLight)
                                            .offset(y: -UIScreen.screenHeight/100)
                                        Spacer()
                                    }
                                    Spacer()
                                }

                            }
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .onTapGesture {
                                loginData.showJobSheet = true
                            }
                    
                    //TextField employment type
                    
                        TextField("Select Employment Type", text: $loginData.mainUserEmploymentType)
                            .disabled(true)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                            .overlay{
                                // apply a rounded border
                                VStack{
                                    HStack{
                                        Text("Employment Type")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                            .fontWeight(.ultraLight)
                                            .offset(y: -UIScreen.screenHeight/100)
                                        Spacer()
                                    }
                                    Spacer()
                                }

                            }
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .onTapGesture {
                                loginData.showEmploymentTypeSheet =  true
                            }
                    
                    //TextField recent company
                    
                        TextField("Select your recent hotel", text: $loginData.mainUserCompany)
                            .disabled(true)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                            .overlay{
                                // apply a rounded border
                                VStack{
                                    HStack{
                                        Text("Recent Hotel You’re Working for")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                            .fontWeight(.ultraLight)
                                            .offset(y: -UIScreen.screenHeight/100)
                                        Spacer()
                                    }
                                    Spacer()
                                }

                            }
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .onTapGesture {
                                loginData.showHotelSheet = true
                            }
                    VStack{
                        HStack{
                            //TextField Job Start
                            TextField("XXXX", text: $loginData.mainUserJobStart)
                                .padding()
                                .keyboardType(.numberPad)
                                .cornerRadius(7)
                                .onChange(of: loginData.mainUserJobStart) { newValue in
                                    let filteredValue = newValue.filter { $0.isNumber }
                                    if filteredValue.count > 4 {
                                        loginData.mainUserJobStart = String(filteredValue.prefix(4))
                                    } else {
                                        loginData.mainUserJobStart = filteredValue
                                    }
                                }
                                .overlay{
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                }
                                .overlay{
                                    // apply a rounded border
                                    VStack{
                                        HStack{
                                            Text("Job Start")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal, UIScreen.screenWidth/30)
                                                .fontWeight(.ultraLight)
                                                .offset(y: -UIScreen.screenHeight/100)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            //TextField Job End
                            TextField("XXXX", text: $loginData.mainUserJobEnd)
                                .padding()
                                .keyboardType(.numberPad)
                                .cornerRadius(7)
                                .onChange(of: loginData.mainUserJobEnd) { newValue in
                                    if newValue != "Present"{
                                        let filteredValue = newValue.filter { $0.isNumber }
                                        if filteredValue.count > 4 {
                                            loginData.mainUserJobEnd = String(filteredValue.prefix(4))
                                        } else {
                                            loginData.mainUserJobEnd = filteredValue
                                        }
                                    }
                                }
                                .overlay{
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                }
                                .overlay{
                                    // apply a rounded border
                                    VStack{
                                        HStack{
                                            Text("Job End")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal, UIScreen.screenWidth/30)
                                                .fontWeight(.ultraLight)
                                                .offset(y: -UIScreen.screenHeight/100)
                                            Spacer()
                                        }
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
                                loginData.mainUserJobEnd = "Present"
                            }, label: {
                                Text("Click here if you're still persuing?")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .fontWeight(.thin)
                            })
                        }
                    }
                    Spacer()
                    
                    //Button Next
                    Button(action: {
                        if loginData.mainUserJobTitle == "" {
                            alertJobTitlw = true
                        } else if loginData.mainUserEmploymentType == "" {
                            alertEmploymentType = true
                        } else if loginData.mainUserCompany == "" {
                            alertCompanyName = true
                        } else if loginData.mainUserJobStart == "" {
                            alertJobStart = true
                        } else if loginData.mainUserJobEnd == "" {
                            alertJobEnd = true
                        } else if loginData.mainUserJobEnd != "Present" {
                            if Int(loginData.mainUserJobStart) ?? 0 > Int(loginData.mainUserJobEnd ) ?? 0{
                                alertJobEndGreaterThanStart = true
                            }
                        } else {
                            Task{
                                let res = await profileService.updateExperienceforHotelier(userID: loginData.mainUserID, index: "0", userDescription: "", jobType: loginData.mainUserEmploymentType, jobTitle:  loginData.mainUserJobTitle, hotelCompany: loginData.mainUserCompany, jobStartYear: loginData.mainUserJobStart, jobEndYear: loginData.mainUserJobEnd)
                                if res == "Success" {
                                    userPCS.updateUserProfileCompletionStatus(loginData: loginData)
                                    navigateToMainFeed = true
                                } else {
                                    alertError = true
                                }
                            }
                        }
                    }) {
                        Text("Next")
                            .foregroundColor(.black)
                            .font(.body)
                            .fontWeight(.light)
                            .padding(.vertical, 10)
                            .padding(.horizontal, UIScreen.screenWidth/5)
                            .background(greenUi)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .padding(.bottom, UIScreen.screenHeight/40)
                    .navigationDestination(isPresented: $navigateToMainFeed, destination: {
                        MainFeedView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, isLoading: $isLoading)
                    })
                }
                EmploymentTypeBottomSheet(loginData: loginData)
                HotelSelectBottomSheetView(loginData: loginData, globalVM: globalVM)
                JobSelectionBottomSheetView(loginData: loginData, globalVM: globalVM)
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .toast(isPresenting: $alertCompanyName, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Company Name not selected yet!", subTitle: ("Select your role to proceed"))
        }
        .toast(isPresenting: $alertEmploymentType, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Employment type not entered yet!", subTitle: ("Enter your session to proceed"))
        }
        .toast(isPresenting: $alertJobTitlw, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Job Title not selected yet!", subTitle: ("Select your job title to proceed"))
        }
        .toast(isPresenting: $alertJobStart, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Job start is empty", subTitle: ("Enter your job to proceed"))
        }
        .toast(isPresenting: $alertJobEnd, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Job end is empty", subTitle: ("Enter your job to proceed"))
        }
        .toast(isPresenting: $alertJobEndGreaterThanStart, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Job start is greater than its ending", subTitle: ("Session start year should be less"))
        }
        .toast(isPresenting: $alertError, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Error Occured", subTitle: ("Try again"))
        }
        .navigationBarBackButtonHidden()
        .onAppear{
        }
    }
}

//struct HospitalityExpertBasicInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        HospitalityExpertBasicInfoView()
//    }
//}
