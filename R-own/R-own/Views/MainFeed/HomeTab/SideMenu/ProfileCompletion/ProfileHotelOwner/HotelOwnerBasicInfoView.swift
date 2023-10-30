//
//  HotelOwnerBasicInfoView.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI
import AlertToast
import Mantis

struct HotelOwnerBasicInfoView: View {
    
    //userinfo
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @StateObject var hotelOwnerPCS = HotelOwnerUserProfileCompletionService()
    
    @State var navigateToMainFeed: Bool = false
    @State var navigateToHotelChainDetails: Bool = false
    
    //Curr-View Var
    @FocusState private var isKeyboardShowing: Bool
    
    @State var hotelLogo: UIImage?
    @State var hotelBG: UIImage = UIImage(named: "demo") ??  UIImage(named: "HotelBGIllustration")!
    @State var hotelBGCropped: UIImage?
    @State var hotelBGLink: String = ""
    @State var hotelLogoLink: String = ""
    
    //Image Var
    @State private var showPicker: Bool = false
    @State private var croppedImage: UIImage?
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var userPCS = UserProfileCompletionService()
    
    
    @State private var toastHotelType: Bool = false
    @State private var toastProfilePicNotUploaded: Bool = false
    @State private var toastBackgroundImageNotUploaded: Bool = false
    @State private var toastnumberOfHotel: Bool = false
    @State private var toastHotelChinName: Bool = false
    @State private var toastWebsiteLink: Bool = false
    @State private var toastBookingEngineLink: Bool = false
    @State private var toastHotelName: Bool = false
    @State private var toastHotelDescription: Bool = false
    @State private var toastHotelAddress: Bool = false
    @State private var toastHotelRating: Bool = false
    
