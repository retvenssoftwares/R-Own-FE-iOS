//
//  NearestConcertCard.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI
import Shimmer

struct NearestConcertCard: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var savedStatus: Bool = false
    @State var event: NearestConcertModel
    
    @State var navigateToEventDetailView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                ZStack{
                    
                    AsyncImage(url: URL(string: event.eventThumbnail)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenHeight/5)
                            .clipped()
                            .overlay{
                                HStack{
                                    Text(event.categoryName)
                                        .font(.system(size: UIScreen.screenHeight/90))
                                        .fontWeight(.thin)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 5)
                                        .padding(.vertical, 5)
                                        .background(.white)
                                        .cornerRadius(5)
                                        .padding(.leading, UIScreen.screenWidth/40)
                                    Spacer()
                                    Button(action: {
                                        savedStatus.toggle()
                                    }, label: {
                                        Image(savedStatus ? "HeartIcon" : "UnheartIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                            .padding(.trailing, UIScreen.screenWidth/40)
                                    })
                                }
                                .offset(y:-UIScreen.screenHeight/14)
                            }
                    } placeholder: {
                        //put your placeholder here
                        Circle()
                            .fill(lightGreyUi)
                            .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenHeight/5)
                            .shimmering(active: true)
                    }
                }
                Spacer()
                VStack{
                    HStack{
                        VStack{
                            HStack{
                                Text(event.eventTitle)
                                    .font(.system(size: UIScreen.screenHeight/80))
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack{
                                ProfilePictureView(profilePic: event.profilePic ?? "", verified: false, height: UIScreen.screenHeight/80, width: UIScreen.screenHeight/80)
                                Text(event.userName)
                                    .font(.system(size: UIScreen.screenHeight/100))
                                    .fontWeight(.thin)
                                Spacer()
                            }
                            
                        }
                        Text(event.price)
                            .font(.system(size: UIScreen.screenHeight/110))
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 5)
                            .background(greyUi)
                            .cornerRadius(5)
                    }
                    Divider()
                        .padding(.horizontal, UIScreen.screenWidth/40)
                    HStack{
//                        Text("182 Participants")
//                            .font(.system(size: UIScreen.screenHeight/110))
//                            .fontWeight(.bold)
                        Spacer()
                        Text(event.dateAdded)
                            .font(.system(size: UIScreen.screenHeight/110))
                            .fontWeight(.light)
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenHeight/3)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
            .padding(.horizontal, UIScreen.screenWidth/40)
            .onTapGesture {
                navigateToEventDetailView.toggle()
            }
            .navigationDestination(isPresented: $navigateToEventDetailView, destination: {
                EventDetails(categoryID: event.categoryID, loginData: loginData, globalVM: globalVM, eventBG: event.eventThumbnail, eventName: event.eventTitle, eventPrice: event.price, eventDescription: event.eventDescription, eventProfilePic: event.profilePic, eventUserName: event.userName)
            })
        }
    }
}

//struct NearestConcertCard_Previews: PreviewProvider {
//    static var previews: some View {
//        NearestConcertCard()
//    }
//}
