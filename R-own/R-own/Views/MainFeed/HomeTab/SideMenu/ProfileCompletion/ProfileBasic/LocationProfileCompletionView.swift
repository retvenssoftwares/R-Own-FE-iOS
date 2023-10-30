//
//  LocationProfileCompletionView.swift
//  R-own
//
//  Created by Aman Sharma on 04/05/23.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation
import AlertToast

struct LocationProfileCompletionView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var locationVM = LocationViewModel()
    @StateObject var userPCS = UserProfileCompletionService()
    
    @State var navigateToFirstPartOfRoleSelection: Bool = false
    @State var alertForLocation: Bool = false
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var countryCode: String = ""
    @State var stateCode: String = ""
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    //Navbar
                    HStack{
                        //profilepic
                        if loginData.mainUserProfilePic == "" {
                            Image("UserIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                .padding(.trailing, 10)
                        } else {
                            AsyncImage(url: currentUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Color.purple.opacity(0.1)
                            }
                            .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                            .clipShape(Circle())
                            .padding(.trailing, 10)
                            .onAppear {
                                if currentUrl == nil {
                                    DispatchQueue.main.async {
                                        currentUrl = URL(string: loginData.mainUserProfilePic)
                                    }
                                }
                            }
                        }
                        VStack(alignment: .leading){
                            //name text
                            Text("Hi..! \(loginData.mainUserFullName)")
                                .foregroundColor(.black)
                                .font(.title3)
                                .fontWeight(.bold)
                            //text
                            Text("Let’s gather some interesting information about you to get a best experience.")
                                .foregroundColor(.black)
                                .font(.body)
                        }
                        Spacer()
                    }
                    .padding(.leading, UIScreen.screenWidth/30)
                    .padding(.bottom, UIScreen.screenHeight/30)
                    
                    HStack{
                        VStack(alignment: .leading){
                            //Text
                            Text("What’s your location?")
                                .foregroundColor(.black)
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            //Text
                            Text("Meet peoples, vendors, hotel owners, and interesting facts near your area")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        Spacer()
                    }
                    .padding(.leading, UIScreen.screenWidth/40)
                    
                    //Location Field=
                    AutoFetchLocationTab(autoLocation: $loginData.mainUserLocation, loginData: loginData, globalVM: globalVM, width: UIScreen.screenWidth/1.2)
                    
                    Spacer()
                    
                    //button
                    Button(action: {
                        if loginData.mainUserLocation == "" {
                            alertForLocation.toggle()
                        } else {
                            if loginData.mainUserLocationCity != "" {
                                loginData.profileCompletionPercentage = "80"
                                userPCS.postUserLocationInfo(loginData: loginData)
                                navigateToFirstPartOfRoleSelection.toggle()
                            } else{
                                print("select Location First")
                            }
                        }
                    }) {
                        Text("Next")
                            .foregroundColor(.black)
                            .font(.body)
                            .fontWeight(.medium)
                            .padding(.vertical, 10)
                            .padding(.horizontal, UIScreen.screenWidth/5)
                            .background(greenUi)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .padding(.bottom, UIScreen.screenHeight/40)
                    .navigationDestination(isPresented: $navigateToFirstPartOfRoleSelection, destination: {
                        UserRoleView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                    })
                }
                .padding(.top, UIScreen.screenHeight/40)
                .padding(UIScreen.screenHeight/50)
                MainLocationBottomSheetView(loginData: loginData, globalVM: globalVM, location: $loginData.mainUserLocation)
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
        .toast(isPresenting: $alertForLocation, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Location not updated", subTitle: ("Enter your location to proceed"))
        }
    }
}

//struct LocationProfileCompletionView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationProfileCompletionView()
//    }
//}
