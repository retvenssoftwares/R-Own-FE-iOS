//
//  EventDetails.swift
//  R-own
//
//  Created by Aman Sharma on 19/05/23.
//

import SwiftUI
import Shimmer

struct EventDetails: View {
    
    @State var savedStatus: Bool = false
    @State var categoryID: String
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var eventBG: String
    @State var eventName: String
    @State var eventPrice: String
    @State var eventDescription: String
    @State var eventProfilePic: String
    @State var eventUserName: String
    
    @StateObject var eventService = UserEventService()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    VStack{
                        //Navbar
                        HStack{
                            //button
                            Button(action: {
                                dismiss()
                            }, label: {
                                Image(systemName: "arrow.backward.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                    .foregroundColor(.black)
                            })
                            
                            Spacer()
                            
                            //text
                            Text("Event Detail")
                                .font(.system(size: UIScreen.screenHeight/60))
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            //button
                            Button(action: {
                                savedStatus.toggle()
                            }, label: {
                                Image(savedStatus ? "HeartIcon" : "UnheartIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                    .foregroundColor(.black)
                            })
                        }
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        .padding(.vertical, UIScreen.screenHeight/70)
                        
                        AsyncImage(url: URL(string: eventBG)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/6)
                                .cornerRadius(10)
                                .padding(.vertical, UIScreen.screenHeight/40)  // Error here
                        } placeholder: {
                            //put your placeholder here
                            Rectangle()
                                .fill(lightGreyUi)
                                .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/6)
                                .shimmering(active: true)
                            
                        }
                    }
                    
                    VStack{
                        
                        HStack{
                            Text(eventName)
                                .font(.system(size: UIScreen.screenHeight/50))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("\(eventPrice) INR")
                                .font(.system(size: UIScreen.screenHeight/80))
                                .fontWeight(.thin)
                                .foregroundColor(greenUi)
                                .padding(10)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(15)
                        }
                        .padding(.vertical, UIScreen.screenHeight/40)
                        
                        HStack{
                            Text("About Event")
                                .font(.system(size: UIScreen.screenHeight/70))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.vertical, UIScreen.screenHeight/70)
                        
                        HStack{
                            
                            Text(eventDescription)
                                .font(.system(size: UIScreen.screenHeight/80))
                                .fontWeight(.light)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding(.vertical, UIScreen.screenHeight/40)
                        
                        HStack{
                            ProfilePictureView(profilePic: eventProfilePic, verified: false, height: UIScreen.screenHeight/50, width: UIScreen.screenHeight/50)
                            Text(eventUserName)
                                .font(.system(size: UIScreen.screenHeight/80))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding(.vertical, UIScreen.screenHeight/55)
                        
                        Divider()
                            .frame(width: UIScreen.screenWidth/1.3)
                        
                        
                    }
                    .padding(.horizontal, UIScreen.screenWidth/20)
                    .padding(.vertical, UIScreen.screenHeight/50)
                    
                    VStack{
                        
                        Button(action: {
                            
                        }, label: {
                            HStack{
                                Image("GMapIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                Text("Open in maps")
                                    .font(.system(size: UIScreen.screenHeight/80))
                                    .fontWeight(.regular)
                                    .foregroundColor(.white)
                            }
                            .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/20)
                            .background(jobsDarkBlue)
                            .cornerRadius(15)
                            .padding(.horizontal, UIScreen.screenWidth/20)
                            .padding(.vertical, UIScreen.screenHeight/40)
                        })
                        
                        Button(action: {
                            
                        }, label: {
                            HStack{
                                Image("CabIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                Text("Get a cab")
                                    .font(.system(size: UIScreen.screenHeight/80))
                                    .fontWeight(.regular)
                                    .foregroundColor(.white)
                            }
                            .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/20)
                            .background(jobsDarkBlue)
                            .cornerRadius(15)
                            .padding(.horizontal, UIScreen.screenWidth/20)
                        })
                        
                        
                    }
                    HStack{
                        Text("Book Now")
                            .font(.system(size: UIScreen.screenHeight/80))
                            .fontWeight(.regular)
                    }
                    .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/20)
                    .background(greenUi)
                    .cornerRadius(15)
                    .padding(.horizontal, UIScreen.screenWidth/20)
                    .padding(.vertical, UIScreen.screenHeight/30)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            eventService.getEventByCategory(globalVM: globalVM, loginData: loginData, categoryID: categoryID)
        }
    }
}

//struct EventDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetails()
//    }
//}
