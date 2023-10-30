//
//  RequestLocationBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct RequestLocationBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var locationVM = LocationViewModel()
    
    @State var country: String = ""
    @State var state: String = ""
    @State var city: String = ""
    
    @State var countryCode: String = ""
    @State var stateCode: String = ""
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var body: some View {
        ZStack {
            VStack{
                    Spacer()
                    VStack(spacing: 12){
                        Capsule()
                            .fill(Color.gray)
                            .frame(width:60, height: 4)
                            
                        VStack(alignment: .leading, spacing: 20){
                            
                            Text("Choose your location:")
                                .font(.system(size: UIScreen.screenWidth/60))
                                .fontWeight(.bold)
                                .padding(.vertical, UIScreen.screenHeight/50)
                            
                            //Location Field=
                            Button(action: {
                                loginData.showCountrySheet = true
                            }, label: {
                                TextField("Your Country", text: $country)
                                        .disabled(true)
                                        .padding()
                                        .cornerRadius(7)
                                        .overlay{
                                            // apply a rounded border
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(.gray, lineWidth: 0.5)
                                            Text("Country")
                                                .font(.system( size: 14))
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: -UIScreen.screenWidth/2.9, y: -27)

                                        }
                                        .padding(.vertical, UIScreen.screenHeight/50)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                            })
                            
                            //state
                            Button(action: {
                                if country != "" {
                                    loginData.showStateSheet = true
//                                    locationVM.getState(globalVM: globalVM, countryCode: countryCode)
                                } else {
                                    print("Enter country first")
                                }
                            }, label: {
                                TextField("Your State", text: $state)
                                    .disabled(true)
                                    .padding()
                                    .cornerRadius(7)
                                    .overlay{
                                        // apply a rounded border
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(.gray, lineWidth: 0.5)
                                        Text("State")
                                            .font(.system( size: 14))
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal,5)
                                            .fontWeight(.ultraLight)
                                            .offset(x: -UIScreen.screenWidth/2.9, y: -27)
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                            })
                            
                            //city
                            Button(action: {
                                if country != "" && state != "" {
                                    loginData.showCitySheet = true
//                                    locationVM.getCity(globalVM: globalVM, countryCode: countryCode, stateCode: stateCode)
                                } else {
                                    print("Enter country and state first")
                                }
                            }, label: {
                                TextField("Your City", text: $city)
                                    .disabled(true)
                                    .padding()
                                    .cornerRadius(7)
                                    .overlay{
                                        // apply a rounded border
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(.gray, lineWidth: 0.5)
                                        Text("City")
                                            .font(.system( size: 14))
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal,5)
                                            .fontWeight(.ultraLight)
                                            .offset(x: -UIScreen.screenWidth/2.9, y: -27)

                                    }
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                            })
                            HStack{
                                Spacer()
                                Button(action: {
                                    let comma:  String = " , "
                                    jobsVM.jobLocationRequestedFor = city + comma + state + comma + country
                                    print(jobsVM.jobLocationRequestedFor)
                                    jobsVM.requestedLocationBottomSheet = false
                                }, label: {
                                    Text("Done")
                                        .font(.system(size: UIScreen.screenHeight/70))
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(greenUi)
                                        .cornerRadius(5)
                                })
                                Spacer()
                            }
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
                    .offset(y: jobsVM.requestedLocationBottomSheet ? 0 : UIScreen.main.bounds.height)
                }
                .ignoresSafeArea()
                .background(Color.black.opacity(jobsVM.requestedLocationBottomSheet ? 0.3 : 0).ignoresSafeArea()
                    .onTapGesture {
                        withAnimation{
                            jobsVM.requestedLocationBottomSheet.toggle()
                        }
                    }
            )
            CountryBottomSheetView(loginData: loginData, globalVM: globalVM, country: $country, countryCode: $countryCode)
            StateBottomSheetView(loginData: loginData, globalVM: globalVM, state: $state, stateCode: $stateCode, countryCode: countryCode)
            CityBottomSheetView(loginData: loginData, globalVM: globalVM, city: $city, countryCode: countryCode, stateCode: stateCode)
        }
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
                    jobsVM.requestedLocationBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct RequestLocationBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestLocationBottomSheet()
//    }
//}
