//
//  HotelSelectBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI

struct HotelSelectBottomSheetView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var hotelSearch: String = ""
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @StateObject var userPCS = UserProfileCompletionService()
    @FocusState private var isKeyboardShowing: Bool
    
    @State var isLoading: Bool = false
    
    var filteredHotels: [HotelNameModel] {
        if hotelSearch.isEmpty {
            return globalVM.hotelNameList
        } else {
            return globalVM.hotelNameList.filter {
                $0.companyName.localizedCaseInsensitiveContains(hotelSearch)
            }
        }
    }
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            Text("Please select your company here")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            TextField("Search hotel", text: $hotelSearch)
                                .font(.body)
                                .frame(width: UIScreen.screenWidth/1.2)
                                .overlay(alignment: .trailing, content: {
                                    Image(systemName: "magnifyingglass")
                                })
                                .focused($isKeyboardShowing)
                                .padding()
                                .border(.black.opacity(0.5))
                            
                            
                            //Location Array
                            if isLoading {
                                ScrollView{
                                    VStack(alignment: .leading){
                                        ForEach(filteredHotels, id: \.self){hotelName in
                                            VStack{
                                                Button(action: {
                                                    loginData.mainUserCompany = hotelName.companyName
                                                    loginData.showHotelSheet.toggle()
                                                }, label: {
                                                    Text(hotelName.companyName )
                                                        .foregroundColor(.black)
                                                        .padding(.vertical, 10)
                                                        .frame(width: UIScreen.screenWidth)
                                                })
                                                Divider()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                        .onAppear{
                            Task{
                                isLoading = false
                                let res = await userPCS.getHotelNameList(globalVM: globalVM)
                                if res == "Success"{
                                    isLoading = true
                                } else {
                                    
                                    let res = await userPCS.getHotelNameList(globalVM: globalVM)
                                    if res == "Success"{
                                        isLoading = true
                                    } else {
                                        isLoading = true
                                    }
                                }
                            }
                        }
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .offset(y: loginData.showHotelSheet ? 0 : UIScreen.main.bounds.height)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showHotelSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showHotelSheet.toggle()
                    }
                }
            )
    }
}

//struct HotelSelectBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelSelectBottomSheet()
//    }
//}
