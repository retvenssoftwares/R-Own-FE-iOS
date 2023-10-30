//
//  ProfessionalProfileEducationTab.swift
//  R-own
//
//  Created by Aman Sharma on 14/07/23.
//

import SwiftUI

struct ProfessionalProfileEducationTab: View {
    
    @StateObject var loginData: LoginViewModel
    @State var id: Int
    
    @State var openEditBottomSheet: Bool = false
    @State var mainUser: Bool
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{
                VStack{
                    Circle()
                        .fill(jobsDarkBlue)
                        .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                    Spacer()
                }
                .padding(.top, UIScreen.screenHeight/70)
                .padding(.trailing, UIScreen.screenWidth/30)
                
                if loginData.userData.studentEducation.count > 0 {
                    VStack(alignment: .leading){
                        Text(loginData.userData.studentEducation[id]!.educationPlace)
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundColor(greenUi)
                            .background(jobsDarkBlue)
                            .cornerRadius(10)
                        
                        Text("Session Years")
                            .font(.body)
                            .fontWeight(.regular)
                        
                        Text("\(loginData.userData.studentEducation[id]!.educationSessionStart) - \(loginData.userData.studentEducation[id]!.educationSessionEnd)")
                            .font(.body)
                            .fontWeight(.thin)
                    }
                }
                
                Spacer()
                
                if mainUser {
                    VStack{
                        Spacer()
                        
                        Button(action: {
                            openEditBottomSheet.toggle()
                        }, label: {
                            HStack(spacing: 3){
                                Image("EditPenIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                Text("Edit")
                                    .font(.body)
                                    .fontWeight(.thin)
                                    .foregroundColor(.black)
                            }
                            .padding(.vertical, UIScreen.screenHeight/100)
                            .padding(.horizontal, UIScreen.screenWidth/50)
                            .overlay{
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.black)
                            }
                        })
                        .sheet(isPresented: $openEditBottomSheet, content: {
                            ProfessionalProfileEditEducationBottomSheet(loginData: loginData, id: id, openEditBottomSheet: $openEditBottomSheet, globalVM: globalVM)
                        })
                        
                    }
                }
            }
        }
    }
}

//struct ProfessionalProfileEducationTab_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfessionalProfileEducationTab()
//    }
//}
