//
//  HomeFeedServiceListTabView.swift
//  R-own
//
//  Created by Aman Sharma on 12/07/23.
//

import SwiftUI
import Shimmer

struct HomeFeedServiceListTabView: View {
    
    @State var vendor: NewFeedService
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var navigateToServiceDetailPage: Bool = false
    
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
                                VStack{
                                    Spacer()
                                    if vendor.location ?? "" != "" {
                                        HStack(spacing: 2){
                                            Image("MapsPin")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                            Text(extractFirstWord(from: vendor.location ?? "") ?? (vendor.location ?? ""))
                                                .font(.subheadline)
                                                .fontWeight(.thin)
                                                .foregroundColor(.black)
                                                .padding(.horizontal, UIScreen.screenWidth/50)
                                                .padding(.vertical, UIScreen.screenHeight/100)
                                                .background(.white)
                                                .cornerRadius(10)
                                                .padding(.leading, UIScreen.screenWidth/40)
                                            Spacer()
                                        }
                                        .padding(.vertical, UIScreen.screenHeight/110)
                                    }
                                }
                            }
                            .cornerRadius(10)
                            .padding(UIScreen.screenHeight/60)
                    } placeholder: {
                        //put your placeholder here
                        Rectangle()
                            .fill(lightGreyUi)
                            .frame(width: UIScreen.screenHeight/5, height: UIScreen.screenHeight/5)
                            .shimmering(active: true)
                    }
                    .onAppear {
                        if currentUrl == nil {
                            DispatchQueue.main.async {
                                currentUrl = URL(string: vendor.vendorImage.replacingOccurrences(of: " ", with: "%20"))
                            }
                        }
                    }
                }
                VStack{
                    HStack{
                        ProfilePictureView(profilePic: vendor.profilePic ?? "", verified: false, height: UIScreen.screenHeight/40, width: UIScreen.screenHeight/40)
                        VStack(alignment: .leading){
                            Text(vendor.vendorName)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                            if vendor.userName ?? "" != "" {
                                Text(vendor.userName ?? "")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(greenUi)
                            }
                        }
                        Spacer()
                    }
                    Divider()
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    HStack{
                        
                        Text(vendor.serviceName)
                            .font(.subheadline)
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
                    if loginData.isHiddenKPI {
                        Divider()
                            .padding(.horizontal, UIScreen.screenWidth/40)
                        HStack{
                            
//                            VStack{
//                                RatingStarCard(ratingNumber: 3, cardSize: UIScreen.screenHeight/60)
//                                Text("\(vendor.averageRating ?? 0)")
//                                    .font(.system(size: UIScreen.screenHeight/80))
//                                    .fontWeight(.bold)
//                            }
                            
                            //                        VStack{
                            //                            Text("Avg. Price")
                            //                                .font(.system(size: UIScreen.screenHeight/80))
                            //                                .fontWeight(.bold)
                            //                            Text()
                            //                                .font(.system(size: UIScreen.screenHeight/80))
                            //                                .fontWeight(.bold)
                            //                        }
                        }
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/2.7)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
            .onTapGesture {
                navigateToServiceDetailPage = true
            }
            .navigationDestination(isPresented: $navigateToServiceDetailPage, destination: {
                BrandProfileView(loginData: loginData, globalVM: globalVM, userID: vendor.userID, profileVM: profileVM, mesiboVM: mesiboVM, mainUser: false)
            })
            NavigationLink(isActive: $navigateToServiceDetailPage, destination: {
                BrandProfileView(loginData: loginData, globalVM: globalVM, userID: vendor.userID, profileVM: profileVM, mesiboVM: mesiboVM, mainUser: false)
            }, label: {
                Text("")
            })
        }
        .onAppear{
            navigateToServiceDetailPage = false
        }
    }
}

//struct HomeFeedServiceListTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeFeedServiceListTabView()
//    }
//}
