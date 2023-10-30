//
//  HotelEditView.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import SwiftUI
import Shimmer
import Mantis
import AlertToast

struct HotelEditView: View {
    @State var globalVM: GlobalViewModel
    
    
    @State var hotelGallery: [Gallery]
    @State var hotelName: String
    @State var hotelStar: String
    @State var hotelOverview: String
    @State var hotelID: String
    @State var hotelLocation: String
    @State var hotelCoverpicURL: String
    
    
    @State var showLocation: Bool = false
    @State var showRating: Bool = false
    @State var showCountry: Bool = false
    @State var showState: Bool = false
    @State var showCity: Bool = false
    
    @FocusState private var isKeyboardShowing: Bool
    
    
    @State var hotelBG: UIImage = UIImage(named: "demo") ??  UIImage(named: "HotelBGIllustration")!
    @State var hotelBGCropped: UIImage?
    @State var galleryImage1: UIImage = UIImage(named: "demo") ??  UIImage(named: "HotelBGIllustration")!
    @State var galleryImage1Cropped: UIImage?
    @State var galleryImage2: UIImage = UIImage(named: "demo") ??  UIImage(named: "HotelBGIllustration")!
    @State var galleryImage2Cropped: UIImage?
    @State var galleryImage3: UIImage = UIImage(named: "demo") ??  UIImage(named: "HotelBGIllustration")!
    @State var galleryImage3Cropped: UIImage?
    
