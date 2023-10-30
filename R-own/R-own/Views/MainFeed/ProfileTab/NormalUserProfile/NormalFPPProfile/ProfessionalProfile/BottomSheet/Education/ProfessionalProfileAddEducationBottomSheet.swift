//
//  ProfessionalProfileAddEducationBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 14/07/23.
//

import SwiftUI
import AlertToast

struct ProfessionalProfileAddEducationBottomSheet: View {
    
    @State var schoolName: String = ""
    @State var sessionStart: String = ""
    @State var sessionEnd: String = ""
    
    @FocusState private var isKeyboardShowing: Bool
    
    @Binding var openAddEducationBottomSheet: Bool
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    
    @State var alertSchoolName: Bool = false
    @State var alertSessionStart: Bool = false
    @State var alertSessionEnd: Bool = false
    @State var alertSessionStartMore: Bool = false
    @State var alertDone: Bool = false
    
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Add new education")
                        .font(.body)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                    Spacer()
                }
                VStack{
                    //TextField
                    
                    TextField("Your school name", text: $schoolName)
                        .padding()
                        .cornerRadius(7)
                        .overlay{
                            // apply a rounded border
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 0.5)
                            
                        }
                        .overlay{
                            HStack{
                                Text("University/School")
                                    .font(.body)
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
                        TextField("XXXX", text: $sessionStart)
                            .padding()
                            .keyboardType(.numberPad)
                            .cornerRadius(7)
                            .onChange(of: sessionStart) { newValue in
                                let filteredValue = newValue.filter { $0.isNumber }
                                if filteredValue.count > 4 {
                                    sessionStart = String(filteredValue.prefix(4))
                                } else {
                                    sessionStart = filteredValue
                                }
                            }
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                
                            }
                            .overlay{
                                HStack{
                                    Text("Session Start")
                                        .font(.body)
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
                        TextField("XXXX", text: $sessionEnd)
                            .padding()
                            .keyboardType(.numberPad)
                            .cornerRadius(7)
                            .onChange(of: sessionEnd) { newValue in
                                if newValue != "Present"{
                                    let filteredValue = newValue.filter { $0.isNumber }
                                    if filteredValue.count > 4 {
                                        sessionEnd = String(filteredValue.prefix(4))
                                    } else {
                                        sessionEnd = filteredValue
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
                                    Text("Session End")
                                        .font(.body)
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
                            sessionEnd = "Present"
                        }, label: {
                            Text("Click here if you're still persuing?")
                                .font(.body)
                                .foregroundColor(.black)
                                .fontWeight(.thin)
                        })
                    }
                }
                Button(action: {
                    if schoolName != ""{
                        alertSchoolName.toggle()
                    } else if sessionStart != "" {
                        alertSessionStart.toggle()
                    } else if sessionEnd != "" {
                        alertSessionEnd.toggle()
                    } else if sessionEnd != "Present" {
                        if Int(sessionStart)! > Int(sessionEnd)! {
                            alertSessionStartMore.toggle()
                        }
                    } else {
                        Task{
                            let res = await profileService.updateEducationofUser(userID: loginData.mainUserID, index: String(loginData.userData.studentEducation.count), educationPlace: schoolName, education_session_start: sessionStart, education_session_end: sessionEnd)
                            if res == "Success"{
                                loginData.userData.studentEducation.append(StudentEducation(educationPlace: schoolName, educationSessionStart: sessionStart, educationSessionEnd: sessionEnd, id: ""))
                                alertDone.toggle()
                            }
                        }
                    }
                }, label: {
                    Text("Save")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(greenUi)
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        .padding(.vertical, UIScreen.screenHeight/90)
                        .background(jobsDarkBlue)
                        .cornerRadius(15)
                })
                Spacer()
            }
            .padding(.top, UIScreen.screenHeight/30)
            .padding(.bottom, UIScreen.screenHeight/50)
            .padding(.horizontal, UIScreen.screenWidth/30)
            .toast(isPresenting: $alertSchoolName, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Enter School Name")
            }
            .toast(isPresenting: $alertSessionStart, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Enter session start year")
            }
            .toast(isPresenting: $alertSessionEnd, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Enter session end year")
            }
            .toast(isPresenting: $alertSessionStartMore, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Session start year error", subTitle: ("Start year can't be more than end year."))
            }
            .toast(isPresenting: $alertDone, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("checkmark.square.fill", greenUi), title: "Added")
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
    }
}

//struct ProfessionalProfileAddEducationBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfessionalProfileAddEducationBottomSheet()
//    }
//}
