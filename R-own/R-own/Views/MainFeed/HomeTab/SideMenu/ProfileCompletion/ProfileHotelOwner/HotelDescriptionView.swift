//
//  HotelDescriptionView.swift
//  R-own
//
//  Created by Aman Sharma on 06/05/23.
//

import SwiftUI
import Mantis

struct HotelDescriptionView: View {
    
    @StateObject var loginData: LoginViewModel
    
    @StateObject var globalVM: GlobalViewModel
    @State var hotelNumber: Int
    @Binding var notSaved: Int
    
    @State var hotelLogo: UIImage?
    
    @FocusState private var isKeyboardShowing: Bool
    
    
    @State var hotelBG: UIImage = UIImage(named: "demo") ??  UIImage(named: "HotelBGIllustration")!
    @State var hotelBGCropped: UIImage?
    
    @State var hotelName1: String = ""
    @State var hotelDescription1: String = ""
    @State var hotelAddress1: String = ""
    @State var hotelRating1: String = ""
    @State var hotelCountry: String = ""
    @State var hotelState: String = ""
    @State var hotelCity: String = ""
    @State var hotelCountryCode: String = ""
    @State var hotelStateCode: String = ""
    @State var searchHotelCountry: String = ""
    @State var searchHotelState: String = ""
    @State var searchHotelCity: String = ""
    @State var hotelCoverpicURL1: String = ""
    @State var showLocation: Bool = false
    @State var showRating: Bool = false
    @State var showCountry: Bool = false
    @State var showState: Bool = false
    @State var showCity: Bool = false
    @State var isSaved: Bool = false
    
    @Binding var toastHotelCOverPic: Bool
    @Binding var toastHotelName: Bool
    @Binding var toastHotelDescp: Bool
    @Binding var toastHotelAddress: Bool
    @Binding var toastHotelRating: Bool
    
