//
//  HotelOwnerHotelsTabView.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import SwiftUI

struct HotelOwnerHotelsTabView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var role: String
    @State var mainUser: Bool
    @State var userID: String
    @StateObject var hotelService = HotelService()
    
    @State var navigateToAddNewHotel: Bool = false
    
    
    var body: some View {
        VStack{
            VStack{
                ScrollView{
                    if globalVM.hotelListByID.count > 0 {
                        VStack{
                            ForEach(0..<globalVM.hotelListByID.count, id: \.self){ count in
                                HStack{
                                    Spacer()
                                    if globalVM.hotelListByID[count].displayStatus != "0" {
                                        HotelProfilePostView(globalVM: globalVM, hotel: globalVM.hotelListByID[count], role: role, mainUser: mainUser, loginData: loginData)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    } else {
                        if mainUser {
                            Image("NoPostScreen")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                .overlay{
                                    Text("You have not posted any hotel yet")
                                        .font(.body)
                                        .frame(width: UIScreen.screenWidth/4)
                                        .fontWeight(.bold)
                                        .foregroundColor(greenUi)
                                        .multilineTextAlignment(.leading)
                                        .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                }
                        } else {
                                if role == "Hotelier" {
                                    Image("NoPostScreen")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                            .overlay{
                                                Text("\(globalVM.getNormalProfileHeader.data.profile.fullName) have not posted any hotel yet")
                                                    .font(.body)
                                                    .frame(width: UIScreen.screenWidth/4)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(greenUi)
                                                    .multilineTextAlignment(.leading)
                                                    .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                            }
                                } else if role == "Business Vendor / Freelancer" {
                                    Image("NoPostScreen")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                            .overlay{
                                                Text("\(globalVM.getVendorProfileHeader.roleDetails.fullName) have not posted any hotel yet")
                                                    .font(.body)
                                                    .frame(width: UIScreen.screenWidth/4)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(greenUi)
                                                    .multilineTextAlignment(.leading)
                                                    .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                            }
                                } else if role == "Hotel Owner" {
                                    Image("NoPostScreen")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                            .overlay{
                                                Text("\(globalVM.getHotelOwnerProfileHeader.profiledata.fullName) have not posted any hotel yet")
                                                    .font(.body)
                                                    .frame(width: UIScreen.screenWidth/4)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(greenUi)
                                                    .multilineTextAlignment(.leading)
                                                    .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                            }
                                } else {
                                    Image("NoPostScreen")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                            .overlay{
                                                Text("\(globalVM.getNormalProfileHeader.data.profile.fullName) have not posted any hotel yet")
                                                    .font(.body)
                                                    .frame(width: UIScreen.screenWidth/4)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(greenUi)
                                                    .multilineTextAlignment(.leading)
                                                    .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                            }
                                }
                        }
                    }
                    if mainUser {
                        if loginData.profileCompletionPercentage == "100"{
                            Button(action: {
                                //                        print(globalVM.getHotelOwnerProfileHeader.hotellogo.hotelLogoURL)
                                navigateToAddNewHotel = true
                            }, label: {
                                Text("Add Hotel")
                                    .font(.body)
                                    .fontWeight(.light)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                    .padding(.vertical, UIScreen.screenHeight/90)
                                    .background(greenUi)
                                    .cornerRadius(10)
                                    .padding()
                            })
                            .navigationDestination(isPresented: $navigateToAddNewHotel, destination: {
                                AddNewPropertyView(loginData: loginData, globalVM: globalVM)
                            })
                            NavigationLink(isActive: $navigateToAddNewHotel, destination: {
                                AddNewPropertyView(loginData: loginData, globalVM: globalVM)
                            }, label: {
                                Text("")
                            })
                        }
                    }
                    
                    Spacer(minLength: UIScreen.screenHeight/8)
                }
            }
        }
        .onAppear{
            navigateToAddNewHotel = false
            hotelService.getHotelsByUserID(globalVM: globalVM, loginData: loginData, userID: userID, viewerID: loginData.mainUserID)
        }
    }
}

//struct HotelOwnerHotelsTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelOwnerHotelsTabView()
//    }
//}
