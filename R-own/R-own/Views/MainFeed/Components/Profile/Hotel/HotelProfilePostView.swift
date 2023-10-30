//
//  HotelPostView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct HotelProfilePostView: View {
    @StateObject var globalVM: GlobalViewModel
    @State var hotel: HotelDataByUserID
    @State var role: String
    @State var mainUser: Bool
    @StateObject var loginData: LoginViewModel
    @State var navigateToHotelDetail: Bool = false
    @State var navigateToEditVIew: Bool = false
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            NavigationLink(isActive: $navigateToHotelDetail, destination: {
                HotelDetailView(globalVM: globalVM, hotelGallery: $hotel.gallery, hotelName: $hotel.hotelName, hotelStar: $hotel.hotelRating, hotelOverview: $hotel.hoteldescription, hotelID: hotel.hotelID, hotelLocation: $hotel.hotelAddress, hotelCoverpicURL: $hotel.hotelCoverpicURL, mainUser: mainUser, loginData: loginData, savedStatus: $hotel.saved)}, label: {Text("")})
            VStack{
                AsyncImage(url: currentUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/4)
                        .cornerRadius(15)
                        .clipped()
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                        .overlay{
                            if mainUser{
                                HStack{
                                    Button(action: {
                                        
                                    }, label: {
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(.black)
                                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                            .overlay{
                                                Image("DeleteIcon")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                            }
                                    })
                                }
                                .offset(x: UIScreen.screenWidth/3, y: -UIScreen.screenHeight/10)
                            }
                        }
                        .overlay{
                            VStack{
                                HStack{
                                    Image("LocationIcon")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                    Text(hotel.hotelAddress)
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                    Spacer()
                                }
                                HStack{
                                    Text(hotel.hotelName)
                                        .font(.body)
                                        .fontWeight(.medium)
                                    Spacer()
                                    HStack{
                                        //                                    ForEach(1...5, id: \.self){ _ in
                                        //                                        Image("FeedStaysStarFilled")
                                        //                                            .resizable()
                                        //                                            .scaledToFit()
                                        //                                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                        //                                    }
                                        Text("\(hotel.hotelRating)")
                                            .font(.subheadline)
                                            .fontWeight(.light)
                                    }
                                }
                            }
                            .padding(.vertical, UIScreen.screenHeight/60)
                            .padding(.horizontal, UIScreen.screenWidth/40)
                            .background(.white)
                            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/6)
                            .cornerRadius(15)
                            .clipped()
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                            .offset(y: UIScreen.screenHeight/8)
                        }
                } placeholder: {
                    Rectangle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/4)
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
            .padding(.bottom, UIScreen.screenHeight/24)
            .onTapGesture {
                navigateToHotelDetail.toggle()
            }
        }
    }
}

//struct HotelPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelPostView()
//    }
//}
