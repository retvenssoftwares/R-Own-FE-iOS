//
//  EventDetailsView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI

struct EventDetailsView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var eventVM: EventViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var navigateToEventSecondDetailsView: Bool = false
    @State var openEventCategoryBottomSHeeet: Bool = false
    @StateObject var eventService = UserEventService()
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    //nav
                    BasicNavbarView(navbarTitle: "Create An Event")
                    
                    //body
                    VStack{
                        //text
                        Text("Please enter the details about your event")
                            .font(.system(size: UIScreen.screenHeight/55))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, UIScreen.screenHeight/20)
                        
                        //event title field
                        TextField("Enter title here..", text: $eventVM.eventTitle)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                Text("Event Title")
                                    .font(.system( size: 14))
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                
                            }
                            .focused($isKeyboardShowing)
                            .frame(width: UIScreen.screenWidth/1.2)
                        
                        Text("Event Description")
                            .font(.system(size: UIScreen.screenHeight/55))
                            .fontWeight(.regular)
                            .padding(.vertical, UIScreen.screenHeight/40)
                        
                        //event description field
                        TextEditor(text: $eventVM.eventDescription)
                            .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/4)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                    .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/3.7)
                            }
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                        
                        Text("Event Category")
                            .font(.system(size: UIScreen.screenHeight/55))
                            .fontWeight(.regular)
                            .padding(.vertical, UIScreen.screenHeight/40)
                        
                        
                        //event title field
                        TextField("Enter title here..", text: $eventVM.eventCategory)
                            .disabled(true)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                Text("Event Title")
                                    .font(.system( size: 14))
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                
                            }
                            .focused($isKeyboardShowing)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .frame(width: UIScreen.screenWidth/1.2)
                            .onTapGesture {
                                eventService.getEventCategory(globalVM: globalVM, loginData: loginData, userID: loginData.mainUserID)
                                openEventCategoryBottomSHeeet.toggle()
                            }
                        
                    }
                    
                    //next button
                    Button(action: {
                        navigateToEventSecondDetailsView.toggle()
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
                    .navigationDestination(isPresented: $navigateToEventSecondDetailsView, destination: {
                        EventSecondDetailsView(globalVM: globalVM, loginData: loginData, eventVM: eventVM)
                    })
                    Spacer()
                }
                EventCategoryBottomSheet(loginData: loginData, eventVM: eventVM, bottomSheetToggle: $openEventCategoryBottomSHeeet, globalVM: globalVM)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct EventDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetailsView()
//    }
//}
