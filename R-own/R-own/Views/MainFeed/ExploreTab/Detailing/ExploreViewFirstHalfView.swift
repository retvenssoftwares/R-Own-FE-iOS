//
//  ExploreViewFirstHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 29/04/23.
//

import SwiftUI

struct ExploreViewFirstHalfView: View {
    
    @StateObject var exploreVM: ExploreViewModel
    
    @StateObject var loginData: LoginViewModel
    
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Welcome, \(loginData.mainUserFullName)!")
                    .foregroundColor(.black)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .leading)
                Text("Let's discover what's around you..!")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .leading)
            }
            .padding(.top, UIScreen.screenHeight/25)
            .padding(.horizontal, UIScreen.screenWidth/30)
            .padding()
            Spacer()
        }
    }
}

//struct ExploreViewFirstHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreViewFirstHalfView()
//    }
//}
