//
//  FinalLocationBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 06/06/23.
//

import SwiftUI

struct MainLocationBottomSheetView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    
    @Binding var location: String
    
    @StateObject var locationService = LocationService()
    @State var country: String = ""
    @State var state: String = ""
    @State var city: String = ""
    
    @State var countryCode: String = ""
    @State var stateCode: String = ""
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    
    @State var countrySearchText: String = ""
    var filteredCountries: [CountryModel] {
        countrySearchText.isEmpty ? globalVM.countriesList : globalVM.countriesList.filter { $0.name.localizedCaseInsensitiveContains(countrySearchText) }
    }
    
    
    @State var stateSearchText: String = ""
    var filteredStates: [StateModel] {
        stateSearchText.isEmpty ? globalVM.stateList : globalVM.stateList.filter { $0.name.localizedCaseInsensitiveContains(stateSearchText) }
    }
    
    
    @State var citySearchText: String = ""
    var filteredCities: [CityModel] {
        citySearchText.isEmpty ? globalVM.cityList : globalVM.cityList.filter { $0.name.localizedCaseInsensitiveContains(citySearchText) }
    }
    
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                    VStack(alignment: .leading, spacing: 20){
                        
                        Text("Choose your location:")
                            .font(.body)
                            .fontWeight(.bold)
                            .padding(.vertical, UIScreen.screenHeight/50)
                        
                        //Location Field=
                        Button(action: {
                            loginData.showLoader = true
                            Task{
                                let res = await locationService.getCountryList(globalVM: globalVM)
                                if res == "Success"{
                                    loginData.showCountrySheet = true
                                    loginData.showLoader = false
                                } else {
                                    let res = await locationService.getCountryList(globalVM: globalVM)
                                    if res == "Success"{
                                        loginData.showCountrySheet = true
                                        loginData.showLoader = false
                                    } else {
                                        
                                        loginData.showLoader = false
                                    }
                                }
                            }
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
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(BlurView())
                                            .padding(.horizontal,5)
                                            .fontWeight(.ultraLight)
                                            .offset(x: -UIScreen.screenWidth/2.9, y: -27)

                                    }
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                        })
                        .sheet(isPresented: $loginData.showCountrySheet, content: {
                            VStack{
                                Text("Select your country?")
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .padding(.top,30)
                                
                                Text("Search your country below")
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .fontWeight(.light)
                                    .multilineTextAlignment(.center)
                                    .padding(.top,30)
                                
                                TextField("Search Country", text: $countrySearchText)
                                    .font(.body)
                                    .frame(width: UIScreen.screenWidth/1.2)
                                    .overlay(alignment: .trailing, content: {
                                        Image(systemName: "magnifyingglass")
                                    })
                                    .padding()
                                    .border(.black.opacity(0.5))
                                
                                
                                //Location Array
                                ScrollView{
                                    VStack(alignment: .leading){
                                        if filteredCountries.count > 0 {
                                            ForEach(filteredCountries, id: \.self){ optCountry in
                                                Button(action: {
                                                    country = optCountry.name
                                                    countryCode = optCountry.numericCode
                                                    loginData.showCountrySheet = false
                                                    state = ""
                                                    city = ""
                                                }, label: {
                                                    VStack{
                                                        Text(optCountry.name)
                                                            .font(.body)
                                                            .fontWeight(.semibold)
                                                            .padding(.vertical, 5)
                                                            .foregroundColor(.black)
                                                            .frame(width: UIScreen.screenWidth)
                                                        Divider()
                                                    }
                                                })
                                            }
                                        }
                                    }
                                }
                                .padding(.top, UIScreen.screenHeight/50)
                            }
                        })
                        
                        //state
                        Button(action: {
                            if country != "" {
                                loginData.showLoader = true
                                Task{
                                    let res = await locationService.getStateList(globalVM: globalVM, countryCode: countryCode)
                                    if res == "Success" {
                                        loginData.showStateSheet = true
                                        loginData.showLoader = false
                                    } else {
                                            let res = await locationService.getStateList(globalVM: globalVM, countryCode: countryCode)
                                            if res == "Success" {
                                                loginData.showStateSheet = true
                                                loginData.showLoader = false
                                            } else {
                                                
                                                loginData.showLoader = false
                                            }
                                    }
                                }
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
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .background(BlurView())
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/2.9, y: -27)
                                }
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                        })
                        .sheet(isPresented: $loginData.showStateSheet, content: {
                            VStack{
                                Text("Select your state?")
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .padding(.top,30)
                                
                                Text("Search your state below")
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .fontWeight(.light)
                                    .multilineTextAlignment(.center)
                                    .padding(.top,30)
                                
                                TextField("Search State", text: $stateSearchText)
                                    .font(.body)
                                    .frame(width: UIScreen.screenWidth/1.2)
                                    .overlay(alignment: .trailing, content: {
                                        Image(systemName: "magnifyingglass")
                                    })
                                    .padding()
                                    .border(.black.opacity(0.5))
                                
                                
                                //Location Array
                                ScrollView{
                                    VStack(alignment: .leading){
                                        if filteredStates.count > 0 {
                                            ForEach(filteredStates, id: \.self){ optState in
                                                Button(action: {
                                                    state = optState.name
                                                    stateCode = optState.stateCode
                                                    loginData.showStateSheet = false
                                                    city = ""
                                                }, label: {
                                                    VStack{
                                                        Text(optState.name)
                                                            .font(.body)
                                                            .fontWeight(.semibold)
                                                            .padding(.vertical, 5)
                                                            .foregroundColor(.black)
                                                            .frame(width: UIScreen.screenWidth)
                                                        Divider()
                                                    }
                                                })
                                            }
                                        }
                                    }
                                }
                                .padding(.top, UIScreen.screenHeight/50)
                            }
                        })
                        
                        //city
                        Button(action: {
                            if country != "" && state != "" {
                                loginData.showLoader = true
                                Task{
                                    let res = await locationService.getCityList(globalVM: globalVM, countryCode: countryCode, stateCode: stateCode)
                                    if res == "Success"{
                                        loginData.showCitySheet = true
                                        loginData.showLoader = false
                                    } else {
                                        let res = await locationService.getCityList(globalVM: globalVM, countryCode: countryCode, stateCode: stateCode)
                                        if res == "Success"{
                                            loginData.showCitySheet = true
                                            loginData.showLoader = false
                                        } else {
                                            
                                            loginData.showLoader = false
                                        }
                                    }
                                }
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
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .background(BlurView())
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/2.9, y: -27)

                                }
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                        })
                        .sheet(isPresented: $loginData.showCitySheet, content: {
                            VStack{
                                Text("Select your city?")
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, UIScreen.screenHeight/30)
                                
                                Text("Search your city below")
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .fontWeight(.light)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, UIScreen.screenHeight/50)
                                
                                TextField("Search City", text: $citySearchText)
                                    .font(.body)
                                    .frame(width: UIScreen.screenWidth/1.2)
                                    .overlay(alignment: .trailing, content: {
                                        Image(systemName: "magnifyingglass")
                                    })
                                    .padding()
                                    .border(.black.opacity(0.5))
                                
                                
                                //Location Array
                                ScrollView{
                                    VStack(alignment: .leading){
                                        if filteredCities.count > 0 {
                                            ForEach(filteredCities, id: \.self){ optCity in
                                                Button(action: {
                                                    city = optCity.name
                                                    loginData.coordinates.latitude = Double(optCity.latitude) ?? 0.0
                                                    loginData.coordinates.longitude = Double(optCity.longitude) ?? 0.0
                                                    loginData.showCitySheet = false
                                                }, label: {
                                                    VStack{
                                                        Text(optCity.name)
                                                            .font(.body)
                                                            .fontWeight(.semibold)
                                                            .padding(.vertical, 5)
                                                            .foregroundColor(.black)
                                                            .frame(width: UIScreen.screenWidth)
                                                        Divider()
                                                    }
                                                })
                                            }
                                        } else {
                                            Text("No city to show")
                                        }
                                    }
                                }
                                .padding(.top, UIScreen.screenHeight/50)
                            }
                        })
                        HStack{
                            Spacer()
                            Button(action: {
                                let comma:  String = " , "
                                location = city + comma + state + comma + country
                                print(location)
                                loginData.mainLocationBottomSheet = false
                            }, label: {
                                Text("Done")
                                    .font(.body)
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
                .offset(y: loginData.mainLocationBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.mainLocationBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.mainLocationBottomSheet.toggle()
                    }
                }
            )
            
//            CountryBottomSheetView(loginData: loginData, globalVM: globalVM, country: $country, countryCode: $countryCode)
//            StateBottomSheetView(loginData: loginData, globalVM: globalVM, state: $state, stateCode: $stateCode, countryCode: countryCode)
//            CityBottomSheetView(loginData: loginData, globalVM: globalVM, city: $city, countryCode: countryCode, stateCode: stateCode)
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
                    loginData.mainLocationBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct FinalLocationBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        FinalLocationBottomSheet()
//    }
//}
