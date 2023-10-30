//
//  JobHotelierFIrstHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct JobHotelierFIrstHalfView: View {
    
    @StateObject var jobsVM: JobsViewModel
    
    @StateObject var loginData: LoginViewModel
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("Welcome, \(loginData.mainUserFullName)!")
                    .foregroundColor(.black)
                    .font(.system(size: UIScreen.screenHeight/70))
                    .fontWeight(.thin)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .leading)
                Text("Let's find a employees")
                    .foregroundColor(.black)
                    .font(.system(size: UIScreen.screenHeight/40))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .leading)
                
            }
            .padding(.top, UIScreen.screenHeight/30)
            .padding(.horizontal, UIScreen.screenWidth/40)
            Spacer()
        }
        .padding(.leading, UIScreen.screenWidth/30)
        .padding(.vertical, UIScreen.screenHeight/60)
    }
}
