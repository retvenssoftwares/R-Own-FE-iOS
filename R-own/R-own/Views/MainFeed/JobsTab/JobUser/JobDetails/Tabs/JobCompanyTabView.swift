//
//  JobCompanyTabView.swift
//  R-own
//
//  Created by Aman Sharma on 09/05/23.
//

import SwiftUI

struct JobCompanyTabView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading){
                    Text("Company Details")
                        .font(.system(size: UIScreen.screenHeight/60))
                        .fontWeight(.regular)
                        .padding()
                    
                    Text("Your role as the UI Designer is to use interactive components on various platforms (web, desktop and mobile). This will include producing high-fidelity mock-ups, iconography, UI illustrations/graphics, and other graphic elements. As the UI Designer, you will be supporting the wider design team with the internal Design System, tying together the visual language. You will with other UI and UX Designers, Product Managers, and Engineering teams in a highly customer-focused agile environment to help define the vision of the products.")
                        .font(.system(size: UIScreen.screenHeight/90))
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                .padding(.top, UIScreen.screenHeight/60)
                
                VStack(alignment: .leading){
                    Text("Company Website")
                        .font(.system(size: UIScreen.screenHeight/60))
                        .fontWeight(.regular)
                        .padding()
                    
                    Text("[https://examplecom](https://examplecom)")
                        .font(.system(size: UIScreen.screenHeight/90))
                        .multilineTextAlignment(.leading)
                        .padding()
                }
            }
        }
    }
}

//struct JobCompanyTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobCompanyTabView()
//    }
//}
