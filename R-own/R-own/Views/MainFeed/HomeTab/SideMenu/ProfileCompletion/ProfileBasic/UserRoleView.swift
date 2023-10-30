//
//  UserRoleView.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import Foundation
import SwiftUI
import AlertToast

struct UserRoleView: View {
    
    //userinfo
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboData = MesiboViewModel()
    @StateObject var userPCS = UserProfileCompletionService()
    
    @State var studentToggle: Bool = false
    @State var hotelierToggle: Bool = false
    @State var isStudent: Bool = false
    @State var isHotelier: Bool = false
    
    @State var userRole: String = ""
    
    @State var navigateToNormalUser: Bool = false
    @State var navigateToHospitalityExpert: Bool = false
    @State var navigateToVendor: Bool = false
    @State var navigateToHotelOwner: Bool = false
    @State var toastUserRole: Bool = false
    @State var toastUniversityInfo: Bool = false
    @State var toastSessionInfo: Bool = false
    @State var toastSessionBigger: Bool = false
    @State var toastJobTitle: Bool = false
    @State var toastSessionError: Bool = false
    @State var toastError: Bool = false
    @State var currentYear: String = ""
    
    @State var encodedStatus: String = ""
    
    @FocusState private var isKeyboardShowing: Bool
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    
                    //Nav
                    HStack{
                        Text("Your information helps you discover new community")
                            .font(.title3)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, UIScreen.screenHeight/40)
                        
