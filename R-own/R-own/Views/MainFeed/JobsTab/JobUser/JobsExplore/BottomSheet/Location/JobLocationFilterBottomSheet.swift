//
//  JobLocationFilterBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct JobLocationFilterBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    
    
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
                        
                        //Location Field=
                            TextField("Your Country", text: $loginData.mainUserLocationCountry)
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
                                .onTapGesture {
                                    loginData.showCountrySheet = true
                                }
                        
                            TextField("Your State", text: $loginData.mainUserLocationState)
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
                                .onTapGesture {
                                    if loginData.mainUserLocationCountry != "" {
                                        loginData.showStateSheet = true
                                    } else {
                                        print("Enter country first")
                                    }
                                }
                        
                            TextField("Your City", text: $loginData.mainUserLocationCity)
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
                                .onTapGesture {
                                    if loginData.mainUserLocationCountry != "" && loginData.mainUserLocationState != "" {
                                        loginData.showCitySheet = true
                                    } else {
                                        print("Enter country and state first")
                                    }
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
//struct JobLocationFilterBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        JobLocationFilterBottomSheet()
//    }
//}
