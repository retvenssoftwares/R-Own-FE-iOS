//
//  SavedHotelCardView.swift
//  R-own
//
//  Created by Aman Sharma on 18/06/23.
//

import SwiftUI
import Shimmer

struct SavedHotelCardView: View {
    
    @State var hotel: HotelSave
    
    @State var savedStatus: String = "saved"
    
    @State var navigateToDetail: Bool = false
    
    @State private var currentUrl: URL?
    @State var globalVM: GlobalViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                    VStack{
                        AsyncImage(url: currentUrl) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.screenWidth/2.2, height: UIScreen.screenHeight/4)
                                .clipped()
                                .cornerRadius(15)
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
                                                    Text(hotel.hotelAddress)
                                                        .font(.footnote)
                                                        .fontWeight(.light)
                                                        .foregroundColor(.black)
                                                    Spacer()
                                                }
                                                HStack{
                                                    Text(hotel.hotelName )
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
                                                    Spacer()
                                                }
                                            }
                                            .background(.white)
                                            .frame(width: UIScreen.screenWidth/2.7, height: UIScreen.screenHeight/14)
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
                    }
                    .onTapGesture {
                        navigateToDetail = true
                    }
                    .navigationDestination(isPresented: $navigateToDetail, destination: {
                        ExploreHotelDetailView(globalVM: globalVM, hotelID: hotel.hotelid, savedStatus: $savedStatus)
                    })
                NavigationLink(isActive: $navigateToDetail, destination: {
                    ExploreHotelDetailView(globalVM: globalVM, hotelID: hotel.hotelid, savedStatus: $savedStatus)
                }, label: {
                    Text("")
                })
            }
        }
        .onAppear{
            navigateToDetail = false
        }
    }
}
//struct SavedHotelCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedHotelCardView()
//    }
//}