    @State private var coverPicshowImagePicker = false
    @State private var coverPicshowingCropper = false
    @State private var coverPiccropShapeType: Mantis.CropShapeType = .rect
    @State private var coverPicpresetFixedRatioType: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 3/2)
    @State private var coverPiccropperType: ImageCropperType = .normal
    
    @State private var cropShapeType: Mantis.CropShapeType = .rect
    @State private var presetFixedRatioType: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 3/4)
    @State private var cropperType: ImageCropperType = .normal
    @State private var shouldPresentCropper1 = false
    @State private var shouldPresentCamera1 = false
    
    @State private var shouldPresentCropper2 = false
    @State private var shouldPresentCamera2 = false
    
    @State private var shouldPresentCropper3 = false
    @State private var shouldPresentCamera3 = false
    
    @State var imageList = [UIImage?]()
    @StateObject var locationService = LocationService()
    
    @StateObject var hotelService = HotelService()
    
    @State var alertInfoUpdated = false
    @State var alertInfoCantUpdate = false
    
    @State private var currentUrl1: URL?
    @State private var currentUrl2: URL?
    @State private var currentUrl3: URL?
    @State private var currentUrl4: URL?
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "\(hotelName) Details")
                ScrollView{
                    VStack{
                        VStack{
                            //Text Field Hotel Name
                            TextField("Enter hotel name", text: $hotelName)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                }
                                .overlay{
                                    VStack{
                                        HStack{
                                            Text("Hotel Name")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(y: -27)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            //Text Field Hotel Description
                            
                            TextField("Enter hotel description", text: $hotelOverview)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                }
                                .overlay{
                                    VStack{
                                        HStack{
                                            Text("Hotel Description")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(y: -27)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            //Text Field Hotel Address
                            
                            TextField("Enter Hotel Address", text: $hotelLocation)
                                .disabled(true)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                }
                                .overlay{
                                    VStack{
                                        HStack{
                                            Text("Hotel Address")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset( y: -27)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            //Text Field Hotel Star Rating
                            
                            TextField("Select Hotel Star Rating", text: $hotelStar)
                                .disabled(true)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                }
                                .overlay{
                                    VStack{
                                        HStack{
                                            Text("Hotel Rating")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset( y: -27)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                .sheet(isPresented: $showRating) {
                                    VStack{
                                        Text("Select your hotel star rating")
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.center)
                                            .padding(.top,30)
                                        
                                        
                                        
                                        //Location Array
                                            VStack(alignment: .leading){
                                                
                                                Text("Select One:")
                                                    .foregroundColor(.black)
                                                    .font(.body)
                                                    .fontWeight(.regular)
                                                    .multilineTextAlignment(.center)
                                                    .padding(.top,30)
                                                
                                                ScrollView{
                                                    VStack {
                                                        VStack{
                                                            HStack{
                                                                Text("1 Star")
                                                                    .font(.body)
                                                                    .fontWeight(.bold)
                                                                    .padding(.vertical, UIScreen.screenHeight/90)
                                                                Spacer()
                                                            }
                                                            .onTapGesture {
                                                                
                                                                hotelStar = "1 Star"
                                                                showRating = false
                                                            }
                                                            Divider()
                                                        }
                                                        VStack{
                                                            HStack{
                                                                Text("2 Star")
                                                                    .font(.body)
                                                                    .fontWeight(.bold)
                                                                    .padding(.vertical, UIScreen.screenHeight/90)
                                                                Spacer()
                                                            }
                                                            .onTapGesture {
                                                                
                                                                hotelStar = "2 Star"
                                                                showRating = false
                                                            }
                                                            Divider()
                                                        }
                                                        VStack{
                                                            HStack{
                                                                Text("3 Star")
                                                                    .font(.body)
                                                                    .fontWeight(.bold)
                                                                    .padding(.vertical, UIScreen.screenHeight/90)
                                                                Spacer()
                                                            }
                                                            .onTapGesture {
                                                                
                                                                hotelStar = "3 Star"
                                                                showRating = false
                                                            }
                                                            Divider()
                                                        }
                                                        VStack{
                                                            HStack{
                                                                Text("4 Star")
                                                                    .font(.body)
                                                                    .fontWeight(.bold)
                                                                    .padding(.vertical, UIScreen.screenHeight/90)
                                                                Spacer()
                                                            }
                                                            .onTapGesture {
                                                                
                                                                hotelStar = "4 Star"
                                                                showRating = false
                                                            }
                                                            Divider()
                                                        }
                                                        VStack{
                                                            HStack{
                                                                Text("5 Star")
                                                                    .font(.body)
                                                                    .fontWeight(.bold)
                                                                    .padding(.vertical, UIScreen.screenHeight/90)
                                                                Spacer()
                                                            }
                                                            .onTapGesture {
                                                                
                                                                hotelStar = "5 Star"
                                                                showRating = false
                                                            }
                                                            Divider()
                                                        }
                                                        VStack{
                                                            HStack{
                                                                Text("6 Star")
                                                                    .font(.body)
                                                                    .fontWeight(.bold)
                                                                    .padding(.vertical, UIScreen.screenHeight/90)
                                                                Spacer()
                                                            }
                                                            .onTapGesture {
                                                                
                                                                hotelStar = "6 Star"
                                                                showRating = false
                                                            }
                                                            Divider()
                                                        }
                                                        VStack{
                                                            HStack{
                                                                Text("7 Star")
                                                                    .font(.body)
                                                                    .fontWeight(.bold)
                                                                    .padding(.vertical, UIScreen.screenHeight/90)
                                                                Spacer()
                                                            }
                                                            .onTapGesture{
                                                                
                                                                hotelStar = "7 Star"
                                                                showRating = false
                                                            }
                                                            Divider()
                                                        }
                                                    }
                                                    .padding(.horizontal, UIScreen.screenWidth/40)
                                                }
                                                Spacer()
                                            }
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/12)
                                    .padding(.bottom)
                                    .frame(width: UIScreen.screenWidth/1.5 ,height: UIScreen.screenHeight/1.5)
                                }
                                .onTapGesture {
                                    showRating.toggle()
                                }
                        }
                        .frame(width: UIScreen.screenWidth/1.2)
                        VStack{
                            Text("Hotel Cover Photo")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            VStack{
                                if self.hotelBGCropped != nil {
                                    Image(uiImage: self.hotelBGCropped!)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenWidth/1.3)
                                        .padding(.vertical, UIScreen.screenHeight/30)
                                        .onTapGesture {
                                            coverPicshowImagePicker.toggle()
                                        }
                                } else {
                                    if hotelCoverpicURL != "" {
                                        AsyncImage(url: currentUrl1) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenWidth/1.3)
                                                .padding(.vertical, UIScreen.screenHeight/30)
                                                .onTapGesture {
                                                    coverPicshowImagePicker.toggle()
                                                }
                                        } placeholder: {
                                            Rectangle()
                                                .fill(lightGreyUi)
                                                .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/2.7)
                                                .padding(.vertical, UIScreen.screenHeight/30)
                                                .shimmering(active: true)
                                        }
                                        .onAppear {
                                            if currentUrl1 == nil {
                                                DispatchQueue.main.async {
                                                    currentUrl1 = URL(string: hotelCoverpicURL)
                                                }
                                            }
                                        }
                                    } else {
                                        Image("HotelBGIllustration")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth/1.3)
                                            .padding(.vertical, UIScreen.screenHeight/30)
                                            .onTapGesture {
                                                coverPicshowImagePicker.toggle()
                                            }
                                    }
                                }
                            }
                            .sheet(isPresented: $coverPicshowImagePicker) {
                                ImagePickerView(image: $hotelBGCropped)
                                    .onAppear(perform: {
                                        hotelBGCropped = nil
                                    })
                                    .onDisappear(perform: {
                                        if hotelBGCropped != nil {
                                            coverPicshowingCropper = true
                                        }
                                    })
                            }
                            .fullScreenCover(isPresented: $coverPicshowingCropper, content: {
                                ImageCropper(image: $hotelBGCropped,
                                             cropShapeType: $coverPiccropShapeType,
                                             presetFixedRatioType: $coverPicpresetFixedRatioType,
                                             type: $coverPiccropperType,
                                             cropMandatory: true)
                                    .ignoresSafeArea()
                            })
                            
                        }
                        VStack{
                            Text("Your Hotel Gallery")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            HStack(spacing: UIScreen.screenWidth/40){
                                if hotelGallery.count > 0 {
                                    if hotelGallery[0].image1 != "" {
                                        
                                        AsyncImage(url: currentUrl2) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                                .clipped()
                                                .padding(.vertical, UIScreen.screenHeight/30)
                                                .overlay{
                                                    Button(action: {
                                                        hotelGallery[0].image1 = ""
                                                    }, label: {
                                                        Image(systemName: "xmark.circle")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .foregroundColor(Color.red)
                                                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                    })
                                                    .offset(x: -UIScreen.screenHeight/17, y: -UIScreen.screenWidth/13)
                                                }
                                        } placeholder: {
                                            Rectangle()
                                                .fill(lightGreyUi)
                                                .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                                .padding(.vertical, UIScreen.screenHeight/30)
                                                .padding(.horizontal, UIScreen.screenWidth/30)
                                                .shimmering(active: true)
                                        }
                                        .onAppear {
                                            if currentUrl2 == nil {
                                                DispatchQueue.main.async {
                                                    currentUrl2 = URL(string: hotelGallery[0].image1)
                                                }
                                            }
                                        }
                                    } else {
                                        if self.galleryImage1Cropped != nil {
                                            Image(uiImage: self.galleryImage1Cropped!)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                                .onTapGesture {
                                                    self.shouldPresentCamera1 = true
                                                }
                                        } else {
                                            Rectangle()
                                                .fill(lightGreyUi)
                                                .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                                .padding(.vertical, UIScreen.screenHeight/30)
                                                .onTapGesture {
                                                    self.shouldPresentCamera1 = true
                                                }
                                        }
                                    }
                                    
                                    if hotelGallery[0].image2 != "" {
                                        
                                        AsyncImage(url: currentUrl3) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                                .clipped()
                                                .padding(.vertical, UIScreen.screenHeight/30)
                                                .overlay{
                                                    Button(action: {
                                                        hotelGallery[0].image2 = ""
                                                    }, label: {
                                                        Image(systemName: "xmark.circle")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .foregroundColor(Color.red)
                                                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                    })
                                                    .offset(x: -UIScreen.screenHeight/17, y: -UIScreen.screenWidth/13)
                                                }
                                        } placeholder: {
                                            Rectangle()
                                                .fill(lightGreyUi)
                                                .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                                .padding(.vertical, UIScreen.screenHeight/30)
                                                .padding(.horizontal, UIScreen.screenWidth/30)
                                                .shimmering(active: true)
                                        }
                                        .onAppear {
                                            if currentUrl3 == nil {
                                                DispatchQueue.main.async {
                                                    currentUrl3 = URL(string: hotelGallery[0].image2)
                                                }
                                            }
                                        }
                                    } else {
                                        if self.galleryImage2Cropped != nil {
                                            Image(uiImage: self.galleryImage2Cropped!)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                                .onTapGesture {
                                                    self.shouldPresentCamera2 = true
                                                }
                                        } else {
                                            Rectangle()
                                                .fill(lightGreyUi)
                                                .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                                .padding(.vertical, UIScreen.screenHeight/30)
                                                .onTapGesture {
                                                    self.shouldPresentCamera2 = true
                                                }
                                        }
                                    }
                                
                                    if hotelGallery[0].image3 != "" {
                                        
                                        AsyncImage(url: currentUrl4) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                                .clipped()
                                                .padding(.vertical, UIScreen.screenHeight/30)
                                                .overlay{
                                                    Button(action: {
                                                        hotelGallery[0].image3 = ""
                                                    }, label: {
                                                        Image(systemName: "xmark.circle")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .foregroundColor(Color.red)
                                                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                    })
                                                    .offset(x: -UIScreen.screenHeight/17, y: -UIScreen.screenWidth/13)
                                                }
                                        } placeholder: {
                                            Rectangle()
                                                .fill(lightGreyUi)
                                                .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                                .padding(.vertical, UIScreen.screenHeight/30)
                                                .padding(.horizontal, UIScreen.screenWidth/30)
                                                .shimmering(active: true)
                                        }
                                        .onAppear {
                                            if currentUrl4 == nil {
                                                DispatchQueue.main.async {
                                                    currentUrl4 = URL(string: hotelGallery[0].image3)
                                                }
                                            }
                                        }
                                    } else {
                                        if self.galleryImage3Cropped != nil {
                                            Image(uiImage: self.galleryImage3Cropped!)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                                .onTapGesture {
                                                    self.shouldPresentCamera3 = true
                                                }
                                        } else {
                                            Rectangle()
                                                .fill(lightGreyUi)
                                                .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                                .padding(.vertical, UIScreen.screenHeight/30)
                                                .onTapGesture {
                                                    self.shouldPresentCamera3 = true
                                                }
                                        }
                                    }
                                } else {
                                    
                                    if self.galleryImage1Cropped != nil {
                                        Image(uiImage: self.galleryImage1Cropped!)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                            .onTapGesture {
                                                self.shouldPresentCamera1 = true
                                            }
                                    } else {
                                        Rectangle()
                                            .fill(lightGreyUi)
                                            .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                            .padding(.vertical, UIScreen.screenHeight/30)
                                            .onTapGesture {
                                                self.shouldPresentCamera1 = true
                                            }
                                    }
                                    
                                    if self.galleryImage2Cropped != nil {
                                        Image(uiImage: self.galleryImage2Cropped!)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                            .onTapGesture {
                                                self.shouldPresentCamera2 = true
                                            }
                                    } else {
                                        Rectangle()
                                            .fill(lightGreyUi)
                                            .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                            .padding(.vertical, UIScreen.screenHeight/30)
                                            .onTapGesture {
                                                self.shouldPresentCamera2 = true
                                            }
                                    }
                                    
                                    if self.galleryImage3Cropped != nil {
                                        Image(uiImage: self.galleryImage3Cropped!)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                            .onTapGesture {
                                                self.shouldPresentCamera3 = true
                                            }
                                    } else {
                                        Rectangle()
                                            .fill(lightGreyUi)
                                            .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                            .padding(.vertical, UIScreen.screenHeight/30)
                                            .onTapGesture {
                                                self.shouldPresentCamera3 = true
                                            }
                                    }
                                }
                            }
                            .sheet(isPresented: $shouldPresentCamera1) {
                                ImagePickerView(image: $galleryImage1Cropped)
                                    .onAppear(perform: {
                                        galleryImage1Cropped = nil
                                    })
                                    .onDisappear(perform: {
                                        if galleryImage1Cropped != nil {
                                            shouldPresentCropper1 = true
                                        }
                                    })
                            }
                            .fullScreenCover(isPresented: $shouldPresentCropper1, content: {
                                ImageCropper(image: $galleryImage1Cropped,
                                             cropShapeType: $cropShapeType,
                                             presetFixedRatioType: $presetFixedRatioType,
                                             type: $cropperType,
                                             cropMandatory: true)
                                .ignoresSafeArea()
                                .onDisappear {
                                }
                            })
                            .sheet(isPresented: $shouldPresentCamera2) {
                                ImagePickerView(image: $galleryImage2Cropped)
                                    .onAppear(perform: {
                                        galleryImage2Cropped = nil
                                    })
                                    .onDisappear(perform: {
                                        if galleryImage2Cropped != nil {
                                            shouldPresentCropper2 = true
                                        }
                                    })
                            }
                            .fullScreenCover(isPresented: $shouldPresentCropper2, content: {
                                ImageCropper(image: $galleryImage2Cropped,
                                             cropShapeType: $cropShapeType,
                                             presetFixedRatioType: $presetFixedRatioType,
                                             type: $cropperType,
                                             cropMandatory: true)
                                .ignoresSafeArea()
                                .onDisappear {
                                }
                            })
                            .sheet(isPresented: $shouldPresentCamera3) {
                                ImagePickerView(image: $galleryImage3Cropped)
                                    .onAppear(perform: {
                                        galleryImage3Cropped = nil
                                    })
                                    .onDisappear(perform: {
                                        if galleryImage3Cropped != nil {
                                            shouldPresentCropper3 = true
                                        }
                                    })
                            }
                            .fullScreenCover(isPresented: $shouldPresentCropper3, content: {
                                ImageCropper(image: $galleryImage3Cropped,
                                             cropShapeType: $cropShapeType,
                                             presetFixedRatioType: $presetFixedRatioType,
                                             type: $cropperType,
                                             cropMandatory: true)
                                .ignoresSafeArea()
                                .onDisappear {
                                }
                            })
                        }
                        VStack {
                            Button(action: {
                                Task{
                                    let str = await hotelService.updateHotelData(hotelID: hotelID, hotelCoverpic: hotelBGCropped, galleryImages1: galleryImage1Cropped, galleryImages2: galleryImage2Cropped, galleryImages3: galleryImage3Cropped, hotelName: hotelName, hotelAddress: hotelLocation, Hoteldescription: hotelOverview, hotelRating: hotelStar)
                                    if str == "Success"{
                                        alertInfoUpdated.toggle()
                                    } else {
                                        alertInfoCantUpdate.toggle()
                                    }
                                }
                            }, label: {
                                Text("Update Hotels")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, UIScreen.screenWidth/10)
                                    .padding(.vertical, UIScreen.screenWidth/50)
                                    .background(greenUi)
                                    .cornerRadius(10)
                                    .padding(.horizontal, UIScreen.screenWidth/20)
                                    .padding(.vertical, UIScreen.screenHeight/60)
                            })
                            
                        }
                    }
                    .padding(.horizontal, UIScreen.screenWidth/5)
                }
                Spacer()
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .toast(isPresenting: $alertInfoUpdated, duration: 2, tapToDismiss: true){
            AlertToast( type: .complete(greenUi), title: "Hotel Updated")
        }
        .toast(isPresenting: $alertInfoCantUpdate, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try again!", subTitle: ("Unable to update"))
        }
        .navigationBarBackButtonHidden()
        
    }
    
//    func convertImages() async{
//
//            if hotelGallery.count > 0{
//                for i in 0..<hotelGallery.count{
//                    let url = URL(string: hotelGallery[i].images)
//                        if let data = try? Data(contentsOf: url!)
//                        {
//                            let image: UIImage? = UIImage(data: data)
//                            imageList.append(image)
//                        }
//                }
//            }
//            if self.galleryImage1Cropped != nil {
//                imageList.append(galleryImage1Cropped)
//            }
//            if self.galleryImage2Cropped != nil {
//                imageList.append(galleryImage2Cropped)
//            }
//            if self.galleryImage3Cropped != nil {
//                imageList.append(galleryImage3Cropped)
//            }
//            print(imageList)
//            if hotelBGCropped == nil {
//
//                let url = URL(string: hotelCoverpicURL)
//                    if let data = try? Data(contentsOf: url!)
//                    {
//                        let image: UIImage? = UIImage(data: data)
//                        hotelBGCropped = image
//                    }
//            }
//        print(hotelBGCropped)
//    }
}

//struct HotelEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelEditView()
//    }
//}
