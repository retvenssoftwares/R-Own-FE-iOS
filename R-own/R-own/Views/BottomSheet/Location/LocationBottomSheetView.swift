//
//  LocationBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 24/05/23.
//

import SwiftUI

struct LocationBottomSheetView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    
    @Binding var location: String
    
    @State var country: String = ""
    @State var state: String = ""
    @State var city: String = ""
    
    @State var countryCode: String = ""
    @State var stateCode: String = ""
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    @FocusState private var isKeyboardShowing: Bool
    
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
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal,5)
                                            .fontWeight(.ultraLight)
                                            .offset(x: -UIScreen.screenWidth/2.9, y: -27)

                                    }
                                    .focused($isKeyboardShowing)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()

                                            Button("Done") {
                                                isKeyboardShowing = false
                                                globalVM.keyboardVisibility = false
                                            }
                                        }
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                        })
                        
                        //state
                        Button(action: {
                            if country != "" {
                                loginData.showStateSheet = true
//                                locationVM.getState(globalVM: globalVM, countryCode: countryCode)
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
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/2.9, y: -27)
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                        })
                        
                        //city
                        Button(action: {
                            if country != "" && state != "" {
                                loginData.showCitySheet = true
//                                locationVM.getCity(globalVM: globalVM, countryCode: countryCode, stateCode: stateCode)
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
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .focused($isKeyboardShowing)
                                        .offset(x: -UIScreen.screenWidth/2.9, y: -27)

                                }
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                        })
                        HStack{
                            Spacer()
                            Button(action: {
                                let comma:  String = " , "
                                location = createPostVM.postCity + comma + createPostVM.postState + comma + createPostVM.postCountry
                                print(location)
                                createPostVM.checkinLocationBottomSheet = false
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
                    
                    .onAppear{
//                        locationVM.getCountry(globalVM: globalVM)
                    }
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: createPostVM.updateEventLocationBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(createPostVM.updateEventLocationBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        createPostVM.updateEventLocationBottomSheet.toggle()
                    }
                }
            )
            
            CountryBottomSheetView(loginData: loginData, globalVM: globalVM, country: $country, countryCode: $countryCode)
            StateBottomSheetView(loginData: loginData, globalVM: globalVM, state: $state, stateCode: $stateCode, countryCode: countryCode)
            CityBottomSheetView(loginData: loginData, globalVM: globalVM, city: $city, countryCode: countryCode, stateCode: stateCode)
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
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
                    createPostVM.updateEventLocationBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}
