//
//  JobLocationCityBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct JobLocationCityBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    
    @State var citySearchText: String = ""
        
    @State var city: String
    
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
                        
                    VStack(alignment: .leading, spacing: 20){
                        Text("Select your city?")
                            .foregroundColor(.black)
                            .font(.system(size: UIScreen.screenHeight/40))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.top, UIScreen.screenHeight/30)
                        
                        Text("Search your city below")
                            .foregroundColor(.black)
                            .font(.system(size: UIScreen.screenHeight/90))
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                            .padding(.top, UIScreen.screenHeight/50)
                        
                        TextField("Search City", text: $citySearchText)
                            .font(.system(size: 14))
                            .frame(width: UIScreen.screenWidth/1.2)
                            .overlay(alignment: .trailing, content: {
                                Image(systemName: "magnifyingglass")
                            })
                            .focused($isKeyboardShowing)
                            .border(.black.opacity(0.5))
                        
                        
                        //Location Array
                        ScrollView{
                            VStack(alignment: .leading){
                                    VStack{
                                        Text("Indore")
                                        Divider()
                                    }
                                    .onTapGesture{
                                        if city == "mainUser" {
                                            loginData.mainUserLocationCity = "Indore"
                                        } else if city == "hotelLoc" {
                                            loginData.hotelLocationState = "Indore"
                                        }
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

//struct JobLocationCityBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        JobLocationCityBottomSheet()
//    }
//}
