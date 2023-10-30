//
//  HotelChainInfoView.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI
import AlertToast

struct HotelChainInfoView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var hotelLogo: UIImage?
    
    @StateObject var hotelOwnerPCS = HotelOwnerUserProfileCompletionService()
    
    @StateObject var userPCS = UserProfileCompletionService()
    @State var navigateToMainFeed: Bool = false
    
    @State var toastHotelCOverPic: Bool = false
    @State var toastHotelName: Bool = false
    @State var toastHotelDescp: Bool = false
    @State var toastHotelAddress: Bool = false
    @State var toastHotelRating: Bool = false
    @State var savedNoOfHotel: Int = 0
    @State var toastPostNotSaved: Bool = false
    
    @State var isLoading: Bool = true
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack{
                        //Text Heading
                        Text("All Properties Details")
                            .font(.title3)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .padding(.horizontal,5)
                            .fontWeight(.bold)
                        
                        
                        //Loop of hotel description
                        VStack{
                            ForEach(1...(Int(loginData.noOfHotels) ?? 2), id: \.self) { index in
                                HotelDescriptionView(loginData: loginData, globalVM: globalVM, hotelNumber: index, notSaved: $savedNoOfHotel, hotelLogo: hotelLogo, toastHotelCOverPic: $toastHotelCOverPic,toastHotelName: $toastHotelName, toastHotelDescp: $toastHotelDescp, toastHotelAddress: $toastHotelAddress, toastHotelRating: $toastHotelRating)
                            }
                        }
                        
                        
                        Spacer()
                        
                        //button next
                        Button(action: {
                            if savedNoOfHotel != Int(loginData.noOfHotels)! {
                                toastPostNotSaved.toggle()
                            } else {
                                loginData.profileCompletionPercentage = "100"
                                hotelOwnerPCS.updateHotelOwnerInfo(loginData: loginData)
                                if loginData.hotelChainList.count == Int(loginData.noOfHotels) {
                                    for i in 0..<loginData.hotelChainList.count {
                                        hotelOwnerPCS.updateHotelInfoIndividually(loginData: loginData, hotelLogo: loginData.hotelChainList[i].hotelProfilepicURL!, hotelBG: loginData.hotelChainList[i].hotelCoverpicURL!, hotelName: loginData.hotelChainList[i].hotelName, hotelAddress: loginData.hotelChainList[i].hotelAddress, hotelRating: loginData.hotelChainList[i].hotelRating, hotelDescription: loginData.hotelChainList[i].hotelDescription)
                                    }
                                }
                                userPCS.updateUserProfileCompletionStatus(loginData: loginData)
                                navigateToMainFeed = true
                            }
                        }) {
                            Text("Next")
                                .foregroundColor(.black)
                                .font(.body)
                                .padding(.vertical, 10)
                                .padding(.horizontal, UIScreen.screenWidth/5)
                                .background(greenUi)
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                        .padding(.bottom, UIScreen.screenHeight/40)
                        .navigationDestination(isPresented: $navigateToMainFeed, destination: {
                            MainFeedView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, isLoading: $isLoading)
                        })
                    }
                    .padding(UIScreen.screenHeight/40)
                }
                HotelLocationBottomSheetView(loginData: loginData)
                HotelRatingBottomSheetView(loginData: loginData)
            }
        }
        .navigationBarBackButtonHidden()
        .toast(isPresenting: $toastHotelCOverPic, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel cover picture not set", subTitle: ("Set your hotel cover picture to proceed"))
        }
        .toast(isPresenting: $toastHotelName, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel Name not set", subTitle: ("Set your hotel Name to proceed"))
        }
        .toast(isPresenting: $toastHotelDescp, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel Desciption not set", subTitle: ("Set your hotel Desciption to proceed"))
        }
        .toast(isPresenting: $toastHotelAddress, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel Address not set", subTitle: ("Set your hotel Address to proceed"))
        }
        .toast(isPresenting: $toastHotelRating, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel Rating not set", subTitle: ("Set your hotel Rating to proceed"))
        }
        .toast(isPresenting: $toastPostNotSaved, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel is not saved", subTitle: ("Save all hotels to proceed"))
        }
        .onAppear{
            loginData.hotelChainList = [Hotel]()
            savedNoOfHotel = 0
        }
    }
}

//struct HotelChainInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelChainInfoView()
//    }
//}
