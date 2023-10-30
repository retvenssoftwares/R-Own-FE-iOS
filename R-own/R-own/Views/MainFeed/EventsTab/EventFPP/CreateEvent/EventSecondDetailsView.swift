//
//  EventSecondDetailsView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI

struct EventSecondDetailsView: View {
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var eventVM: EventViewModel
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var navigateToEventThirdDetailsView: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                //nav
                BasicNavbarView(navbarTitle: "Create An Event")
                
                //body
                VStack{
                    //text
                    Text("Please enter the details about your event")
                        .font(.system(size: UIScreen.screenHeight/40))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    //price email field
                    TextField("Enter event price here..", text: $eventVM.eventPrice)
                        .padding()
                        .cornerRadius(7)
                        .overlay{
                            // apply a rounded border
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 0.5)
                            Text("Event Ticket Price")
                                .font(.system( size: 14))
                                .foregroundColor(.black)
                                .background(Color.white)
                                .padding(.horizontal,5)
                                .fontWeight(.ultraLight)
                                .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                            
                        }
                        .focused($isKeyboardShowing)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()

                                Button("Done") {
                                    
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                                }
                            }
                        }
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    
                    //support email field
                    TextField("Enter support email here..", text: $eventVM.eventSupportEmail)
                        .padding()
                        .cornerRadius(7)
                        .overlay{
                            // apply a rounded border
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 0.5)
                            Text("Support Email")
                                .font(.system( size: 14))
                                .foregroundColor(.black)
                                .background(Color.white)
                                .padding(.horizontal,5)
                                .fontWeight(.ultraLight)
                                .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                            
                        }
                        .focused($isKeyboardShowing)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    
                    //Phone number field
                    TextField("Enter phone number here..", text: $eventVM.eventPhoneNumber)
                        .padding()
                        .cornerRadius(7)
                        .keyboardType(.numberPad)
                        .overlay{
                            // apply a rounded border
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 0.5)
                            Text("Phone No.")
                                .font(.system( size: 14))
                                .foregroundColor(.black)
                                .background(Color.white)
                                .padding(.horizontal,5)
                                .fontWeight(.ultraLight)
                                .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                            
                        }
                        .focused($isKeyboardShowing)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    
                    //Website field
                    TextField("Enter website here..", text: $eventVM.eventWebsite)
                        .padding()
                        .cornerRadius(7)
                        .overlay{
                            // apply a rounded border
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 0.5)
                            Text("Website")
                                .font(.system( size: 14))
                                .foregroundColor(.black)
                                .background(Color.white)
                                .padding(.horizontal,5)
                                .fontWeight(.ultraLight)
                                .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                            
                        }
                        .focused($isKeyboardShowing)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    
                    //Booking Link field
                    TextField("Enter booking link here..", text: $eventVM.eventBookingLink)
                        .padding()
                        .cornerRadius(7)
                        .overlay{
                            // apply a rounded border
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 0.5)
                            Text("Booking Link")
                                .font(.system( size: 14))
                                .foregroundColor(.black)
                                .background(Color.white)
                                .padding(.horizontal,5)
                                .fontWeight(.ultraLight)
                                .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                            
                        }
                        .focused($isKeyboardShowing)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                }
                
                //next button
                Button(action: {
                    navigateToEventThirdDetailsView.toggle()
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
                .navigationDestination(isPresented: $navigateToEventThirdDetailsView, destination: {
                    EventThirdDetailsView(globalVM: globalVM, loginData: loginData, eventVM: eventVM)
                })
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct EventSecondDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventSecondDetailsView()
//    }
//}
