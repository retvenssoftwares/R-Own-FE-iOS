//
//  ExploreHotelsTabView.swift
//  R-own
//
//  Created by Aman Sharma on 27/05/23.
//

import SwiftUI
import Shimmer

struct ExploreHotelsTabView: View {
    @State var hotel: ExploreHotelPost
    @State var globalVM: GlobalViewModel
    @State var loginData: LoginViewModel
    
    
    @StateObject var saveService = SaveElemetsIDService()
    
    @State var navigateToHotelDetail: Bool = false
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: {
                ExploreHotelDetailView(globalVM: globalVM, hotelID: hotel.hotelID, savedStatus: $hotel.saved)
            }, label: {
                VStack{
                    //                if mainUser{
                    //                    Image("HotelPreviewDemo")
                    //                        .resizable()
                    //                        .scaledToFit()
                    //                        .frame(width: UIScreen.screenWidth/1.4, height: UIScreen.screenHeight/6)
                    //                        .overlay{
                    //                                HStack{
                    //                                    Text("Edit")
                    //                                        .font(.system(size: UIScreen.screenHeight/110))
                    //                                        .padding()
                    //                                        .background(.white)
                    //                                        .cornerRadius(5)
                    //                                    Image("DeleteIcon")
                    //                                        .resizable()
                    //                                        .scaledToFit()
                    //                                        .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                    //                                }
                    //                                .offset(x: UIScreen.screenWidth/3, y: -UIScreen.screenHeight/10)
                    //                        }
                    //                } else {
                    
                    AsyncImage(url: currentUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenWidth/2.2, height: UIScreen.screenHeight/4)
                            .cornerRadius(15)
                            .clipped()
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                            .overlay{
                                VStack{
                                    Spacer()
                                    HStack{
                                        VStack(spacing: 0){
                                            HStack{
                                                Image("LocationIcon")
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                                Text(extractFirstWord(from: hotel.hotelAddress) ?? hotel.hotelAddress)
                                                    .font(.footnote)
                                                    .fontWeight(.light)
                                                    .foregroundColor(.black)
                                                Spacer()
                                            }
                                            HStack{
                                                Text(hotel.hotelName)
                                                    .font(.body)
                                                    .fontWeight(.regular)
                                                    .foregroundColor(.black)
                                                Spacer()
                                            }
                                            HStack{
                                                Image("FeedStaysStarFilled")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                Text(hotel.hotelRating)
                                                    .font(.footnote)
                                                    .fontWeight(.regular)
                                                    .foregroundColor(.black)
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
                                                    .frame(width: UIScreen.screenHeight/25, height: UIScreen.screenHeight/25)
                                            })
                                            Spacer()
                                        }
                                    }
                                    .frame(width: UIScreen.screenWidth/2.4, height: UIScreen.screenHeight/14)
                                    .padding(5)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal, UIScreen.screenWidth/50)
                                    .padding(.vertical, UIScreen.screenHeight/100)
                                }
                                
                            }
                    } placeholder: {
                        //put your placeholder here
                        Rectangle()
                            .fill(lightGreyUi)
                            .frame(width: UIScreen.screenWidth/2.2, height: UIScreen.screenHeight/4)
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
            })
        }
    }
}

//struct ExploreHotelsTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreHotelsTabView()
//    }
//}
