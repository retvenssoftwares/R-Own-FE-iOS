//
//  ExploreServicesTabView.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import SwiftUI
import Shimmer

struct ExploreServicesTabView: View {
    
    @State var vendor: ExploreVendor
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var navigateToServiceDetailPage: Bool = false
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack {
            VStack{
                AsyncImage(url: currentUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.screenHeight/4, height: UIScreen.screenHeight/4)
                        .overlay{
                                VStack {
                                    Spacer()
                                    if vendor.location ?? "" != "" {
                                        HStack{
                                            HStack(spacing: 2){
                                                Image("MapsPin")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                                Text(extractFirstWord(from: vendor.location ?? "") ?? (vendor.location ?? ""))
                                                    .font(.footnote)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(10)
                                                    .padding(.leading, UIScreen.screenWidth/40)
                                            }
                                            .padding(.horizontal, UIScreen.screenWidth/50)
                                            .padding(.vertical, UIScreen.screenHeight/110)
                                            .background(.black)
                                            .cornerRadius(10)
                                            Spacer()
                                        }
                                        .padding(.vertical, UIScreen.screenHeight/110)
                                        .padding(.leading, UIScreen.screenWidth/15)
                                    }
                                }
                        }
                        .cornerRadius(15)
                }placeholder: {
                    //put your placeholder here
                    Rectangle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenHeight/4, height: UIScreen.screenHeight/4)
                        .shimmering(active: true)
                }
                .onAppear {
                    if currentUrl == nil {
                        DispatchQueue.main.async {
                            currentUrl = URL(string: vendor.vendorImage ?? "")
                        }
                    }
                }
                Spacer()
                VStack{
                    HStack{
                        ProfilePictureView(profilePic: vendor.profilePic ?? "", verified: false, height: UIScreen.screenHeight/30, width: UIScreen.screenHeight/30)
                        VStack(alignment: .leading){
                            if vendor.vendorName ?? "" != "" {
                                Text(vendor.vendorName!)
                                    .font(.body)
                                    .fontWeight(.thin)
                                    .foregroundColor(.black)
                            }
                            if vendor.userName ?? "" != "" {
                                Text(vendor.userName!)
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(greenUi)
                            }
                        }
                        Spacer()
                    }
                    Divider()
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    HStack{
                        if vendor.vendorServices.count > 0 {
                            ForEach(0..<(vendor.vendorServices.count < 2 ? vendor.vendorServices.count : 1), id: \.self){ count in
                                
                                Text(vendor.vendorServices[count].serviceName ?? "")
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
                            if vendor.vendorServices.count > 1 {
                                Text("and \(vendor.vendorServices.count - 1) more...")
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
                        } else {
                            
                            Text("Vendor needs to update")
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
                    }
                    .padding(.vertical, UIScreen.screenHeight/110)
                    if loginData.isHiddenKPI {
                        Divider()
                            .padding(.horizontal, UIScreen.screenWidth/40)
                        HStack{
                            VStack{
                                RatingStarCard(ratingNumber: 3, cardSize: UIScreen.screenHeight/60)
                                Text("\(vendor.averageRating)")
                                    .font(.body)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }
            }
            .frame(width: UIScreen.screenWidth/2.2, height: UIScreen.screenHeight/2.5)
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

//struct ExploreServicesTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreServicesTabView()
//    }
//}
