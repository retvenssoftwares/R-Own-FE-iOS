//
//  InterestTabView.swift
//  R-own
//
//  Created by Aman Sharma on 09/04/23.
//

import SwiftUI

struct InterestTabView: View {
    
    @State var interestName: String
    @State var interest: GetInterest
    @State var loginData: LoginViewModel
    @State var selectedInterestTab: Bool = false
    
    
    var body: some View {
        if selectedInterestTab{
            Text(interestName)
                .foregroundColor(.black)
                .font(.body)
                .fontWeight(.semibold)
                .padding(10)
                .background(greenUi)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 1.0)
                )
                .onTapGesture {
                    selectedInterestTab.toggle()
                    if selectedInterestTab{
                        loginData.selectedInterestList.append(interest)
                    }else {
                        if let index = loginData.selectedInterestList.firstIndex(where: { $0.name == interestName }) {
                            loginData.selectedInterestList.remove(at: index)
                        }
                    }
                    print("These are selected interest")
                    print(loginData.selectedInterestList)
                }
        } else {
            Text(interestName)
                .foregroundColor(.black)
                .font(.body)
                .fontWeight(.semibold)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 1.0)
                        .foregroundColor(greenUi)
                )
                .onTapGesture {
                    selectedInterestTab.toggle()
                    if selectedInterestTab{
                        loginData.selectedInterestList.append(interest)
                    }else {
                        if let index = loginData.selectedInterestList.firstIndex(where: { $0.name == interestName }) {
                            loginData.selectedInterestList.remove(at: index)
                        }
                    }
                    print("These are selected interest")
                    print(loginData.selectedInterestList)
                }
        }
    }
}

//struct InterestTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        InterestTabView()
//    }
//}
