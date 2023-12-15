//
//  HomeFeedHotelCard.swift
//  R-own
//
//  Created by Aman Sharma on 28/07/23.
//

import SwiftUI
import Shimmer

struct HomeFeedHotelCard: View {
    @State var hotel: NewFeedHotel
    @State var globalVM: GlobalViewModel
    @State var loginData: LoginViewModel
    
    
    @StateObject var saveService = SaveElemetsIDService()
    
    @State var navigateToHotelDetail: Bool = false
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            VStack{
                
                AsyncImage(url: currentUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/4)
                        .clipped()
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                        .overlay{
                            VStack{
                                Spacer()
                                HStack{
                                    VStack{
                                        HStack{
                                            Image("LocationIcon")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                            Text(extractFirstWord(from: hotel.hotelAddress) ?? hotel.hotelAddress)
                                                .font(.subheadline)
                                                .fontWeight(.light)
                                            Spacer()
                                        }
                                        HStack{
                                            Text(hotel.hotelName)
                                                .font(.subheadline)
                                                .fontWeight(.regular)
                                            Spacer()
                                        }
                                        HStack{
                                            Image("FeedStaysStarFilled")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                            Text(hotel.hotelRating)
                                                .font(.subheadline)
                                                .fontWeight(.regular)
                                            //                            RatingStarCard(ratingNumber: Int(hotel.averageRating ?? 0.0), cardSize: UIScreen.screenHeight/60)
                                            Spacer()
                                        }
                                    }
                                    Spacer()
                                    VStack{
                                        Spacer()
                                        Button(action: {
                                            if hotel.saved == "not saved" {
                                                saveService.saveHotelID(loginData: loginData, hotelID: hotel.hotelID)
                                                hotel.saved = "saved"
                                            } else {
                                                saveService.unsaveHotelID(loginData: loginData, hotelID: hotel.hotelID)
                                                hotel.saved = "not saved"
                                            }
                                        }, label: {
                                            Image(hotel.saved == "not saved" ? "UnheartIcon" : "HeartIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                        })
                                        Spacer()
                                    }
                                }
                                .frame(width: UIScreen.screenWidth/2.9, height: UIScreen.screenHeight/15)
                                .padding(UIScreen.screenHeight/100)
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.horizontal, UIScreen.screenWidth/50)
                                .padding(.vertical, UIScreen.screenHeight/70)
                            }
                            
                        }
                } placeholder: {
                    //put your placeholder here
                    Rectangle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/4)
                        .cornerRadius(15)
                        .shimmering(active: true)
                }
                .onAppear {
                    if currentUrl == nil {
                        DispatchQueue.main.async {
                            currentUrl = URL(string: hotel.hotelCoverpicURL)
                        }
                    }
                }
                //                }
            }
            .onTapGesture {
                navigateToHotelDetail.toggle()
            }
            .navigationDestination(isPresented: $navigateToHotelDetail, destination: {
                ExploreHotelDetailView(globalVM: globalVM, hotelID: hotel.hotelID, savedStatus: $hotel.saved)
            })
            NavigationLink(isActive: $navigateToHotelDetail, destination: {
                ExploreHotelDetailView(globalVM: globalVM, hotelID: hotel.hotelID, savedStatus: $hotel.saved)
            }, label: {
                Text("")
            })
        }
        .onAppear{
            navigateToHotelDetail = false
        }
    }
}

//struct HomeFeedHotelCard_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeFeedHotelCard()
//    }
//}
