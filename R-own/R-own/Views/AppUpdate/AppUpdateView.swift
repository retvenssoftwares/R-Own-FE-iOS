//
//  AppUpdateView.swift
//  R-own
//
//  Created by Aman Sharma on 03/08/23.
//

import SwiftUI

struct AppUpdateView: View {
    
    @StateObject var loginData: LoginViewModel
    
    var body: some View {
        VStack{
            
            Image("AppUpdateIllustration")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.screenWidth/1.2)
            
            
            // Button that opens the link
            if loginData.appUpdate.count > 0 {
                if loginData.appUpdate[0].iOSUpdateLink != "" {
                    Link("Update R-own", destination: URL(string: loginData.appUpdate[0].iOSUpdateLink)!)
                        .padding()
                        .foregroundColor(jobsDarkBlue)
                        .background(greenUi)
                        .cornerRadius(10)
                        .padding()
                }
            }
            
        }
        .onAppear{
            
        }
    }
}

//struct AppUpdateView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppUpdateView()
//    }
//}
