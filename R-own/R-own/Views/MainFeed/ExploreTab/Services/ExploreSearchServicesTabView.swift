//
//  ExploreSearchServicesTabView.swift
//  R-own
//
//  Created by Aman Sharma on 11/07/23.
//

import SwiftUI
import Shimmer

struct ExploreSearchServicesTabView: View {
    
    @State var vendor: ExploreServiceSearch
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
                            .frame(width: UIScreen.screenHeight/4, height: UIScreen.screenHeight/4)
                            .overlay{
                                VStack {
                                    Spacer()
                                    if vendor.location != "" {
                                        HStack(spacing: 2){
                                            HStack{
                                                Image("MapsPin")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                                Text(extractFirstWord(from: vendor.location ) ?? (vendor.location ))
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
                                currentUrl = URL(string: vendor.vendorImage.replacingOccurrences(of: " ", with: "%20"))
                            }
                        }
                    }
                }
                Spacer()
                VStack{
                    HStack{
                        ProfilePictureView(profilePic: vendor.profilePic ?? "", verified: false, height: UIScreen.screenHeight/30, width: UIScreen.screenHeight/30)
                        VStack(alignment: .leading){
                            Text(vendor.vendorName)
                                .font(.body)
                                .fontWeight(.thin)
                                .foregroundColor(.black)
                            Text(vendor.userName)
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(greenUi)
                        }
                        Spacer()
                    }
                    Divider()
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    HStack{
                        
                        Text(vendor.serviceName)
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
                .padding()
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

//struct ExploreSearchServicesTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreSearchServicesTabView()
//    }
//}
