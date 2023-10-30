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
                ZStack{
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
                                        VStack(alignment: .leading){
                                            Text(hotel.hotelName )
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            HStack{
                                                Image("LocationIcon")
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: UIScreen.screenHeight/90, height: UIScreen.screenHeight/90)
                                                Text(hotel.hotelAddress)
                                                    .font(.footnote)
                                                    .fontWeight(.light)
                                                Spacer()
                                            }
                                            HStack{
                                                Text(hotel.hotelRating)
                                                    .font(.footnote)
                                                    .fontWeight(.medium)
                                            }
                                        }
                                        .background(.white)
                                        .frame(width: UIScreen.screenWidth/2.7, height: UIScreen.screenHeight/14)
                                    }
                                }
                        } placeholder: {
                            //put your placeholder here
                            Rectangle()
                                .fill(lightGreyUi)
                                .frame(width: UIScreen.screenHeight/2.5, height: UIScreen.screenHeight/4)
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
                    .padding(5)
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, UIScreen.screenWidth/50)
                    .padding(.vertical, UIScreen.screenHeight/40)
                    .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/4)
                    .onTapGesture {
                        navigateToDetail.toggle()
                    }
                    .navigationDestination(isPresented: $navigateToDetail, destination: {
                        ExploreHotelDetailView(globalVM: globalVM, hotelID: hotel.hotelid, savedStatus: $savedStatus)
                    })
                }
            }
        }
    }
}
//struct SavedHotelCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedHotelCardView()
//    }
//}
