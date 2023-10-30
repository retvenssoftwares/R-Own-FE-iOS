//
//  ProfessionalProfileJobsTab.swift
//  R-own
//
//  Created by Aman Sharma on 14/07/23.
//

import SwiftUI

struct ProfessionalProfileJobsTab: View {
    
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
                
                    if loginData.userData.normalUserInfo.count > 0 {
                        VStack(alignment: .leading){
                            Text(loginData.userData.normalUserInfo[id]!.jobCompany)
                                .font(.body)
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundColor(greenUi)
                                .background(jobsDarkBlue)
                                .cornerRadius(10)
                            VStack(alignment: .leading){
                                Text("Designation")
                                    .font(.body)
                                    .fontWeight(.regular)
                                Text(loginData.userData.normalUserInfo[id]!.jobTitle)
                                    .font(.body)
                                    .fontWeight(.thin)
                                Text(loginData.userData.normalUserInfo[id]!.jobType)
                                    .font(.body)
                                    .fontWeight(.thin)
                            }
                            .padding()
                            VStack(alignment: .leading){
                                Text("Employment Year")
                                    .font(.body)
                                    .fontWeight(.regular)
                                Text("\(loginData.userData.normalUserInfo[id]!.jobStartYear) - \(loginData.userData.normalUserInfo[id]!.jobEndYear)")
                                    .font(.body)
                                    .fontWeight(.thin)
                            }
                            .padding()
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
                            ProfessionalProfileEditJobsBottomSheet(loginData: loginData, id: id, openEditBottomSheet: $openEditBottomSheet, globalVM: globalVM)
                        })
                        
                    }
                }
            }
            
        }
    }
}

//struct ProfessionalProfileJobsTab_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfessionalProfileJobsTab()
//    }
//}
