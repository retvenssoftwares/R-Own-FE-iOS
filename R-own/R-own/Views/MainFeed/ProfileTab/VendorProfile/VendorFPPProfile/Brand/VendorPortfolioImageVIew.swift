//
//  VendorPortfolioVIew.swift
//  R-own
//
//  Created by Aman Sharma on 04/07/23.
//

import SwiftUI
import Shimmer

struct VendorPortfolioImageVIew: View {
    
    @StateObject var globalVM: GlobalViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentUrl1: URL?
    @State private var currentUrl2: URL?
    @State private var currentUrl3: URL?
    
    var body: some View {
        VStack{
            VStack{
                //Navbar
                HStack{
                    //button
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .foregroundColor(greenUi)
                    })
                    Spacer()
                    //text
                    
                }
                .padding(.horizontal, UIScreen.screenWidth/40)
                .padding(.vertical, UIScreen.screenHeight/70)
                .background(jobsDarkBlue)
                .border(width: 1, edges: [.bottom], color: .black)
            }
            ScrollView{
                VStack{
                    if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink.count > 0 {
                        if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image1 != "" {
                            AsyncImage(url: currentUrl1) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.screenWidth/1.1)
                                    .cornerRadius(10)
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(lightGreyUi)
                                    .frame(width: UIScreen.screenHeight/1.1, height: UIScreen.screenHeight/1.1)
                                    .shimmering(active: true)
                            }
                            .onAppear {
                                if currentUrl1 == nil {
                                    DispatchQueue.main.async {
                                        currentUrl1 = URL(string: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image1)
                                    }
                                }
                            }
                        }
                        if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image2 != "" {
                            AsyncImage(url: currentUrl2) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.screenWidth/1.1)
                                    .cornerRadius(10)
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(lightGreyUi)
                                    .frame(width: UIScreen.screenHeight/1.1, height: UIScreen.screenHeight/1.1)
                                    .shimmering(active: true)
                            }
                            .onAppear {
                                if currentUrl2 == nil {
                                    DispatchQueue.main.async {
                                        currentUrl2 = URL(string: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image2)
                                    }
                                }
                            }
                        }
                        if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image3 != "" {
                            AsyncImage(url: currentUrl3) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.screenWidth/1.1)
                                    .cornerRadius(10)
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(lightGreyUi)
                                    .frame(width: UIScreen.screenHeight/1.1, height: UIScreen.screenHeight/1.1)
                                    .shimmering(active: true)
                            }
                            .onAppear {
                                if currentUrl3 == nil {
                                    DispatchQueue.main.async {
                                        currentUrl3 = URL(string: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image3)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct VendorPortfolioVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorPortfolioVIew()
//    }
//}
