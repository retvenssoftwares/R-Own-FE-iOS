//
//  SavedServicesCardView.swift
//  R-own
//
//  Created by Aman Sharma on 18/06/23.
//

import SwiftUI

struct SavedServicesCardView: View {
    
    @State var service: ServiceSave
    
    @State var navigateToBlogsDetailView: Bool = false
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack {
            VStack{
                ZStack{
                    AsyncImage(url: currentUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.screenHeight/5, height: UIScreen.screenHeight/5)
                            .overlay{
                                HStack{
                                    Image("MapsPin")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                    Text(service.location)
                                        .font(.body)
                                        .fontWeight(.thin)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 5)
                                        .padding(.vertical, 5)
                                        .cornerRadius(5)
                                        .padding(.leading, UIScreen.screenWidth/40)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.white, lineWidth: 1)
                                        )
                                    Spacer()
                                }
                                .offset(y: UIScreen.screenHeight/12)
                            }
                            .cornerRadius(15)
                            .padding(UIScreen.screenHeight/60)
                    }placeholder: {
                        //put your placeholder here
                        Rectangle()
                            .fill(lightGreyUi)
                            .frame(width: UIScreen.screenHeight/5, height: UIScreen.screenHeight/5)
                            .shimmering(active: true)
                    }
                    .onAppear {
                        if currentUrl == nil {
                            DispatchQueue.main.async {
                                currentUrl = URL(string: service.vendorImage.replacingOccurrences(of: " ", with: "%20"))
                            }
                        }
                    }
                }
                Spacer()
                VStack{
                    HStack{
                        ProfilePictureView(profilePic: service.profilePic, verified: false, height: UIScreen.screenHeight/80, width: UIScreen.screenHeight/80)
                        VStack{
                            Text(service.vendorName )
                                .font(.body)
                                .fontWeight(.thin)
                                .foregroundColor(.black)
                            Text(service.userName)
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(greenUi)
                        }
                    }
                    Divider()
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    HStack{
//                        ForEach(0...3, id: \.self){_ in
                            
                        Text(service.vendorName)
                            .font(.body)
                            .fontWeight(.thin)
                            .foregroundColor(.black)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 5)
                            .background(.white)
                            .cornerRadius(5)
                            .padding(.leading, UIScreen.screenWidth/40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                    
                    Divider()
                        .padding(.horizontal, UIScreen.screenWidth/40)
                    
                    HStack{
                        
                        VStack{
                            RatingStarCard(ratingNumber: 3, cardSize: UIScreen.screenHeight/60)
                            Text("3.0 (23)")
                                .font(.body)
                                .fontWeight(.bold)
                        }
                        
                        VStack{
                            Text("Avg. Price")
                                .font(.body)
                                .fontWeight(.bold)
                            Text(service.vendorServicePrice)
                                .font(.body)
                                .fontWeight(.bold)
                        }
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenHeight/3)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
        }
    }
}

//struct SavedServicesCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedServicesCardView()
//    }
//}
