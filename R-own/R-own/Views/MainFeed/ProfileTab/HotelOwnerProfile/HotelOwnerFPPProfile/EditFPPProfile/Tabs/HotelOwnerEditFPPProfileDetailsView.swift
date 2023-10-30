//
//  HotelOwnerEditFPPProfileDetailsView.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import SwiftUI
import Combine

struct HotelOwnerEditFPPProfileDetailsView: View {
    
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @Binding var newBookingEngineLink: String
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
            ZStack {
                
                if globalVM.getHotelOwnerInfo.hotelOwnerInfo.count > 0 {
                    VStack{
                        
                        //username
                        
                        VStack{
                            ZStack{
                                Divider()
                                    .background(greenUi)
                                    .overlay{
                                        Text("Change your hotel name")
                                            .font(.body)
                                            .fontWeight(.thin)
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                            .foregroundColor(greenUi)
                                            .background(.white)
                                            .offset(x: -UIScreen.screenWidth/3)
                                    }
                            }
                            TextField("Enter Hotel Name", text: $globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.hotelownerName)
                                .autocapitalization(.none)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                .padding(.vertical, UIScreen.screenHeight/60)
                                .focused($isKeyboardShowing)
                            
                        }
                        
                        //edit bio
                        VStack{
                            
                            Divider()
                                .background(greenUi)
                                .overlay{
                                    Text("Edit your hotel description")
                                        .font(.body)
                                        .fontWeight(.thin)
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                        .foregroundColor(greenUi)
                                        .background(.white)
                                        .offset(x: -UIScreen.screenWidth/3)
                                }
                            
                            TextEditor(text: $globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.hotelDescription)
                                .frame(height: UIScreen.screenHeight/8)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                .focused($isKeyboardShowing)
                        }
                        
                        
                        
                        //gender
                        VStack{
                            Divider()
                                .background(greenUi)
                                .overlay{
                                    Text("Your hotel type")
                                        .font(.body)
                                        .fontWeight(.thin)
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                        .foregroundColor(greenUi)
                                        .background(.white)
                                        .offset(x: -UIScreen.screenWidth/3)
                                }
                            ScrollView(.horizontal){
                                HStack{
                                    Button(action: {
                                        globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.hotelType = "Single Hotel"
                                    }, label: {
                                        HStack{
                                            Text("Single Hotel")
                                                .foregroundColor(.black)
                                            Image(globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.hotelType == "Single Hotel" ? "PollsSelected": "PollsUnselected")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                        }
                                        .padding(.horizontal, UIScreen.screenWidth/50)
                                        .padding(.vertical, UIScreen.screenHeight/80)
                                        .background(.white)
                                        .cornerRadius(5)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                    })
                                    .padding()
                                    
                                    
                                    Button(action: {
                                        globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.hotelType = "Hotel Chain"
                                    }, label: {
                                        HStack{
                                            Text("Hotel Chain")
                                                .foregroundColor(.black)
                                            Image(globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.hotelType == "Hotel Chain" ? "PollsSelected": "PollsUnselected")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                        }
                                        .padding(.horizontal, UIScreen.screenWidth/50)
                                        .padding(.vertical, UIScreen.screenHeight/80)
                                        .background(.white)
                                        .cornerRadius(5)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                    })
                                    .padding()
                                }
                            }
                            .padding(.vertical, UIScreen.screenHeight/50)
                        }
                        
                        //website
                        VStack{
                            ZStack{
                                Divider()
                                    .background(greenUi)
                                    .overlay{
                                        Text("Change your Website Link")
                                            .font(.body)
                                            .fontWeight(.thin)
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                            .foregroundColor(greenUi)
                                            .background(.white)
                                            .offset(x: -UIScreen.screenWidth/3)
                                    }
                            }
                            TextField("Enter Website Link", text: $globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.websiteLink)
                                .autocapitalization(.none)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                .padding(.vertical, UIScreen.screenHeight/60)
                                .focused($isKeyboardShowing)
                            //
                        }
                        
                        //booking engine
                        VStack{
                            ZStack{
                                Divider()
                                    .background(greenUi)
                                    .overlay{
                                        Text("Change your booking engine link")
                                            .font(.body)
                                            .fontWeight(.thin)
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                            .foregroundColor(greenUi)
                                            .background(.white)
                                            .offset(x: -UIScreen.screenWidth/3)
                                    }
                            }
                            TextField("Enter Booking Engine Link", text: $globalVM.getHotelOwnerInfo.hotelOwnerInfo[0].hotelOwnerInfo.bookingEngineLink)
                                .autocapitalization(.none)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                .padding(.vertical, UIScreen.screenHeight/60)
                                .focused($isKeyboardShowing)
                            
                        }
                    }
                }
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
    }
}
//
//struct HotelOwnerEditFPPProfileDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelOwnerEditFPPProfileDetailsView()
//    }
//}