                        Spacer()
                    }
                    
                    //Hotelier
                    HStack{
                        //Text
                        
                        VStack(alignment: .leading){
                            //Text
                            Text("I’m a hotelier")
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            //Text
                            Text("I belong to hospitality industry and my network is on hospitality industry. I am a hotelier, hotel owner or vendor in hospitality")
                                .font(.body)
                                .fontWeight(.light)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        //ToggleButton
                        if hotelierToggle {
                            VStack{
                                Button(action: {
                                    isHotelier = false
                                    isStudent = true
                                    userRole = "Normal User"
                                    withAnimation{
                                        hotelierToggle = false
                                        studentToggle = true
                                    }
                                }, label: {
                                    Image("ToggleOnIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                })
                                Text("Yes")
                                    .font(.body)
                            }
                        } else {
                            VStack{
                                Button(action: {
                                    isHotelier = true
                                    isStudent = false
                                    loginData.showRoleSheet = true
                                    withAnimation{
                                        hotelierToggle = true
                                        studentToggle = false
                                    }
                                }, label: {
                                    Image("ToggleOffIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                })
                                Text("No")
                            }
                        }
                    }
                    
                    if isHotelier {
                        //TextField
                            TextField("Your Role In Hospitality", text: $userRole)
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
                                            Text("My Role In Hospitality")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: UIScreen.screenWidth/30, y: -UIScreen.screenHeight/90)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                .onTapGesture {
                                    loginData.showRoleSheet = true
                                }
                    }
                    
                //Student
                HStack{
                    //Text
                    Text("I’m a non-hotelier")
                        .font(.title3)
                        .font(.title3)
                        .fontWeight(.medium)
                    Spacer()
                    //ToggleButton
                    if studentToggle {
                        VStack{
                            Button(action: {
                                userRole = "Normal User"
                                isStudent = false
                                isHotelier = true
                                withAnimation{
                                    studentToggle = false
                                    hotelierToggle = true
                                    loginData.showRoleSheet = true
                                }
                            }, label: {
                                Image("ToggleOnIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                            })
                            Text("Yes")
                        }
                    } else {
                        VStack{
                            Button(action: {
                                userRole = "Normal User"
                                isHotelier = false
                                isStudent = true
                                withAnimation{
                                    studentToggle = true
                                    hotelierToggle = false
                                }
                            }, label: {
                                Image("ToggleOffIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                            })
                            Text("No")
                        }
                    }
                }
                if isStudent {
                    VStack{
                        //TextField
                        
                            TextField("Your school name", text: $loginData.mainUserCollege)
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
                                            Text("University/School")
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
                        
                        HStack{
                            //TextField
                                TextField("XXXX", text: $loginData.mainUserSessionStart)
                                    .padding()
                                    .keyboardType(.numberPad)
                                    .cornerRadius(7)
                                    .onChange(of: loginData.mainUserSessionStart) { newValue in
                                        let filteredValue = newValue.filter { $0.isNumber }
                                        if filteredValue.count > 4 {
                                            loginData.mainUserSessionStart = String(filteredValue.prefix(4))
                                        } else {
                                            loginData.mainUserSessionStart = filteredValue
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
                                                Text("Session Start")
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
                            
                            //TextField
                                TextField("XXXX", text: $loginData.mainUserSessionEnd)
                                    .padding()
                                    .keyboardType(.numberPad)
                                    .cornerRadius(7)
                                    .onChange(of: loginData.mainUserSessionEnd) { newValue in
                                        if newValue != "Present"{
                                            let filteredValue = newValue.filter { $0.isNumber }
                                            if filteredValue.count > 4 {
                                                loginData.mainUserSessionEnd = String(filteredValue.prefix(4))
                                            } else {
                                                loginData.mainUserSessionEnd = filteredValue
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
                                                Text("Session End")
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
                        }
                        HStack{
                            Spacer()
                            Button(action: {
                                loginData.mainUserSessionEnd = "Present"
                            }, label: {
                                Text("Click here if you're still persuing?")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .fontWeight(.thin)
                            })
                        }
                    }
                }
                    Spacer()
                    //Button
                    
                    //button
                    Button(action: {
                        if userRole == "" {
                            toastUserRole.toggle()
                        } else {
                            if userRole == "Normal User" {
                                if isStudent{
                                    if loginData.mainUserCollege == "" {
                                        toastUniversityInfo.toggle()
                                    } else if loginData.mainUserSessionStart == "" || loginData.mainUserSessionEnd == "" {
                                        toastSessionInfo.toggle()
                                    } else {
                                        loginData.profileCompletionPercentage = "90"
                                        loginData.mainUserRole = "Normal User"
                                        Task{
                                            let res = await userPCS.updateUserRoleInfo(loginData: loginData, mainUserID: loginData.mainUserID, mainUserCollege: loginData.mainUserCollege, mainUserSessionStart: loginData.mainUserSessionStart, mainUserSessionEnd: loginData.mainUserSessionEnd, mainUserJobTitle: loginData.mainUserJobTitle, mainUserRole: loginData.mainUserRole, profileCompletionPercentage: loginData.profileCompletionPercentage)
                                            if res == "Success"{
                                                
                                                navigateToNormalUser = true
                                            } else {
                                                toastError = true
                                                
                                            }
                                        }
                                    }
                                } else {
                                    loginData.profileCompletionPercentage = "90"
                                    loginData.mainUserRole = "Normal User"
                                    Task{
                                        let res = await userPCS.updateUserRoleInfo(loginData: loginData, mainUserID: loginData.mainUserID, mainUserCollege: loginData.mainUserCollege, mainUserSessionStart: loginData.mainUserSessionStart, mainUserSessionEnd: loginData.mainUserSessionEnd, mainUserJobTitle: loginData.mainUserJobTitle, mainUserRole: loginData.mainUserRole, profileCompletionPercentage: loginData.profileCompletionPercentage)
                                        if res == "Success"{
                                            
                                                print(loginData.mainUserPhoneNumber)
                                                print(loginData.mainUserFullName)
                                                mesiboData.mesiboSetSelfProfile(loginData.mainUserPhoneNumber)
                                                encodedStatus = encodeStatusData(userID: loginData.mainUserID, userRole: loginData.mainUserRole == "" ? "Normal User" : loginData.mainUserRole)
                                                mesiboData.mSelfProfile.setName(loginData.mainUserFullName)
                                                mesiboData.mSelfProfile.setStatus(encodedStatus)
                                                mesiboData.mSelfProfile.save()
                                                print("printing mesibo data down there:")
                                                print(mesiboData.mSelfProfile.getAddress())
                                                print(mesiboData.mSelfProfile.getName())
                                                print(mesiboData.mSelfProfile.getStatus())
                                                print(mesiboData.mSelfProfile.getAddress())
                                            navigateToNormalUser = true
                                        } else {
                                            toastError = true
                                            
                                        }
                                    }
                                }
                            } else if userRole == "Hospitality Expert" {
                                if isStudent{
                                    if loginData.mainUserCollege == "" {
                                        toastUniversityInfo.toggle()
                                    } else if loginData.mainUserSessionStart == "" || loginData.mainUserSessionEnd == "" {
                                        toastSessionInfo.toggle()
                                    } else if loginData.mainUserSessionEnd != "Present"{
                                        if Int(loginData.mainUserSessionStart)! > Int(loginData.mainUserSessionEnd)! {
                                            
                                        }
                                    } else {
                                        loginData.profileCompletionPercentage = "90"
                                        loginData.mainUserRole = "Hospitality Expert"
                                        Task{
                                            let res = await userPCS.updateUserRoleInfo(loginData: loginData, mainUserID: loginData.mainUserID, mainUserCollege: loginData.mainUserCollege, mainUserSessionStart: loginData.mainUserSessionStart, mainUserSessionEnd: loginData.mainUserSessionEnd, mainUserJobTitle: loginData.mainUserJobTitle, mainUserRole: loginData.mainUserRole, profileCompletionPercentage: loginData.profileCompletionPercentage)
                                            if res == "Success"{
                                                
                                                navigateToHospitalityExpert = true
                                            } else {
                                                toastError = true
                                                
                                            }
                                        }
                                    }
                                } else {
                                    loginData.profileCompletionPercentage = "90"
                                    loginData.mainUserRole = "Hospitality Expert"
                                    Task{
                                        let res = await userPCS.updateUserRoleInfo(loginData: loginData, mainUserID: loginData.mainUserID, mainUserCollege: loginData.mainUserCollege, mainUserSessionStart: loginData.mainUserSessionStart, mainUserSessionEnd: loginData.mainUserSessionEnd, mainUserJobTitle: loginData.mainUserJobTitle, mainUserRole: loginData.mainUserRole, profileCompletionPercentage: loginData.profileCompletionPercentage)
                                        if res == "Success"{
                                            
                                                print(loginData.mainUserPhoneNumber)
                                                print(loginData.mainUserFullName)
                                                mesiboData.mesiboInitalize(loginData.mainUserMesiboToken, address: loginData.mainUserPhoneNumber, remoteUserName: loginData.mainUserFullName)
                                                mesiboData.mesiboSetSelfProfile(loginData.mainUserPhoneNumber)
                                                encodedStatus = encodeStatusData(userID: loginData.mainUserID, userRole: loginData.mainUserRole == "" ? "Normal User" : loginData.mainUserRole)
                                                mesiboData.mSelfProfile.setName(loginData.mainUserFullName)
                                                mesiboData.mSelfProfile.setStatus(encodedStatus)
                                                mesiboData.mSelfProfile.save()
                                                print("printing mesibo data down there:")
                                                print(mesiboData.mSelfProfile.getAddress())
                                                print(mesiboData.mSelfProfile.getName())
                                                print(mesiboData.mSelfProfile.getStatus())
                                                print(mesiboData.mSelfProfile.getAddress())
                                            navigateToHospitalityExpert = true
                                        } else {
                                            toastError = true
                                            
                                        }
                                    }
                                    
                                }
                            } else if userRole == "Business Vendor / Freelancer" {
                                if isStudent{
                                    if loginData.mainUserCollege == "" {
                                        toastUniversityInfo.toggle()
                                    } else if loginData.mainUserSessionStart == "" || loginData.mainUserSessionEnd == "" {
                                        toastSessionInfo.toggle()
                                    } else {
                                        loginData.profileCompletionPercentage = "90"
                                        loginData.mainUserRole = "Hospitality Expert"
                                        Task{
                                            let res = await userPCS.updateUserRoleInfo(loginData: loginData, mainUserID: loginData.mainUserID, mainUserCollege: loginData.mainUserCollege, mainUserSessionStart: loginData.mainUserSessionStart, mainUserSessionEnd: loginData.mainUserSessionEnd, mainUserJobTitle: loginData.mainUserJobTitle, mainUserRole: loginData.mainUserRole, profileCompletionPercentage: loginData.profileCompletionPercentage)
                                            if res == "Success"{
                                                
                                                navigateToHospitalityExpert = true
                                            } else {
                                                toastError = true
                                                
                                            }
                                        }
                                    }
                                } else {
                                    loginData.profileCompletionPercentage = "90"
                                    loginData.mainUserRole = "Business Vendor / Freelancer"
                                    Task{
                                        let res = await userPCS.updateUserRoleInfo(loginData: loginData, mainUserID: loginData.mainUserID, mainUserCollege: loginData.mainUserCollege, mainUserSessionStart: loginData.mainUserSessionStart, mainUserSessionEnd: loginData.mainUserSessionEnd, mainUserJobTitle: loginData.mainUserJobTitle, mainUserRole: loginData.mainUserRole, profileCompletionPercentage: loginData.profileCompletionPercentage)
                                        if res == "Success"{
                                                print(loginData.mainUserPhoneNumber)
                                                print(loginData.mainUserFullName)
                                                mesiboData.mesiboInitalize(loginData.mainUserMesiboToken, address: loginData.mainUserPhoneNumber, remoteUserName: loginData.mainUserFullName)
                                                mesiboData.mesiboSetSelfProfile(loginData.mainUserPhoneNumber)
                                                encodedStatus = encodeStatusData(userID: loginData.mainUserID, userRole: loginData.mainUserRole == "" ? "Normal User" : loginData.mainUserRole)
                                                mesiboData.mSelfProfile.setName(loginData.mainUserFullName)
                                                mesiboData.mSelfProfile.setStatus(encodedStatus)
                                                mesiboData.mSelfProfile.save()
                                                print("printing mesibo data down there:")
                                                print(mesiboData.mSelfProfile.getAddress())
                                                print(mesiboData.mSelfProfile.getName())
                                                print(mesiboData.mSelfProfile.getStatus())
                                                print(mesiboData.mSelfProfile.getAddress())
                                            navigateToVendor = true
                                        } else {
                                            toastError = true
                                            
                                        }
                                    }
                                }
                            } else if userRole == "Hotel Owner" {
                                if isStudent{
                                    if loginData.mainUserCollege == "" {
                                        toastUniversityInfo.toggle()
                                    } else if loginData.mainUserSessionStart == "" || loginData.mainUserSessionEnd == "" {
                                        toastSessionInfo.toggle()
                                    } else {
                                        loginData.profileCompletionPercentage = "90"
                                        loginData.mainUserRole = "Hospitality Expert"
                                        Task{
                                            let res = await userPCS.updateUserRoleInfo(loginData: loginData, mainUserID: loginData.mainUserID, mainUserCollege: loginData.mainUserCollege, mainUserSessionStart: loginData.mainUserSessionStart, mainUserSessionEnd: loginData.mainUserSessionEnd, mainUserJobTitle: loginData.mainUserJobTitle, mainUserRole: loginData.mainUserRole, profileCompletionPercentage: loginData.profileCompletionPercentage)
                                            if res == "Success"{
                                                
                                                navigateToHospitalityExpert = true
                                            } else {
                                                toastError = true
                                                
                                            }
                                        }
                                    }
                                } else {
                                    loginData.mainUserRole = "Hotel Owner"
                                    loginData.profileCompletionPercentage = "90"
                                    Task{
                                        let res = await userPCS.updateUserRoleInfo(loginData: loginData, mainUserID: loginData.mainUserID, mainUserCollege: loginData.mainUserCollege, mainUserSessionStart: loginData.mainUserSessionStart, mainUserSessionEnd: loginData.mainUserSessionEnd, mainUserJobTitle: loginData.mainUserJobTitle, mainUserRole: loginData.mainUserRole, profileCompletionPercentage: loginData.profileCompletionPercentage)
                                        if res == "Success"{
                                            
                                            print(loginData.mainUserPhoneNumber)
                                            print(loginData.mainUserFullName)
                                            mesiboData.mesiboInitalize(loginData.mainUserMesiboToken, address: loginData.mainUserPhoneNumber, remoteUserName: loginData.mainUserFullName)
                                            mesiboData.mesiboSetSelfProfile(loginData.mainUserPhoneNumber)
                                            encodedStatus = encodeStatusData(userID: loginData.mainUserID, userRole: loginData.mainUserRole == "" ? "Normal User" : loginData.mainUserRole)
                                            mesiboData.mSelfProfile.setName(loginData.mainUserFullName)
                                            mesiboData.mSelfProfile.setStatus(encodedStatus)
                                            mesiboData.mSelfProfile.save()
                                            print("printing mesibo data down there:")
                                            print(mesiboData.mSelfProfile.getAddress())
                                            print(mesiboData.mSelfProfile.getName())
                                            print(mesiboData.mSelfProfile.getStatus())
                                            print(mesiboData.mSelfProfile.getAddress())
                                            navigateToHotelOwner = true
                                        } else {
                                            toastError = true
                                        }
                                    }
                                }
                            } else {
                                print("Role is not selected yet")
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
                    .navigationDestination(isPresented: $navigateToNormalUser, destination: {
                        NormalUserBasicInfoView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                    })
                    .navigationDestination(isPresented: $navigateToHospitalityExpert, destination: {
                        HospitalityExpertBasicInfoView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                    })
                    .navigationDestination(isPresented: $navigateToVendor, destination: {
                        VendorBasicInfoView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                    })
                    .navigationDestination(isPresented: $navigateToHotelOwner, destination: {
                        HotelOwnerBasicInfoView(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
                    })
                    
                }
                .padding(UIScreen.screenHeight/40)
                .padding(.top, UIScreen.screenHeight/30)
                RoleBottomSheetView(loginData: loginData, userRole: $userRole)
                JobSelectionBottomSheetView(loginData: loginData, globalVM: globalVM)
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
        .toast(isPresenting: $toastUserRole, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Role not selected yet!", subTitle: ("Select your role to proceed"))
        }
        .toast(isPresenting: $toastSessionInfo, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Session not entered yet!", subTitle: ("Enter your session to proceed"))
        }
        .toast(isPresenting: $toastJobTitle, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Job Title not selected yet!", subTitle: ("Select your job title to proceed"))
        }
        .toast(isPresenting: $toastUniversityInfo, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "University info not entered!", subTitle: ("Enter your university to proceed"))
        }
        .toast(isPresenting: $toastSessionError, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Session start is empty", subTitle: ("Enter your session to proceed"))
        }
        .toast(isPresenting: $toastSessionBigger, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Session start is greater than its ending", subTitle: ("Session start year should be less"))
        }
        .toast(isPresenting: $toastError, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Error Occured", subTitle: ("Try again"))
        }
        .onAppear{
            let calendar = Calendar.current
            let currentYearr = calendar.component(.year, from: Date())
            currentYear = String(currentYearr)
            loginData.mainUserRole = ""
        }
    }
    func encodeStatusString(input: String, shift: Int) -> String {
        var encodedData = ""
        for char in input {
            let encodedChar: Character
            if char.isLetter {
                let base = char.isLowercase ? Character("a") : Character("A")
                let encodedAscii = (Int(char.asciiValue ?? 0) - Int(base.asciiValue ?? 0) + shift) % 26
                encodedChar = Character(UnicodeScalar(encodedAscii + Int(base.asciiValue ?? 0))!)
            } else {
                encodedChar = char
            }
            encodedData.append(encodedChar)
        }
        return encodedData
    }
    func encodeStatusData(userID: String, userRole: String) -> String {
        let encodedUserID = encodeStatusString(input: userID, shift: 5)
        let encodedUserRole = encodeStatusString(input: userRole, shift: 6)
        return "\(encodedUserID)|\(encodedUserRole)"
    }
}

//struct UserRoleView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRoleView()
//    }
//}
