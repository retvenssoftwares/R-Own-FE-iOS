//
//  JobsProfileNotCompletedView.swift
//  R-own
//
//  Created by Aman Sharma on 09/06/23.
//

import SwiftUI

struct JobsProfileNotCompletedView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var navigatetoProfileCompletion: Bool = false
    var body: some View {
        NavigationStack{
            VStack{
                Image("ProfileNotCompletedIllustration")
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.screenHeight/1.5)
                Button(action: {
                    navigatetoProfileCompletion.toggle()
                }, label: {
                    Text("Complete your profile now")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.horizontal, UIScreen.screenWidth/2.5)
                        .padding(.vertical, UIScreen.screenHeight/20)
                        .background(greenUi)
                        .cornerRadius(15)
                        .padding()
                })
                .navigationDestination(isPresented: $navigatetoProfileCompletion, destination: {
                    BasicInfoProfileView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                })
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct JobsProfileNotCompletedView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobsProfileNotCompletedView()
//    }
//}
