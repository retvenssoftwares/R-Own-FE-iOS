//
//  CreateEventView.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI

struct CreateEventView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var eventVM: EventViewModel
    
    @State var navigateToEventDetailsView: Bool = false
    
    @StateObject var hotelService = HotelService()
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    //Nav
                    BasicNavbarView(navbarTitle: "Create an Event")
                    
                    VStack{
                        //Text (Multiline)
                        Text("Please enter the details about your venue")
                            .font(.system(size: UIScreen.screenHeight/40))
                            .fontWeight(.bold)
                            .padding(.vertical, UIScreen.screenHeight/20)
                        VStack{
                            //location text
                            Text("Where is your venue ?")
                                .font(.system(size: UIScreen.screenHeight/55))
                                .fontWeight(.regular)
                                .padding(.vertical, UIScreen.screenHeight/40)
                            
                            //location field
                            Button(action: {
                                loginData.mainLocationBottomSheet.toggle()
                            }, label: {
                                TextField("Select Venue Location", text: $eventVM.eventLocationLocation)
                                    .disabled(true)
                                    .padding()
                                    .cornerRadius(7)
                                    .overlay{
                                        // apply a rounded border
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(.gray, lineWidth: 0.5)
                                        Text("Location")
                                            .font(.system( size: 14))
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal,5)
                                            .fontWeight(.ultraLight)
                                            .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                        
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                            })
                        }
                        VStack{
                            //venue text
                            Text("Enter the name of your venue")
                                .font(.system(size: UIScreen.screenHeight/55))
                                .fontWeight(.regular)
                                .padding(.vertical, UIScreen.screenHeight/40)
                            
                            //venue field
                            
                            Button(action: {
                                hotelService.getHotelsByUserID(globalVM: globalVM, loginData: loginData, userID: loginData.mainUserID, viewerID: loginData.mainUserID)
                                eventVM.showVenueBottomSheet.toggle()
                            }, label: {
                                TextField("Select the name of your venue here", text: $eventVM.selectedVenue)
                                    .disabled(true)
                                    .padding()
                                    .cornerRadius(7)
                                    .overlay{
                                        // apply a rounded border
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(.gray, lineWidth: 0.5)
                                        Text("Venue")
                                            .font(.system( size: 14))
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal,5)
                                            .fontWeight(.ultraLight)
                                            .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                        
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                            })
                        }
                        Spacer()
                        //next button
                        Button(action: {
                            navigateToEventDetailsView.toggle()
                        }, label: {
                            Text("Next")
                                .font(.system(size: UIScreen.screenHeight/60))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.vertical, UIScreen.screenHeight/80)
                                .padding(.horizontal, UIScreen.screenHeight/60)
                                .background(greenUi)
                                .cornerRadius(5)
                                .padding(UIScreen.screenHeight/60)
                            
                        })
                        .navigationDestination(isPresented: $navigateToEventDetailsView, destination: {
                            EventDetailsView(loginData: loginData, eventVM: eventVM, globalVM: globalVM)
                        })
                        Spacer()
                    }
                }
                MainLocationBottomSheetView(loginData: loginData, globalVM: globalVM, location: $eventVM.eventLocationLocation)
//                EventLocationBottomSheet(loginData: loginData, eventVM: eventVM, country: $eventVM.eventLocationCountry, state: $eventVM.eventLocationState, city: $eventVM.eventLocationCity)
                EventVenueBottomSheet(globalVM: globalVM, eventVM: eventVM, venueName: $eventVM.selectedVenue, venueID: $eventVM.selectedVenueID)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct CreateEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateEventView()
//    }
//}
