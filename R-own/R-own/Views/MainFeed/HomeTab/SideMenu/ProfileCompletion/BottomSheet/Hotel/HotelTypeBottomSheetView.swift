//
//  HotelTypeBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI

struct HotelTypeBottomSheetView: View {
    
    @StateObject var loginData: LoginViewModel
    
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                    VStack(alignment: .leading){
                            Text("What type of hotel is?")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,UIScreen.screenHeight/50)
                            
                            //Hotel Type
                                VStack(alignment: .leading){
                                    VStack{
                                        Button(action: {
                                            loginData.hotelType = "Single Hotel"
                                            loginData.noOfHotels = "1"
                                            loginData.showHotelTypeSheet = false
                                        }, label: {
                                            HStack{
                                                Text("Single Hotel")
                                                    .font(.body)
                                                    .foregroundColor(.black)
                                                Spacer()
                                                if loginData.hotelType == "Single Hotel" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                }
                                            }
                                        })
                                        Divider()
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/40)
                                    VStack{
                                        Button(action: {
                                            loginData.hotelType = "Hotel Chain"
                                            loginData.noOfHotels = "2"
                                            loginData.showHotelTypeSheet = false
                                        }, label: {
                                            HStack{
                                                Text("Hotel Chain")
                                                    .font(.body)
                                                    .foregroundColor(.black)
                                                Spacer()
                                                if loginData.hotelType == "Hotel Chain" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                }
                                            }
                                        })
                                    }
                                }
                            Spacer()
                        }
                        .padding(.horizontal, UIScreen.screenWidth/20)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/4)
                }
                .padding(UIScreen.screenHeight/40)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: loginData.showHotelTypeSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showHotelTypeSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showHotelTypeSheet.toggle()
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
                    loginData.showHotelTypeSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct HotelTypeBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelTypeBottomSheetView()
//    }
//}
