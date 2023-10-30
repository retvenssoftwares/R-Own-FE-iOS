//
//  AllEventFPPCardView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI
import Shimmer

struct AllEventFPPCardView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var eventVM: EventViewModel
    @State var navigateToEditEvent: Bool = false
    
    @State var event: EventsByUserIDModel
    var body: some View {
        NavigationStack{
            VStack{
                //image with overlay of edit icon
                AsyncImage(url: URL(string: event.eventThumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/4)
                        .cornerRadius(15)
                        .overlay{
                            Button(action: {
                                navigateToEditEvent.toggle()
                                print("Edit...")
                            }, label: {
                                Circle()
                                    .fill(.white)
                                    .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                    .overlay{
                                        Image("EditPenIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                    }
                            })
                            .offset(x: UIScreen.screenWidth/3, y: -UIScreen.screenHeight/10)
                            .navigationDestination(isPresented: $navigateToEditEvent, destination: {
                                EditEventView(loginData: loginData, globalVM: globalVM, eventVM: eventVM, eventID: event.eventID)
                            })
                        }
                } placeholder: {
                    //put your placeholder here
                    Rectangle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/4)
                        .shimmering(active: true)
                }
                
                HStack{
                    //text of event name
                    Text(event.eventTitle)
                        .font(.system(size: UIScreen.screenHeight/60))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    //Date of event
                    Text(event.eventStartDate)
                }
                
                //Divider
                Divider()
                
                //status of event
                Text("Open")
                    .font(.system(size: UIScreen.screenHeight/70))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .padding(.horizontal, UIScreen.screenWidth/4)
                    .padding(.vertical, 10)
                    .background(greenUi)
                    .cornerRadius(15)
                    .padding(5)
            }
            .padding()
            .frame(width: UIScreen.screenWidth/1.2)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
        }
        .padding()
    }
}

//struct AllEventFPPCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllEventFPPCardView()
//    }
//}