    @State private var logoshowImagePicker = false
    @State private var logoshowingCropper = false
    @State private var logocropShapeType: Mantis.CropShapeType = .circle(maskOnly: true)
    @State private var logopresetFixedRatioType: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1/1)
    @State private var logocropperType: ImageCropperType = .normal
    
    
    @State private var coverPicshowImagePicker = false
    @State private var coverPicshowingCropper = false
    @State private var coverPiccropShapeType: Mantis.CropShapeType = .rect
    @State private var coverPicpresetFixedRatioType: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 3/2)
    @State private var coverPiccropperType: ImageCropperType = .normal
    
    @State var isLoading: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack{
                ScrollView {
                    VStack{
                        //Text Heading
                        Text("Your information helps you discover new community, vendors and employees")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, UIScreen.screenHeight/40)
                            .fontWeight(.bold)
                        
                        VStack{
                            if loginData.hotelType == "Hotel Chain" {
                                HStack{
                                    //uploadimage
                                    VStack{
                                        Circle()
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(.black)
                                            .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                                            .overlay{
                                                if let hotelLogo{
                                                    Image(uiImage: hotelLogo)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: UIScreen.screenHeight/12, height: UIScreen.screenHeight/12)
                                                        .clipShape(Circle())
                                                        .onTapGesture {
                                                            logoshowImagePicker.toggle()
                                                        }
                                                } else {
                                                    Image("HotelChainLogoIcon")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                        .padding()
                                                        .clipShape(Circle())
                                                        .offset(y:8)
                                                        .onTapGesture {
                                                            logoshowImagePicker.toggle()
                                                        }
                                                }
                                            }
                                            .overlay{
                                                Circle()
                                                    .stroke(lineWidth: 1)
                                            }
                                    }
                                    .padding(.vertical,40)
                                    //text
                                    Text("Select your group hotel chain logo")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.thin)
                                    Spacer()
                                }
                                .padding(.horizontal, UIScreen.screenWidth/20)
                            }
                        }
                        .sheet(isPresented: $logoshowImagePicker) {
                            ImagePickerView(image: $hotelLogo)
                                .onAppear(perform: {
                                    hotelLogo = nil
                                })
                                .onDisappear(perform: {
                                    if hotelLogo != nil {
                                        logoshowingCropper = true
                                    }
                                })
                        }
                        .fullScreenCover(isPresented: $logoshowingCropper, content: {
                            ImageCropper(image: $hotelLogo,
                                         cropShapeType: $logocropShapeType,
                                         presetFixedRatioType: $logopresetFixedRatioType,
                                         type: $logocropperType,
                                         cropMandatory: true)
                                .ignoresSafeArea()
                        })
                        
                        //TextField Hotel Type
                        Button(action: {
                            loginData.showHotelTypeSheet.toggle()
                        }, label: {
                            TextField("Select Hotel Type", text: $loginData.hotelType)
                                .disabled(true)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                    Text("Hotel Type")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/2.9, y: -27)
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                        })
                        
                        if loginData.hotelType == "Single Hotel" {
                            //hotel BG icon & hotel logo icon
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
                                        .overlay{
                                            Spacer()
                                            //uploadimage
                                            VStack{
                                                Circle()
                                                    .fill(.white)
                                                    .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                                                    .overlay{
                                                        if let hotelLogo{
                                                            Image(uiImage: hotelLogo)
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: UIScreen.screenHeight/12, height: UIScreen.screenHeight/12)
                                                                .clipShape(Circle())
                                                                .onTapGesture {
                                                                    logoshowImagePicker.toggle()
                                                                }
                                                        } else {
                                                            Image("HotelChainLogoIcon")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                                .padding()
                                                                .clipShape(Circle())
                                                                .offset(y:8)
                                                                .onTapGesture {
                                                                    logoshowImagePicker.toggle()
                                                                }
                                                        }
                                                    }
                                            }
                                            .offset(y: UIScreen.screenHeight/15)
                                            .padding(.vertical,40)
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
                                        .overlay{
                                            
                                            //uploadimage
                                            VStack{
                                                Spacer()
                                                Circle()
                                                    .fill(.white)
                                                    .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                                                    .overlay{
                                                        if let hotelLogo{
                                                            Image(uiImage: hotelLogo)
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: UIScreen.screenHeight/12, height: UIScreen.screenHeight/12)
                                                                .clipShape(Circle())
                                                                .onTapGesture {
                                                                    logoshowImagePicker.toggle()
                                                                }
                                                        } else {
                                                            Image("HotelChainLogoIcon")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                                                .padding()
                                                                .clipShape(Circle())
                                                                .offset(y:8)
                                                                .onTapGesture {
                                                                    logoshowImagePicker.toggle()
                                                                }
                                                        }
                                                    }
                                                    .overlay{
                                                        Circle()
                                                            .stroke(lineWidth: 1)
                                                    }
                                            }
                                            .offset(y: UIScreen.screenHeight/15)
                                            .padding(.vertical,40)
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
                            //Text Field Hotel Name
                            
                            TextField("Enter hotel name", text: $loginData.hotelName)
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
                                                .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                .padding(.top, UIScreen.screenHeight/50)
                            
                            
                            //text field book engine link
                            TextField("Enter hotel description", text: $loginData.hotelDescription)
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
                                                .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            
                            AutoFetchLocationTab(autoLocation: $loginData.hotelAddress, loginData: loginData, globalVM: globalVM, width: UIScreen.screenWidth/1.1)
                            
                            //Text Field Hotel Address
                            
                            //Text Field Hotel Star Rating
                            
                            TextField("Select Hotel Star Rating", text: $loginData.hotelRating)
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
                                                .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                                .onTapGesture {
                                    loginData.showHotelRatingSheet.toggle()
                                }
                            
                            //text field website link
                            TextField("Enter website link", text: $loginData.hotelWebsiteLink)
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
                                            Text("Website Link")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            //text field book engine link
                            TextField("Enter booking engine link", text: $loginData.hotelBookingEngineLink)
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
                                            Text("Booking Engine Link")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                        }
                        if loginData.hotelType == "Hotel Chain" {
                            //text field no of hotel
                            TextField("Enter number of hotels", text: $loginData.noOfHotels)
                                .padding()
                                .cornerRadius(7)
                                .keyboardType(.numberPad)
                                .focused($isKeyboardShowing)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                }
                                .overlay{
                                    VStack{
                                        HStack{
                                            Text("No. of hotels")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .onChange(of: loginData.noOfHotels) { newValue in
                                                    let filteredValue = newValue.filter { $0.isNumber }
                                                    if filteredValue.count > 4 {
                                                        loginData.noOfHotels = String(filteredValue.prefix(4))
                                                    } else {
                                                        loginData.noOfHotels = filteredValue
                                                    }
                                                }
                                                .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            //text field hotel chain name
                            TextField("Enter hotel chain name", text: $loginData.hotelChainName)
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
                                            Text("Hotel Chain Name")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            //text field website link
                            TextField("Enter website link", text: $loginData.hotelWebsiteLink)
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
                                            Text("Website Link")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            //text field book engine link
                            TextField("Enter booking engine link", text: $loginData.hotelBookingEngineLink)
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
                                            Text("Booking Engine Link")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/105)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                        }
                        
                        Spacer()
                        
                        
                        //Button Next
                        Button(action: {
                            if loginData.hotelType == ""{
                                toastHotelType.toggle()
                            } else if loginData.hotelType == "Single Hotel" {
                                if hotelLogo == nil {
                                    toastProfilePicNotUploaded.toggle()
                                } else if hotelBGCropped == nil {
                                    toastBackgroundImageNotUploaded.toggle()
                                } else if loginData.hotelName == "" {
                                    toastHotelName.toggle()
                                } else if loginData.hotelAddress == "" {
                                    toastHotelAddress.toggle()
                                } else if loginData.hotelRating == "" {
                                    toastHotelRating.toggle()
                                } else if loginData.hotelDescription == "" {
                                    toastHotelDescription.toggle()
                                } else {
                                    loginData.profileCompletionPercentage = "100"
                                    hotelOwnerPCS.updateHotelOwnerInfo(loginData: loginData)
                                    hotelOwnerPCS.updateHotelInfoIndividually(loginData: loginData, hotelLogo: hotelLogo!, hotelBG: hotelBGCropped!, hotelName: loginData.hotelName, hotelAddress: loginData.hotelAddress, hotelRating: loginData.hotelRating, hotelDescription: loginData.hotelDescription)
                                    userPCS.updateUserProfileCompletionStatus(loginData: loginData)
                                    navigateToMainFeed = true
                                }
                            } else if loginData.hotelType == "Hotel Chain" {
                                if Int(loginData.noOfHotels)! < 2 {
                                    toastnumberOfHotel.toggle()
                                } else if hotelLogo == nil {
                                    toastProfilePicNotUploaded.toggle()
                                } else if loginData.hotelChainName == "" {
                                    toastHotelChinName.toggle()
                                } else {
                                    navigateToHotelChainDetails = true
                                }
                            }
                        }) {
                            Text("Next")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.light)
                                .padding(.vertical, 10)
                                .padding(.horizontal, UIScreen.screenWidth/5)
                                .background(greenUi)
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                        .padding(.bottom, UIScreen.screenHeight/40)
                        .navigationDestination(isPresented: $navigateToMainFeed, destination: {
                            MainFeedView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, isLoading: $isLoading)
                        })
                        .navigationDestination(isPresented: $navigateToHotelChainDetails, destination: {
                            HotelChainInfoView(loginData: loginData, globalVM: globalVM, profileVM: profileVM, hotelLogo: hotelLogo)
                        })
                    }
                    .padding(UIScreen.screenHeight/40)
                }
                MainLocationBottomSheetView(loginData: loginData, globalVM: globalVM, location: $loginData.hotelAddress)
                HotelRatingBottomSheetView(loginData: loginData)
                HotelTypeBottomSheetView(loginData: loginData)
                
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
        .toast(isPresenting: $toastHotelType, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel Type not set", subTitle: ("Set your hotel type to proceed"))
        }
        .toast(isPresenting: $toastProfilePicNotUploaded, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel Logo not set", subTitle: ("Set your hotel logo to proceed"))
        }
        .toast(isPresenting: $toastBackgroundImageNotUploaded, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel Cover Pic not set", subTitle: ("Set your hotel cover pic to proceed"))
        }
        .toast(isPresenting: $toastnumberOfHotel, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel No. is less than 2", subTitle: ("Set number of hotel is greater than 2"))
        }
        .toast(isPresenting: $toastHotelChinName, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel chain name not set", subTitle: ("Set your hotel chain name to proceed"))
        }
        .toast(isPresenting: $toastWebsiteLink, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Website link not set", subTitle: ("Set your website link to proceed"))
        }
        .toast(isPresenting: $toastBookingEngineLink, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Booking Engine link not set", subTitle: ("Set your booking engine link to proceed"))
        }
        .toast(isPresenting: $toastHotelName, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel Name not set", subTitle: ("Set your hotel name to proceed"))
        }
        .toast(isPresenting: $toastHotelDescription, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel Description not set", subTitle: ("Set your hotel description to proceed"))
        }
        .toast(isPresenting: $toastHotelAddress, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel Address not set", subTitle: ("Set your hotel address to proceed"))
        }
        .toast(isPresenting: $toastHotelRating, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel Rating not set", subTitle: ("Set your hotel rating to proceed"))
        }
    }
    func isImageEmpty(_ image: UIImage) -> Bool {
        return image.size == CGSize.zero
    }
}

//struct HotelOwnerBasicInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelOwnerBasicInfoView()
//    }
//}
