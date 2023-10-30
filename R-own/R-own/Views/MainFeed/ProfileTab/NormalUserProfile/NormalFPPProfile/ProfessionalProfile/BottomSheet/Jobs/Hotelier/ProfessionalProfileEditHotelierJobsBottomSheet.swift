//
//  ProfessionalProfileEditJobsBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 14/07/23.
//

import SwiftUI

struct ProfessionalProfileEditHotelierJobsBottomSheet: View {
    
    @State var loginData: LoginViewModel
    @State var id: Int
    
    @Binding var openEditBottomSheet: Bool
    
    @FocusState private var isKeyboardShowing: Bool
    
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Edit your experience")
                        .font(.body)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                    Spacer()
                }
                VStack{
                    //TextField
                    if let unwrappedText = loginData.userData.hospitalityExpertInfo[id] {
                        TextField("Your company name", text: Binding(get: {unwrappedText.hotelCompany}, set: {_,_ in loginData.userData.hospitalityExpertInfo[id] = HospitalityExpertInfoProfile(userDescription: "", jobtype: "", jobtitle: "", hotelCompany: "", jobstartYear: "", jobendYear: "") }))
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                
                            }
                            .overlay{
                                Text("Company Name")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: UIScreen.screenWidth/30, y: -27)
                            }
                            .focused($isKeyboardShowing)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                    }
                    
                    if let unwrappedText = loginData.userData.hospitalityExpertInfo[id] {
                        TextField("Your designation", text: Binding(get: {unwrappedText.jobtitle}, set: {_,_ in loginData.userData.hospitalityExpertInfo[id] = HospitalityExpertInfoProfile(userDescription: "", jobtype: "", jobtitle: "", hotelCompany: "", jobstartYear: "", jobendYear: "") }))
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                
                            }
                            .overlay{
                                Text("Designation")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: UIScreen.screenWidth/30, y: -27)
                            }
                            .focused($isKeyboardShowing)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                    }
                    
                    if let unwrappedText = loginData.userData.hospitalityExpertInfo[id] {
                        TextField("Your employment type", text: Binding(get: {unwrappedText.jobtype}, set: {_,_ in loginData.userData.hospitalityExpertInfo[id] = HospitalityExpertInfoProfile(userDescription: "", jobtype: "", jobtitle: "", hotelCompany: "", jobstartYear: "", jobendYear: "") }))
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                
                            }
                            .overlay{
                                Text("Employment Type")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: UIScreen.screenWidth/30, y: -27)
                            }
                            .focused($isKeyboardShowing)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                    }
                    HStack{
                        //TextField
                        
                        if let unwrappedText = loginData.userData.hospitalityExpertInfo[id] {
                            TextField("xxxx", text: Binding(get: {unwrappedText.jobstartYear}, set: {_,_ in loginData.userData.hospitalityExpertInfo[id] = HospitalityExpertInfoProfile(userDescription: "", jobtype: "", jobtitle: "", hotelCompany: "", jobstartYear: "", jobendYear: "") }))
                                .padding()
                                .keyboardType(.numberPad)
                                .cornerRadius(7)
                                .onChange(of: loginData.userData.normalUserInfo[id]!.jobStartYear) { newValue in
                                    let filteredValue = newValue.filter { $0.isNumber }
                                    if filteredValue.count > 4 {
                                        loginData.userData.normalUserInfo[id]!.jobStartYear = String(filteredValue.prefix(4))
                                    } else {
                                        loginData.userData.normalUserInfo[id]!.jobStartYear = filteredValue
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
                        }
                        //TextField
                        
                        if let unwrappedText = loginData.userData.hospitalityExpertInfo[id] {
                            TextField("xxxx", text: Binding(get: {unwrappedText.jobendYear}, set: {_,_ in  loginData.userData.hospitalityExpertInfo[id] = HospitalityExpertInfoProfile(userDescription: "", jobtype: "", jobtitle: "", hotelCompany: "", jobstartYear: "", jobendYear: "") }))
                                .padding()
                                .keyboardType(.numberPad)
                                .cornerRadius(7)
                                .onChange(of: loginData.userData.normalUserInfo[id]!.jobEndYear) { newValue in
                                    if newValue != "Present"{
                                        let filteredValue = newValue.filter { $0.isNumber }
                                        if filteredValue.count > 4 {
                                            loginData.userData.normalUserInfo[id]!.jobEndYear = String(filteredValue.prefix(4))
                                        } else {
                                            loginData.userData.normalUserInfo[id]!.jobEndYear = filteredValue
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
                    }
                    HStack{
                        Spacer()
                        Button(action: {
                            loginData.userData.studentEducation[id]!.educationSessionEnd = "Present"
                        }, label: {
                            Text("Click here if you're still persuing?")
                                .font(.body)
                                .foregroundColor(.black)
                                .fontWeight(.thin)
                        })
                    }
                }
                Button(action: {
                    openEditBottomSheet.toggle()
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
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
    }
}

//struct ProfessionalProfileEditJobsBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfessionalProfileEditJobsBottomSheet()
//    }
//}
