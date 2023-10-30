//
//  ProfessionalProfileEditEducationBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 14/07/23.
//

import SwiftUI

struct ProfessionalProfileEditEducationBottomSheet: View {
    
    @State var loginData: LoginViewModel
    @State var id: Int
    
    @Binding var openEditBottomSheet: Bool
    
    @FocusState private var isKeyboardShowing: Bool
    
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Edit your education")
                        .font(.body)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                    Spacer()
                }
                VStack{
                    //TextField
                    if let unwrappedText = loginData.userData.studentEducation[id] {
                        TextField("Your school name", text: Binding(get: {unwrappedText.educationPlace}, set: {_,_ in loginData.userData.studentEducation[id] = StudentEducation(educationPlace: "", educationSessionStart: "", educationSessionEnd: "", id: "")}))
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
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                    }
                    HStack{
                        //TextField
                        
                        if let unwrappedText = loginData.userData.studentEducation[id] {
                            TextField("XXXX", text: Binding(get: {unwrappedText.educationSessionStart}, set: {_,_ in loginData.userData.studentEducation[id] = StudentEducation(educationPlace: "", educationSessionStart: "", educationSessionEnd: "", id: "")}))
                                .padding()
                                .keyboardType(.numberPad)
                                .cornerRadius(7)
                                .onChange(of: loginData.userData.studentEducation[id]!.educationSessionStart) { newValue in
                                    let filteredValue = newValue.filter { $0.isNumber }
                                    if filteredValue.count > 4 {
                                        loginData.userData.studentEducation[id]!.educationSessionStart = String(filteredValue.prefix(4))
                                    } else {
                                        loginData.userData.studentEducation[id]!.educationSessionStart = filteredValue
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
                        
                        if let unwrappedText = loginData.userData.studentEducation[id] {
                            TextField("XXXX", text: Binding(get: {unwrappedText.educationSessionEnd}, set: {_,_ in loginData.userData.studentEducation[id] = StudentEducation(educationPlace: "", educationSessionStart: "", educationSessionEnd: "", id: "")}))
                                .padding()
                                .keyboardType(.numberPad)
                                .cornerRadius(7)
                                .onChange(of: loginData.userData.studentEducation[id]!.educationSessionEnd) { newValue in
                                    if newValue != "Present"{
                                        let filteredValue = newValue.filter { $0.isNumber }
                                        if filteredValue.count > 4 {
                                            loginData.userData.studentEducation[id]!.educationSessionEnd = String(filteredValue.prefix(4))
                                        } else {
                                            loginData.userData.studentEducation[id]!.educationSessionEnd = filteredValue
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

//struct ProfessionalProfileEditEducationBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfessionalProfileEditEducationBottomSheet_()
//    }
//}