    @State private var coverPicshowImagePicker = false
    @State private var coverPicshowingCropper = false
    @State private var coverPiccropShapeType: Mantis.CropShapeType = .rect
    @State private var coverPicpresetFixedRatioType: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 3/2)
    @State private var coverPiccropperType: ImageCropperType = .normal
    
    @StateObject var locationService = LocationService()
    
    var filteredCountries: [CountryModel] {
        if searchHotelCountry.isEmpty {
            return globalVM.countriesList
        } else {
            return globalVM.countriesList.filter { $0.name.lowercased().contains(searchHotelCountry.lowercased()) }
        }
    }
    
    var filteredStates: [StateModel] {
        if searchHotelState.isEmpty {
            return globalVM.stateList
        } else {
            return globalVM.stateList.filter { $0.name.lowercased().contains(searchHotelState.lowercased()) }
        }
    }
    
    var filteredCities: [CityModel] {
        if searchHotelCity.isEmpty {
            return globalVM.cityList
        } else {
            return globalVM.cityList.filter { $0.name.lowercased().contains(searchHotelCity.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    //img Hotelimg
                    VStack{
                        if self.hotelBGCropped != nil {
                            Image(uiImage: self.hotelBGCropped!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/1.3)
                                .padding(.vertical, UIScreen.screenHeight/30)
                                .onTapGesture {
                                    coverPicshowImagePicker.toggle()
                                }
                        } else {
                            Image("HotelBGIllustration")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/1.3)
                                .padding(.vertical, UIScreen.screenHeight/30)
                                .onTapGesture {
                                    coverPicshowImagePicker.toggle()
                                }
                        }
                    }
                    .sheet(isPresented: $coverPicshowImagePicker) {
                        ImagePickerView(image: $hotelBGCropped)
                            .onAppear(perform: {
                                hotelBGCropped = nil
                            })
                            .onDisappear(perform: {
                                if hotelBGCropped != nil {
                                    coverPicshowingCropper = true
                                }
                            })
                    }
                    .fullScreenCover(isPresented: $coverPicshowingCropper, content: {
                        ImageCropper(image: $hotelBGCropped,
                                     cropShapeType: $coverPiccropShapeType,
                                     presetFixedRatioType: $coverPicpresetFixedRatioType,
                                     type: $coverPiccropperType,
                                     cropMandatory: true)
                            .ignoresSafeArea()
                    })
                    
                    //Text Field Hotel Name
                    
                    TextField("Enter hotel \(hotelNumber) name", text: $hotelName1)
                        .padding()
                        .disabled(isSaved)
                        .cornerRadius(7)
                        .overlay{
                            // apply a rounded border
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 0.5)
                        }
                        .overlay{
                            VStack{
                                HStack{
                                    Text("Hotel \(hotelNumber) Name")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        }
                        .focused($isKeyboardShowing)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    
                    //Text Field Hotel Description
                    
                    TextField("Enter hotel \(hotelNumber) description", text: $hotelDescription1)
                        .padding()
                        .disabled(isSaved)
                        .cornerRadius(7)
                        .overlay{
                            // apply a rounded border
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 0.5)
                        }
                        .overlay{
                            VStack{
                                HStack{
                                    Text("Hotel \(hotelNumber) Description")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        }
                        .focused($isKeyboardShowing)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    
                    //Text Field Hotel Address
                    
                    TextField("Enter Hotel \(hotelNumber) Address", text: $hotelAddress1)
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
                                    Text("Hotel \(hotelNumber) Address")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        }
                        .focused($isKeyboardShowing)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .sheet(isPresented: $showLocation, onDismiss: {
                            if hotelCity != "" {
                                hotelAddress1 = hotelCity + " , " + hotelState + " , " + hotelCountry
                            }
                        }) {
                            VStack{
                                //Text
                                Text("Select your hotel location?")
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                //Text
                                Text("Enter your location below")
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .fontWeight(.regular)
                                
                                //Location Field
                                TextField("Your Country", text: $hotelCountry)
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
                                                    .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                        
                                    }
                                    .focused($isKeyboardShowing)
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                    .sheet(isPresented: $showCountry, content: {
                                        VStack(spacing: 20){
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
                                            
                                            TextField("Search Country", text: $searchHotelCountry)
                                                .font(.body)
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
                                                    if filteredCountries.count > 0 {
                                                        ForEach(0..<filteredCountries.count, id: \.self){ count in
                                                            VStack{
                                                                Text(filteredCountries[count].name)
                                                                    .font(.body)
                                                                Divider()
                                                            }
                                                            .onTapGesture {
                                                                hotelCountry = filteredCountries[count].name
                                                                hotelCountryCode = filteredCountries[count].numericCode
                                                                hotelState = ""
                                                                hotelCity = ""
                                                                showCountry = false
                                                            }
                                                        }
                                                    } else {
                                                        Text("No countries found")
                                                    }
                                                }
                                            }
                                            .padding(.top, UIScreen.screenHeight/50)
                                        }
                                        .padding(.horizontal, UIScreen.screenWidth/10)
                                        .padding(.bottom)
                                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                                    })
                                    .onTapGesture {
                                        Task{
                                            loginData.showLoader = true
                                            let res = await locationService.getCountryList(globalVM: globalVM)
                                            if res == "Success"{
                                                showCountry.toggle()
                                                loginData.showLoader = false
                                            } else {
                                                let res = await locationService.getCountryList(globalVM: globalVM)
                                                if res == "Success"{
                                                    showCountry.toggle()
                                                    loginData.showLoader = false
                                                } else {
                                                    loginData.showLoader = false
                                                }
                                            }
                                        }
                                        
                                    }
                                
                                TextField("Your State", text: $hotelState)
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
                                                    .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                    }
                                    .focused($isKeyboardShowing)
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                    .sheet(isPresented: $showState, content: {
                                        VStack(spacing: 20){
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
                                            
                                            TextField("Search State", text: $searchHotelState)
                                                .font(.body)
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
                                                    if filteredStates.count > 0 {
                                                        ForEach(0..<filteredStates.count, id: \.self){ count in
                                                            
                                                            VStack{
                                                                Text(filteredStates[count].name)
                                                                Divider()
                                                            }
                                                            .onTapGesture {
                                                                hotelState = filteredStates[count].name
                                                                hotelStateCode = filteredStates[count].stateCode
                                                                hotelCity = ""
                                                                showState = false
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            .padding(.top, UIScreen.screenHeight/50)
                                            }
                                            .padding(.horizontal, UIScreen.screenWidth/10)
                                            .padding(.bottom)
                                            .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                                    })
                                    .onTapGesture {
                                        if hotelCountry == "" {
                                            
                                        } else {
                                            Task {
                                                loginData.showLoader = true
                                                let res = await locationService.getStateList(globalVM: globalVM, countryCode: hotelCountryCode)
                                                if res == "Success"{
                                                    showState = true
                                                    loginData.showLoader = false
                                                } else {
                                                    let res = await locationService.getStateList(globalVM: globalVM, countryCode: hotelCountryCode)
                                                    if res == "Success"{
                                                        showState = true
                                                        loginData.showLoader = false
                                                    } else {
                                                        
                                                        loginData.showLoader = false
                                                    }
                                                }
                                            }
                                        }
                                    }
                                
                                TextField("Your City", text: $hotelCity)
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
                                                    .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                        
                                    }
                                    .focused($isKeyboardShowing)
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                    .sheet(isPresented: $showCity, content: {
                                        VStack(spacing: 20){
                                            Text("Select your city?")
                                                .foregroundColor(.black)
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .multilineTextAlignment(.center)
                                                .padding(.top,30)
                                            
                                            Text("Search your city below")
                                                .foregroundColor(.black)
                                                .font(.body)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.center)
                                                .padding(.top,30)
                                            
                                            TextField("Search City", text: $searchHotelCity)
                                                .font(.body)
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
                                                    if filteredCities.count > 0 {
                                                        ForEach(0..<filteredCities.count, id: \.self){ count in
                                                            VStack{
                                                                Text(filteredCities[count].name)
                                                                    .font(.body)
                                                                Divider()
                                                            }
                                                            .onTapGesture {
                                                                hotelCity = filteredCities[count].name
                                                                showCity = false
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            .padding(.top, UIScreen.screenHeight/50)
                                        }
                                        .padding(.horizontal, UIScreen.screenWidth/10)
                                        .padding(.bottom)
                                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                                    })
                                    .onTapGesture {
                                        if hotelCountry == "" || hotelState == "" {
                                            
                                        } else{
                                            Task {
                                                loginData.showLoader = true
                                                let res = await locationService.getCityList(globalVM: globalVM, countryCode: hotelCountryCode, stateCode: hotelStateCode)
                                                if res  == "Success"{
                                                    loginData.showLoader = false
                                                    showCity = true
                                                } else {
                                                    let res = await locationService.getCityList(globalVM: globalVM, countryCode: hotelCountryCode, stateCode: hotelStateCode)
                                                    if res  == "Success"{
                                                        loginData.showLoader = false
                                                        showCity = true
                                                    } else {
                                                        
                                                        loginData.showLoader = false
                                                    }
                                                }
                                            }
                                        }
                                    }
                                
                                Spacer()
                                
                                //button
                                Button(action: {
                                    if hotelCountry == "" || hotelState == "" || hotelCity == "" {
                                        
                                    } else {
                                        showLocation = false
                                        if hotelCity != "" {
                                            hotelAddress1 = hotelCity + " , " + hotelState + " , " + hotelCountry
                                        }
                                    }
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
                        .onTapGesture {
                            if !isSaved {
                                showLocation.toggle()
                            }
                        }
                    
                    //Text Field Hotel Star Rating
                    
                    TextField("Select Hotel \(hotelNumber) Star Rating", text: $hotelRating1)
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
                                    Text("Hotel \(hotelNumber) Rating")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        }
                        .focused($isKeyboardShowing)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .sheet(isPresented: $showRating) {
                            VStack{
                                Text("Select your hotel star rating")
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .padding(.top,30)
                                
                                
                                
                                //Location Array
                                    VStack(alignment: .leading){
                                        
                                        Text("Select One:")
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.center)
                                            .padding(.top,30)
                                        
                                        ScrollView{
                                            VStack {
                                                VStack{
                                                    HStack{
                                                        Text("1 Star")
                                                            .font(.body)
                                                            .fontWeight(.bold)
                                                            .padding(.vertical, UIScreen.screenHeight/90)
                                                        Spacer()
                                                    }
                                                    .onTapGesture {
                                                        
                                                        hotelRating1 = "1 Star"
                                                        showRating = false
                                                    }
                                                    Divider()
                                                }
                                                VStack{
                                                    HStack{
                                                        Text("2 Star")
                                                            .font(.body)
                                                            .fontWeight(.bold)
                                                            .padding(.vertical, UIScreen.screenHeight/90)
                                                        Spacer()
                                                    }
                                                    .onTapGesture {
                                                        
                                                        hotelRating1 = "2 Star"
                                                        showRating = false
                                                    }
                                                    Divider()
                                                }
                                                VStack{
                                                    HStack{
                                                        Text("3 Star")
                                                            .font(.body)
                                                            .fontWeight(.bold)
                                                            .padding(.vertical, UIScreen.screenHeight/90)
                                                        Spacer()
                                                    }
                                                    .onTapGesture {
                                                        
                                                        hotelRating1 = "3 Star"
                                                        showRating = false
                                                    }
                                                    Divider()
                                                }
                                                VStack{
                                                    HStack{
                                                        Text("4 Star")
                                                            .font(.body)
                                                            .fontWeight(.bold)
                                                            .padding(.vertical, UIScreen.screenHeight/90)
                                                        Spacer()
                                                    }
                                                    .onTapGesture {
                                                        
                                                        hotelRating1 = "4 Star"
                                                        showRating = false
                                                    }
                                                    Divider()
                                                }
                                                VStack{
                                                    HStack{
                                                        Text("5 Star")
                                                            .font(.body)
                                                            .fontWeight(.bold)
                                                            .padding(.vertical, UIScreen.screenHeight/90)
                                                        Spacer()
                                                    }
                                                    .onTapGesture {
                                                        
                                                        hotelRating1 = "5 Star"
                                                        showRating = false
                                                    }
                                                    Divider()
                                                }
                                                VStack{
                                                    HStack{
                                                        Text("6 Star")
                                                            .font(.body)
                                                            .fontWeight(.bold)
                                                            .padding(.vertical, UIScreen.screenHeight/90)
                                                        Spacer()
                                                    }
                                                    .onTapGesture {
                                                        
                                                        hotelRating1 = "6 Star"
                                                        showRating = false
                                                    }
                                                    Divider()
                                                }
                                                VStack{
                                                    HStack{
                                                        Text("7 Star")
                                                            .font(.body)
                                                            .fontWeight(.bold)
                                                            .padding(.vertical, UIScreen.screenHeight/90)
                                                        Spacer()
                                                    }
                                                    .onTapGesture{
                                                        
                                                        hotelRating1 = "7 Star"
                                                        showRating = false
                                                    }
                                                    Divider()
                                                }
                                            }
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                        }
                                        Spacer()
                                    }
                            }
                            .padding(.horizontal, UIScreen.screenWidth/12)
                            .padding(.bottom)
                            .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                        }
                        .onTapGesture {
                            if !isSaved {
                                showRating.toggle()
                            }
                        }
                    HStack{
                        //save button (append in hotel list)
                        Button(action: {
                            if hotelName1 == "" {
                                toastHotelName.toggle()
                            } else if hotelAddress1 == "" {
                                toastHotelAddress.toggle()
                            } else if hotelRating1 == "" {
                                toastHotelRating.toggle()
                            } else if hotelDescription1 == "" {
                                toastHotelDescp.toggle()
                            } else if hotelBGCropped == nil {
                                toastHotelCOverPic.toggle()
                            } else {
                                notSaved += 1
                                loginData.hotelChainList.append(Hotel(
                                    hotelOwnerID: loginData.mainUserID,
                                    hotelName: hotelName1,
                                    hotelAddress: hotelAddress1,
                                    hotelRating: hotelRating1,
                                    hotelLogoURL: loginData.hotelLogoURL,
                                    hotelDescription: hotelDescription1,
                                    hotelProfilepicURL: hotelLogo,
                                    hotelCoverpicURL: hotelBGCropped)
                                )
                                isSaved = true
                            }
                            print(notSaved)
                            print(loginData.hotelChainList)
                        }) {
                            Text(isSaved ? "Saved" : "Save")
                                .foregroundColor(.black)
                                .font(.body)
                                .padding(.vertical, UIScreen.screenHeight/40)
                                .padding(.horizontal, UIScreen.screenWidth/10)
                                .background(isSaved ? lightGreyUi : greenUi)
                        }
                        .background(Color.white)
                        .disabled(isSaved)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                        .padding(.top, UIScreen.screenHeight/20)
                        .padding(.bottom, UIScreen.screenHeight/30)
                        
                        if isSaved{
                            Button(action: {
                                notSaved -= 1
                                isSaved = false
                                deleteHotel(withName: hotelName1)
                                print(loginData.hotelChainList)
                            }) {
                                Text("Edit?")
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .fontWeight(.light)
                                    .padding(.vertical, 10)
                            }
                            .padding(.top, UIScreen.screenHeight/20)
                            .padding(.bottom, UIScreen.screenHeight/30)
                        }
                    }
                }
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
    }
    func deleteHotel(withName hotelNameToDelete: String) {
        loginData.hotelChainList.removeAll { hotel in
            hotel.hotelName == hotelNameToDelete
        }
    }
}

//struct HotelDescriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelDescriptionView()
//    }
//}
