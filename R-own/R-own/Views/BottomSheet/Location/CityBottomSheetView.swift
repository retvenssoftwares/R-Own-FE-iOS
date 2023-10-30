//
//  CityBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 04/05/23.
//

import SwiftUI

struct CityBottomSheetView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var locationVM = LocationViewModel()
    
    @State var citySearchText: String = ""
        
    @Binding var city: String
    @State var countryCode: String
    @State var stateCode: String
    
    @FocusState private var isKeyboardShowing: Bool
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var filteredCities: [CityModel] {
        citySearchText.isEmpty ? globalVM.cityList : globalVM.cityList.filter { $0.name.localizedCaseInsensitiveContains(citySearchText) }
    }
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                    VStack(spacing: 20){
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
                            .focused($isKeyboardShowing)
//                            .toolbar {
//                                ToolbarItemGroup(placement: .keyboard) {
//                                    Spacer()
//
//                                    Button("Done") {
//
//                            isKeyboardShowing = false
//                            globalVM.keyboardVisibility = false
//                                    }
//                                }
//                            }
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
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.bottom,edges?.bottom)
                    .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: loginData.showCitySheet ? 0 : UIScreen.main.bounds.height)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showCitySheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showCitySheet.toggle()
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
                    loginData.showCitySheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}
//struct CityBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        CityBottomSheetView()
//    }
//}
