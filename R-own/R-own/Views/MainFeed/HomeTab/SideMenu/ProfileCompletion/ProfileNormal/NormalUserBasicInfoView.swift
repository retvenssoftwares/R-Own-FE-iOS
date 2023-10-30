//
//  NormalUserBasicInfoView.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI
import AlertToast

struct NormalUserBasicInfoView: View {
    
    //userinfo
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var normalUserPCS = NormalUserProfileCompletionService()
    @StateObject var userPCS = UserProfileCompletionService()
    
    @State var navigateToMainFeed: Bool = false
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var isLoading: Bool = true
    
    
    @State var alertNoJobTitle: Bool = false
    @State var alertNoEmploymentType: Bool = false
    @State var alertNoRecentCompany: Bool = false
    @State var alertNojobStart: Bool = false
    @State var alertNoJobEnd: Bool = false
    @State var alertNoJobYearStartgreaterThanEnd: Bool = false
    @State var alertErrorUpdating: Bool = false
    @StateObject var profileService = ProfileService()
    
    
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
                    
                    //TextField recent job title
                    
                    TextField("Select Job Title", text: $loginData.mainUserJobTitle)
                        .disabled(true)
                        .padding()
                        .cornerRadius(7)
                        .overlay{
                            // apply a rounded border
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
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        }
                        .focused($isKeyboardShowing)
//                        .toolbar {
//                            ToolbarItemGroup(placement: .keyboard) {
//                                Spacer()
//
//                                Button("Done") {
//
//                            isKeyboardShowing = false
//                            globalVM.keyboardVisibility = false
//                                }
//                            }
//                        }
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
                            // apply a rounded border
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
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        }
                        .focused($isKeyboardShowing)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .onTapGesture {
                            loginData.showEmploymentTypeSheet =  true
                        }
                    
                    //TextField recent company
                    
                    TextField("Select your recent company*", text: $loginData.mainUserCompany)
                        .disabled(true)
                        .padding()
                        .cornerRadius(7)
                        .overlay{
                            // apply a rounded border
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 0.5)
                        }
                        .overlay{
                            // apply a rounded border
                            VStack{
                                HStack{
                                    Text("Recent Company")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                        .focused($isKeyboardShowing)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .onTapGesture {
                            loginData.showCompanySheet = true
                        }
                    
                    HStack{
                        //TextField Job Start
                        TextField("XXXX", text: $loginData.mainUserJobStart)
                            .padding()
                            .keyboardType(.numberPad)
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                
                            }
                            .overlay{
                                VStack{
                                    HStack{
                                        Text("Job Start")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal,5)
                                            .fontWeight(.ultraLight)
                                            .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                        Spacer()
                                    }
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
                        
                        //TextField Job End
                        VStack{
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
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                }
                                .overlay{
                                    VStack{
                                        HStack{
                                            Text("Job End")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                        }
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
                                .padding(.horizontal, UIScreen.screenWidth/30)
                        })
                    }
                    Spacer()
                    
                    //Button Next
                    Button(action: {
                        if loginData.mainUserJobTitle == "" {
                            alertNoJobTitle.toggle()
                        } else if loginData.mainUserEmploymentType == "" {
                            alertNoEmploymentType.toggle()
                        } else if loginData.mainUserCompany == "" {
                            alertNoRecentCompany.toggle()
                        } else if loginData.mainUserJobStart == "" {
                            alertNojobStart.toggle()
                        } else if loginData.mainUserJobEnd == "" {
                            alertNoJobEnd.toggle()
                        } else if loginData.mainUserJobEnd != "Present" {
                            if Int(loginData.mainUserJobStart) ?? 0 > Int(loginData.mainUserJobEnd) ?? 0 {
                                alertNoJobYearStartgreaterThanEnd.toggle()
                            }
                        } else {
                            Task {
                                let res = await profileService.updateExperienceforNormalUser(userID: loginData.mainUserID, index: "0", userDescription: "", jobType: loginData.mainUserEmploymentType, jobTitle: loginData.mainUserJobTitle, hotelCompany: loginData.mainUserCompany, jobStartYear: loginData.mainUserJobStart, jobEndYear: loginData.mainUserJobEnd)
                                if res == "Success" {
                                    userPCS.updateUserProfileCompletionStatus(loginData: loginData)
                                    navigateToMainFeed = true
                                } else {
                                    alertErrorUpdating.toggle()
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
                CompanySelectBottomSheet(loginData: loginData, globalVM: globalVM)
                JobSelectionBottomSheetView(loginData: loginData, globalVM: globalVM)
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .toast(isPresenting: $alertNoJobTitle, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Job Title not entered!", subTitle: ("Enter your job title to proceed"))
        }
        .toast(isPresenting: $alertNoEmploymentType, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Employment Type is empty", subTitle: ("Enter your employment type to proceed"))
        }
        .toast(isPresenting: $alertNoRecentCompany, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Recent Company is empty", subTitle: ("Enter your recent company to proceed"))
        }
        .toast(isPresenting: $alertNojobStart, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Start year empty", subTitle: ("Enter your employment starting year to proceed"))
        }
        .toast(isPresenting: $alertNoJobEnd, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "End year is empty", subTitle: ("Enter your employment ending year to proceed"))
        }
        .toast(isPresenting: $alertNoJobYearStartgreaterThanEnd, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Start year is greater than its ending", subTitle: ("Start year should be less"))
        }
        .toast(isPresenting: $alertErrorUpdating, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Error Updating!")
        }
        .navigationBarBackButtonHidden()
    }
}

//struct NormalUserBasicInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalUserBasicInfoView()
//    }
//}
