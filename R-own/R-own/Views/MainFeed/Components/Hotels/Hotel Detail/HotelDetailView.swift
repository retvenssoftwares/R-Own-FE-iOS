//
//  HotelDetailView.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import SwiftUI
import Shimmer

struct HotelDetailView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @Binding var hotelGallery: [Gallery]
    @Binding var hotelName: String
    @Binding var hotelStar: String
    @Binding var hotelOverview: String
    @State var hotelID: String
    @Binding var hotelLocation: String
    @Binding var hotelCoverpicURL: String
    @State var mainUser: Bool
    @State var loginData: LoginViewModel
    @Binding var savedStatus: String
    @State var selectedImage: String = ""
    
    @State var switchToEditView: Bool = false
    @State var switchToReviews: Bool = false
    
    @StateObject var saveService = SaveElemetsIDService()
    
    @State private var currentUrl1: URL?
    @State private var currentUrl2: URL?
    @State private var currentUrl3: URL?
    @State private var currentUrl4: URL?
    @State private var currentUrl5: URL?
    @State private var currentUrl6: URL?
    @State private var currentUrl7: URL?
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "")
                ZStack{
                    ScrollView{
                        VStack{
                            VStack{
                                if hotelGallery.count > 0 {
                                    AsyncImage(url: currentUrl1) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/1.8)
                                            .cornerRadius(15)
                                            .overlay{
                                                VStack{
                                                    Spacer()
                                                    HStack{
                                                        Spacer()
                                                        VStack(spacing: 4){
                                                            
                                                            if hotelGallery[0].image1 != "" {
                                                                VStack {
                                                                    AsyncImage(url: currentUrl2) { image in
                                                                        image
                                                                            .resizable()
                                                                            .scaledToFill()
                                                                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                            .cornerRadius(15)
                                                                            .border(.white.opacity(0.8), width: 5)
                                                                            .onTapGesture {
                                                                                selectedImage = hotelGallery[0].image1
                                                                            }
                                                                    } placeholder: {
                                                                        RoundedRectangle(cornerRadius: 15)
                                                                            .fill(lightGreyUi)
                                                                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                            .shimmering(active: true)
                                                                    }
                                                                    .onAppear {
                                                                        if currentUrl2 == nil {
                                                                            DispatchQueue.main.async {
                                                                                currentUrl2 = URL(string: hotelGallery[0].image1)
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                            
                                                            if hotelGallery[0].image2 != "" {
                                                                VStack {
                                                                    AsyncImage(url: currentUrl3) { image in
                                                                        image
                                                                            .resizable()
                                                                            .scaledToFill()
                                                                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                            .cornerRadius(15)
                                                                            .border(.white.opacity(0.8), width: 5)
                                                                            .onTapGesture {
                                                                                selectedImage = hotelGallery[0].image2
                                                                            }
                                                                    } placeholder: {
                                                                        RoundedRectangle(cornerRadius: 15)
                                                                            .fill(lightGreyUi)
                                                                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                            .shimmering(active: true)
                                                                    }
                                                                    .onAppear {
                                                                        if currentUrl3 == nil {
                                                                            DispatchQueue.main.async {
                                                                                currentUrl3 = URL(string: hotelGallery[0].image2)
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                            
                                                            if hotelGallery[0].image3 != "" {
                                                                VStack {
                                                                    AsyncImage(url: currentUrl4) { image in
                                                                        image
                                                                            .resizable()
                                                                            .scaledToFill()
                                                                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                            .cornerRadius(15)
                                                                            .border(.white.opacity(0.8), width: 5)
                                                                            .onTapGesture {
                                                                                selectedImage = hotelGallery[0].image3
                                                                            }
                                                                    } placeholder: {
                                                                        RoundedRectangle(cornerRadius: 15)
                                                                            .fill(lightGreyUi)
                                                                            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                            .shimmering(active: true)
                                                                    }
                                                                    .onAppear {
                                                                        if currentUrl4 == nil {
                                                                            DispatchQueue.main.async {
                                                                                currentUrl4 = URL(string: hotelGallery[0].image3)
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                                        .padding(.vertical, UIScreen.screenHeight/80)
                                                    }
                                                }
                                            }
                                    } placeholder: {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(lightGreyUi)
                                            .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/1.8)
                                            .shimmering(active: true)
                                            .overlay{
                                                VStack(spacing: 4){
                                                    if globalVM.hotelData.gallery.count == 1 {
                                                        if globalVM.hotelData.gallery[0].image1 != "" {
                                                            VStack {
                                                                AsyncImage(url: currentUrl5) { image in
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFill()
                                                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                        .cornerRadius(15)
                                                                        .border(.white.opacity(0.8), width: 5)
                                                                        .onTapGesture {
                                                                            selectedImage = globalVM.hotelData.gallery[0].image1
                                                                        }
                                                                } placeholder: {
                                                                    RoundedRectangle(cornerRadius: 15)
                                                                        .fill(lightGreyUi)
                                                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                        .shimmering(active: true)
                                                                }
                                                                .onAppear {
                                                                    if currentUrl5 == nil {
                                                                        DispatchQueue.main.async {
                                                                            currentUrl5 = URL(string: globalVM.hotelData.gallery[0].image1)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        if globalVM.hotelData.gallery[0].image2 != "" {
                                                            VStack {
                                                                AsyncImage(url: currentUrl6) { image in
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFill()
                                                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                        .cornerRadius(15)
                                                                        .border(.white.opacity(0.8), width: 5)
                                                                        .onTapGesture {
                                                                            selectedImage = globalVM.hotelData.gallery[0].image1
                                                                        }
                                                                } placeholder: {
                                                                    RoundedRectangle(cornerRadius: 15)
                                                                        .fill(lightGreyUi)
                                                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                        .shimmering(active: true)
                                                                }
                                                                .onAppear {
                                                                    if currentUrl6 == nil {
                                                                        DispatchQueue.main.async {
                                                                            currentUrl6 = URL(string: globalVM.hotelData.gallery[0].image2)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        if globalVM.hotelData.gallery[0].image3 != "" {
                                                            VStack {
                                                                AsyncImage(url: currentUrl7) { image in
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFill()
                                                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                        .cornerRadius(15)
                                                                        .border(.white.opacity(0.8), width: 5)
                                                                        .onTapGesture {
                                                                            selectedImage = globalVM.hotelData.gallery[0].image1
                                                                        }
                                                                } placeholder: {
                                                                    RoundedRectangle(cornerRadius: 15)
                                                                        .fill(lightGreyUi)
                                                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                        .shimmering(active: true)
                                                                }
                                                                .onAppear {
                                                                    if currentUrl7 == nil {
                                                                        DispatchQueue.main.async {
                                                                            currentUrl7 = URL(string: globalVM.hotelData.gallery[0].image3)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                    }
                                    .onAppear {
                                        if currentUrl1 == nil {
                                            DispatchQueue.main.async {
                                                currentUrl1 = URL(string: selectedImage.replacingOccurrences(of: " ", with: "%20"))
                                            }
                                        }
                                    }
                                    
                                    
                                } else {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(lightGreyUi)
                                        .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/1.8)
                                        .overlay{
                                            Text("Looks like hotel owner hasn't posted any photos yet")
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .foregroundColor(greenUi)
                                                .multilineTextAlignment(.center)
                                                .frame(width: UIScreen.screenWidth/4)
                                                .offset(x: -UIScreen.screenWidth/10)
                                        }
                                        .overlay{
                                            Image("WaiterSVG")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: UIScreen.screenHeight/3)
                                                .offset(x: UIScreen.screenWidth/10 )
                                        }
                                }
                            }
                            VStack{
                                HStack{
                                    
                                    VStack(alignment: .leading){
                                        Text(hotelName)
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)
                                        Text(hotelStar)
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        if savedStatus == "saved" {
                                            saveService.unsaveHotelID(loginData: loginData, hotelID: hotelID)
                                            savedStatus = "not saved"
                                        } else {
                                            saveService.saveHotelID(loginData: loginData, hotelID: hotelID)
                                            savedStatus = "saved"
                                        }
                                    }, label: {
                                        Image(savedStatus == "saved" ? "HeartIcon" : "UnheartIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                    })
                                }
                                .padding(.horizontal, UIScreen.screenWidth/15)
                                .padding(.vertical, UIScreen.screenHeight/40)
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("OverView")
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }
                                    HStack{
                                        
                                        Text(hotelOverview)
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .fontWeight(.light)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal, UIScreen.screenWidth/15)
                                VStack{
                                    HStack{
                                        Text("Address")
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }
                                    HStack{
                                        Text(hotelLocation)
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .fontWeight(.light)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal, UIScreen.screenWidth/15)
                                .padding(.vertical, UIScreen.screenHeight/70)
                            }
                            
                            Spacer()
                            
                            if mainUser{
                                HStack(spacing: UIScreen.screenWidth/30){
                                    Button(action: {
                                        switchToEditView = true
                                    }, label: {
                                        Text("Edit")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)
                                            .padding(.horizontal, UIScreen.screenWidth/8)
                                            .padding(.vertical, UIScreen.screenHeight/70)
                                            .overlay{
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.black , lineWidth: 1)
                                            }
                                    })
                                    .navigationDestination(isPresented: $switchToEditView, destination: {
                                        HotelEditView(globalVM: globalVM, hotelGallery: hotelGallery, hotelName: hotelName, hotelStar: hotelStar, hotelOverview: hotelOverview, hotelID: hotelID, hotelLocation: hotelLocation, hotelCoverpicURL: hotelCoverpicURL)
                                    })
                                    NavigationLink(isActive: $switchToEditView, destination: {
                                        HotelEditView(globalVM: globalVM, hotelGallery: hotelGallery, hotelName: hotelName, hotelStar: hotelStar, hotelOverview: hotelOverview, hotelID: hotelID, hotelLocation: hotelLocation, hotelCoverpicURL: hotelCoverpicURL)
                                    }, label: {
                                        Text("")
                                    })
                                }
//                                Button(action: {
//                                    switchToReviews.toggle()
//                                }, label: {
//                                    Text("Check Reviews")
//                                        .font(.system(size: UIScreen.screenHeight/70))
//                                        .foregroundColor(.white)
//                                        .fontWeight(.bold)
//                                        .padding(.horizontal, UIScreen.screenWidth/15)
//                                        .padding(.vertical, UIScreen.screenHeight/70)
//                                        .background(greenUi)
//                                        .cornerRadius(10)
//
//                                })
//                                .navigationDestination(isPresented: $switchToReviews, destination: {
//                                    HotelReviewsView(hotelID: hotelID)
//                                })
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            switchToEditView = false
            if hotelGallery.count > 0 {
                if hotelGallery[0].image1 != "" {
                    selectedImage = hotelGallery[0].image1
                } else if hotelGallery[0].image2 != "" {
                    selectedImage = hotelGallery[0].image2
                } else if hotelGallery[0].image3 != "" {
                    selectedImage = hotelGallery[0].image3
                }
            }
        }
    }
}

//struct HotelDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelDetailView()
//    }
//}
