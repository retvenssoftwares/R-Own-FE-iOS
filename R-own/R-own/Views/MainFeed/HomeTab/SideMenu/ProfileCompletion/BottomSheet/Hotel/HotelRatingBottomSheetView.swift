//
//  HotelRatingBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI

struct HotelRatingBottomSheetView: View {
    
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
                        
                        VStack(spacing: 20){
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
                                                    
                                                    loginData.hotelRating = "1 Star"
                                                    loginData.showHotelRatingSheet = false
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
                                                    
                                                    loginData.hotelRating = "2 Star"
                                                    loginData.showHotelRatingSheet = false
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
                                                    
                                                    loginData.hotelRating = "3 Star"
                                                    loginData.showHotelRatingSheet = false
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
                                                    
                                                    loginData.hotelRating = "4 Star"
                                                    loginData.showHotelRatingSheet = false
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
                                                    
                                                    loginData.hotelRating = "5 Star"
                                                    loginData.showHotelRatingSheet = false
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
                                                    
                                                    loginData.hotelRating = "6 Star"
                                                    loginData.showHotelRatingSheet = false
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
                                                    
                                                    loginData.hotelRating = "7 Star"
                                                    loginData.showHotelRatingSheet = false
                                                }
                                                Divider()
                                            }
                                        }
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                    }
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
                .offset(y: loginData.showHotelRatingSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showHotelRatingSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showHotelRatingSheet.toggle()
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
                    loginData.showHotelRatingSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct HotelRatingBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelRatingBottomSheetView()
//    }
//}
