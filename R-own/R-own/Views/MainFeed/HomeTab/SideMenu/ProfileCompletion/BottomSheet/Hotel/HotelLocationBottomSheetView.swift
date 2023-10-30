//
//  HotelLocationBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI

struct HotelLocationBottomSheetView: View {
    
    @StateObject var loginData: LoginViewModel
    
    @State var hotelSearch: String = ""
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    @State var countryCode: String = ""
    @State var stateCode: String = ""
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                    VStack{
                        //Text
                        Text("Select your hotel location?")
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.bold)
                        //Text
                        Text("Enter your location below")
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        //Location Field
                        TextField("Your Country", text: $loginData.hotelLocationCountry)
                            .disabled(true)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                            .overlay{
                                VStack{
                                    HStack{
                                        Text("Country")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal,5)
                                            .fontWeight(.ultraLight)
                                            .offset( y: -27)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                
                            }
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .onTapGesture {
                                loginData.showCountrySheet = true
                            }
                        
                        TextField("Your State", text: $loginData.hotelLocationState)
                            .disabled(true)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                            .overlay{
                                VStack{
                                    HStack{
                                        Text("State")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal,5)
                                            .fontWeight(.ultraLight)
                                            .offset( y: -27)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                
                            }
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .onTapGesture {
                                loginData.showStateSheet = true
                            }
                        
                        TextField("Your City", text: $loginData.hotelLocationCity)
                            .disabled(true)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                            .overlay{
                                VStack{
                                    HStack{
                                        Text("City")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal,5)
                                            .fontWeight(.ultraLight)
                                            .offset(y: -27)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                
                            }
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .onTapGesture {
                                loginData.showCitySheet = true
                            }
                        
                        Spacer()
                        
                        //button
                        Button(action: {
                            loginData.showHotelLocationSheet = false
                            loginData.hotelAddress = loginData.hotelLocationCountry + " , " + loginData.hotelLocationState + " , " + loginData.hotelLocationCity
                        }) {
                            Text("Done")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.light)
                                .padding(.vertical, 10)
                                .padding(.horizontal, UIScreen.screenWidth/5)
                                .background(greenUi)
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                        .padding(.bottom, UIScreen.screenHeight/40)
                    }
                }
            }
            .padding(.top)
            .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
            .offset(y: offset)
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
            .offset(y: loginData.showHotelLocationSheet ? 0 : UIScreen.main.bounds.height)
            
//            CountryBottomSheetView(loginData: loginData, country: $loginData.hotelLocationCountry, countryCode: $countryCode)
//            StateBottomSheetView(loginData: loginData, state: $loginData.hotelLocationState, stateCode: $stateCode, countryCode: countryCode)
//            CityBottomSheetView(loginData: loginData, city: $loginData.hotelLocationCity, countryCode: countryCode, stateCode: stateCode)
        }
        .ignoresSafeArea()
        .background(Color.black.opacity(loginData.showHotelLocationSheet ? 0.3 : 0).ignoresSafeArea()
            .onTapGesture {
                withAnimation{
                    loginData.showHotelLocationSheet.toggle()
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
                    loginData.showHotelLocationSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct HotelLocationBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelLocationBottomSheet()
//    }
//}
