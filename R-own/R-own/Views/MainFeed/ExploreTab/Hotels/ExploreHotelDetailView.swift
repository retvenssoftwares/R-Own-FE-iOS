//
//  ExploreHotelDetailView.swift
//  R-own
//
//  Created by Aman Sharma on 12/07/23.
//

import SwiftUI
import Shimmer

struct ExploreHotelDetailView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @State var hotelID: String
    
    @State var switchToReviews: Bool = false
    
    @Binding var savedStatus: String
    @State var selectedImage: String = ""
    
    @StateObject var hotelService = HotelService()
    
    @State private var currentUrl1: URL?
    @State private var currentUrl2: URL?
    @State private var currentUrl3: URL?
    @State private var currentUrl4: URL?
    @State private var currentUrl5: URL?
    @State private var currentUrl6: URL?
    @State private var currentUrl7: URL?
    
    @State var isLoading: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            VStack{
                if isLoading {
                BasicNavbarView(navbarTitle: "Hotel Details")
                ZStack{
                        ScrollView{
                            VStack{
                                VStack{
                                    if globalVM.hotelData.gallery.count > 0 {
                                        AsyncImage(url: currentUrl1) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/1.8)
                                                .cornerRadius(15)
                                                .clipped()
                                                .overlay{
                                                    HStack{
                                                        Spacer()
                                                        VStack(spacing: 4){
                                                            Spacer()
                                                            if globalVM.hotelData.gallery.count == 1 {
                                                                if globalVM.hotelData.gallery[0].image1 != "" {
                                                                    VStack {
                                                                        AsyncImage(url: currentUrl2) { image in
                                                                            image
                                                                                .resizable()
                                                                                .scaledToFill()
                                                                                .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                                                .border(.white.opacity(0.8), width: 2)
                                                                                .clipped()
                                                                                .onTapGesture {
                                                                                    print(globalVM.hotelData.gallery[0].image1)
                                                                                    selectedImage = globalVM.hotelData.gallery[0].image1
                                                                                }
                                                                        } placeholder: {
                                                                            RoundedRectangle(cornerRadius: 15)
                                                                                .fill(lightGreyUi)
                                                                                .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                                                .shimmering(active: true)
                                                                        }
                                                                        .onAppear {
                                                                            if currentUrl2 == nil {
                                                                                DispatchQueue.main.async {
                                                                                    currentUrl2 = URL(string: globalVM.hotelData.gallery[0].image1)
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                                
                                                                if globalVM.hotelData.gallery[0].image2 != "" {
                                                                    VStack {
                                                                        AsyncImage(url: currentUrl3) { image in
                                                                            image
                                                                                .resizable()
                                                                                .scaledToFill()
                                                                                .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                                                .border(.white.opacity(0.8), width: 2)
                                                                                .clipped()
                                                                                .onTapGesture {
                                                                                    print( globalVM.hotelData.gallery[0].image2)
                                                                                    selectedImage = globalVM.hotelData.gallery[0].image2
                                                                                }
                                                                        } placeholder: {
                                                                            RoundedRectangle(cornerRadius: 15)
                                                                                .fill(lightGreyUi)
                                                                                .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                                                .shimmering(active: true)
                                                                        }
                                                                        .onAppear {
                                                                            if currentUrl3 == nil {
                                                                                DispatchQueue.main.async {
                                                                                    currentUrl3 = URL(string: globalVM.hotelData.gallery[0].image2)
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                                
                                                                if globalVM.hotelData.gallery[0].image3 != "" {
                                                                    VStack {
                                                                        AsyncImage(url: currentUrl4) { image in
                                                                            image
                                                                                .resizable()
                                                                                .scaledToFill()
                                                                                .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                                                .border(.white.opacity(0.8), width: 2)
                                                                                .clipped()
                                                                                .onTapGesture {
                                                                                    print(globalVM.hotelData.gallery[0].image3)
                                                                                    selectedImage = globalVM.hotelData.gallery[0].image3
                                                                                }
                                                                        } placeholder: {
                                                                            RoundedRectangle(cornerRadius: 15)
                                                                                .fill(lightGreyUi)
                                                                                .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                                                .shimmering(active: true)
                                                                        }
                                                                        .onAppear {
                                                                            if currentUrl4 == nil {
                                                                                DispatchQueue.main.async {
                                                                                    currentUrl4 = URL(string: globalVM.hotelData.gallery[0].image3)
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    .padding()
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
                                                                            .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                                            .border(.white.opacity(0.8), width: 2)
                                                                            .clipped()
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
                                                                            .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                                            .border(.white.opacity(0.8), width: 2)
                                                                            .clipped()
                                                                            .onTapGesture {
                                                                                selectedImage = globalVM.hotelData.gallery[0].image2
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
                                                                            .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                                            .border(.white.opacity(0.8), width: 2)
                                                                            .clipped()
                                                                            .onTapGesture {
                                                                                selectedImage = globalVM.hotelData.gallery[0].image3
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
                                        .onChange(of: selectedImage, perform: {_ in
                                            DispatchQueue.main.async {
                                                currentUrl1 = URL(string: selectedImage.replacingOccurrences(of: " ", with: "%20"))
                                            }
                                        })
                                        
                                        
                                    } else {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(lightGreyUi)
                                            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/1.8)
                                            .overlay{
                                                Text("Looks like hotel owner hasn't posted any photos yet")
                                                    .font(.headline)
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
                                            Text(globalVM.hotelData.hotelName)
                                                .font(.title2)
                                                .foregroundColor(.black)
                                                .fontWeight(.bold)
                                            Text(globalVM.hotelData.hotelRating)
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .fontWeight(.bold)
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            if savedStatus == "not saved" {
                                                savedStatus = "saved"
                                            } else {
                                                savedStatus == "saved" 
                                            }
                                        }, label: {
                                            Image(savedStatus == "not saved" ? "UnheartIcon" : "HeartIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                        })
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/15)
                                    .padding(.vertical, UIScreen.screenHeight/40)
                                    VStack(alignment: .leading){
                                        HStack{
                                            Text("Overview")
                                                .font(.headline)
                                                .foregroundColor(.black)
                                                .fontWeight(.semibold)
                                            Spacer()
                                        }
                                        HStack{
                                            
                                            Text(globalVM.hotelData.hoteldescription)
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/15)
                                    .padding(.bottom, UIScreen.screenHeight/70)
                                    VStack{
                                        HStack{
                                            Text("Address")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .fontWeight(.semibold)
                                            Spacer()
                                        }
                                        HStack{
                                            Text(globalVM.hotelData.hotelAddress)
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/15)
                                }
                                VStack{
                                    Button(action: {
                                        openLinkInBrowser()
                                    }) {
                                        Text("Book Now")
                                            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/20)
                                            .background(greenUi)
                                            .foregroundColor(jobsDarkBlue)
                                            .cornerRadius(10)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                    }
                                }
                                Spacer()
                                
                                //                            HStack(spacing: UIScreen.screenWidth/30){
                                //
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
                                //                            }
                            }
                            .frame(width: UIScreen.screenWidth)
                        }
                    }
                } else {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            Task {
                isLoading = false
                globalVM.hotelData = HotelDataModel(id: "", userID: "", hotelName: "", hotelAddress: "", hotelRating: "", hotelLogoURL: "", hotelCoverpicURL: "", bookingengineLink: "", dateAdded: "", hoteldescription: "", displayStatus: "", hotelID: "", gallery: [Gallery](), v: 0)
                let res  = await hotelService.getHotelDataByUserID(globalVM: globalVM, hotelID: hotelID)
                if res == "Success" {
                    isLoading = true
                } else {
                    
                    let res  = await hotelService.getHotelDataByUserID(globalVM: globalVM, hotelID: hotelID)
                    if res == "Success" {
                        isLoading = true
                    } else {
                        dismiss()
                    }
                }
                if globalVM.hotelData.gallery.count == 1 {
                    if globalVM.hotelData.gallery[0].image1 != "" {
                        selectedImage = globalVM.hotelData.gallery[0].image1
                    } else if globalVM.hotelData.gallery[0].image2 != "" {
                        selectedImage = globalVM.hotelData.gallery[0].image2
                    } else if globalVM.hotelData.gallery[0].image3 != "" {
                        selectedImage = globalVM.hotelData.gallery[0].image3
                    }
                }
            }
        }
    }
    func openLinkInBrowser() {
        guard var urlComponents = URLComponents(string: globalVM.hotelData.bookingengineLink) else {
            showAlert(message: "Invalid URL")
            return
        }
        
        if urlComponents.scheme == nil {
            urlComponents.scheme = "https"
        }

        if let url = urlComponents.url {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                showAlert(message: "URL cannot be opened")
            }
        } else {
            showAlert(message: "Invalid URL")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

//struct ExploreHotelDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreHotelDetailView()
//    }
//}
