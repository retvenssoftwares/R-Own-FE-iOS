//
//  JobLocationCountryBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct JobLocationCountryBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    
    @State var countrySearchText: String = ""
    @State var country: String
    
    @FocusState private var isKeyboardShowing: Bool
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            Text("Select your country?")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            Text("Search your country below")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            TextField("Search Country", text: $countrySearchText)
                                .font(.system(size: 14))
                                .frame(width: UIScreen.screenWidth/1.2)
                                .overlay(alignment: .trailing, content: {
                                    Image(systemName: "magnifyingglass")
                                })
                                .focused($isKeyboardShowing)
                                .padding()
                                .border(.black.opacity(0.5))
                            
                            
                            //Location Array
                            ScrollView{
                                VStack(alignment: .leading){
                                        VStack{
                                            Text("India")
                                            Divider()
                                        }
                                        .onTapGesture {
                                            if country == "mainUser" {
                                                loginData.mainUserLocationCountry = "India"
                                            } else if country == "hotelLoc" {
                                                loginData.hotelLocationCountry = "India"
                                            }
                                            loginData.showCountrySheet = false
                                        }
                                    
                                        VStack{
                                            Text("USA")
                                            Divider()
                                        }
                                        .onTapGesture {
                                            if country == "mainUser" {
                                                loginData.mainUserLocationCountry = "USA"
                                            } else if country == "hotelLoc" {
                                                loginData.hotelLocationCountry = "USA"
                                            }
                                            loginData.showCountrySheet = false
                                        }
                                    
                                        VStack{
                                            Text("England")
                                            Divider()
                                        }
                                        .onTapGesture {
                                            if country == "mainUser" {
                                                loginData.mainUserLocationCountry = "England"
                                            } else if country == "hotelLoc" {
                                                loginData.hotelLocationCountry = "England"
                                            }
                                            loginData.showCountrySheet = false
                                        }
                                }
                            }
                            .padding(.top, UIScreen.screenHeight/50)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: loginData.showCountrySheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showCountrySheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showCountrySheet.toggle()
                    }
                }
            )
    }
    func onChanged(value: DragGesture.Value){
        if value.translation.height > 0{
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value){
        if value.translation.height > 0{
            withAnimation(Animation.easeInOut(duration: 0.2)){
                
                //onChecking
                
                let height = UIScreen.screenHeight/3
                
                if value.translation.height > height/1.5 {
                    loginData.showCountrySheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct JobLocationCountryBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        JobLocationCountryBottomSheet()
//    }
//}
