//
//  ExploreEventsCard.swift
//  R-own
//
//  Created by Aman Sharma on 31/05/23.
//

import SwiftUI
import Shimmer

struct ExploreEventsCard: View {
    
    @State var savedStatus: Bool = false
    @State var event: ExploreEvent
    
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
                                        .font(.body)
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
                        Rectangle()
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
                                Text(event.eventTitle ?? "getching name")
                                    .font(.body)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack{
                                ProfilePictureView(profilePic: event.profilePic ?? "", verified: false, height: UIScreen.screenHeight/80, width: UIScreen.screenHeight/80)
                                Text(event.fullName ?? "fetching user name")
                                    .font(.body)
                                    .fontWeight(.thin)
                                Spacer()
                            }
                            
                        }
                        Text(event.price)
                            .font(.body)
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
                        Text("fetching date")
                            .font(.body)
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
//                EventDetails()
            })
        }
    }
}
//
//struct ExploreEventsCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreEventsCard()
//    }
//}
