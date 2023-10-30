//
//  JobLocationStateBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct JobLocationStateBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    
    @State var stateSearchText: String = ""
    
    @State var state: String
    
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
                            Text("Select your state?")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            Text("Search your state below")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            TextField("Search State", text: $stateSearchText)
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
                                VStack{
                                        VStack{
                                            Text("Madhya Pradesh")
                                            Divider()
                                        }
                                        .onTapGesture {
                                            if state == "mainUser" {
                                                loginData.mainUserLocationState = "Madhya Pradesh"
                                            } else if state == "hotelLoc" {
                                                loginData.hotelLocationState = "Madhya Pradesh"
                                            }
                                            loginData.showStateSheet = false
                                        }
                                    
                                        VStack{
                                            Text("Virginia")
                                            Divider()
                                        }
                                        .onTapGesture{
                                            if state == "mainUser" {
                                                loginData.mainUserLocationState = "Virginia"
                                            } else if state == "hotelLoc" {
                                                loginData.hotelLocationState = "Virginia"
                                            }
                                            loginData.showStateSheet = false
                                        }
                                    
                                        VStack{
                                            Text("Kentuky")
                                            Divider()
                                        }
                                        .onTapGesture{
                                            if state == "mainUser" {
                                                loginData.mainUserLocationState = "Kentuky"
                                            } else if state == "hotelLoc" {
                                                loginData.hotelLocationState = "Kentuky"
                                            }
                                            loginData.showStateSheet = false
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
                .offset(y: loginData.showStateSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showStateSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showStateSheet.toggle()
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
                    loginData.showStateSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct JobLocationStateBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        JobLocationStateBottomSheet()
//    }
//}
