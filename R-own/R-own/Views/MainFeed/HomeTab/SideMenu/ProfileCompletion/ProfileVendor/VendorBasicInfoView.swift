//
//  VendorBasicInfoView.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI
import AlertToast
import Mantis

struct VendorBasicInfoView: View {
    
    //userinfo
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var vendorPCS = VendorUserProfileCompletionService()
    
    @StateObject var userPCS = UserProfileCompletionService()
    @State var navigateToMainFeed: Bool = false
    
    @State var vendorImageURL: String = ""
    @State var vendorPortfolio1: UIImage?
    @State var vendorPortfolio2: UIImage?
    @State var vendorPortfolio3: UIImage?
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State private var logoshowImagePicker = false
    @State private var logoshowingCropper = false
    @State private var logocropShapeType: Mantis.CropShapeType = .circle(maskOnly: true)
    @State private var logopresetFixedRatioType: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1/1)
    @State private var logocropperType: ImageCropperType = .normal
    @State private var newBrandLogo: UIImage?
    
    //Image Var
    @State private var showPicker: Bool = false
    @State private var croppedImage: UIImage?
    
    
    @State var toastProfilePicture: Bool = false
    @State var toastbrandName: Bool = false
    @State var toastBrandDescription: Bool = false
    @State var toastBrandServices: Bool = false
    
    @State var serviceSearch: String = ""
    
    @State var isLoading: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    //Text Heading
                    Text("Your information helps you discover new owners, peoples and jobs opportunities")
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                        .padding(.top, UIScreen.screenHeight/40)
                        .fontWeight(.bold)
                    HStack{
                        //Vendor Logo
                        HStack{
                            //uploadimage
                            
                            VStack{
                                Circle()
                                    .strokeBorder(Color.black,lineWidth: 1)
                                    .background(Color.white)
                                    .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                                    .overlay{
                                        if let newBrandLogo{
                                        Image(uiImage: newBrandLogo)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/12, height: UIScreen.screenHeight/12)
                                            .clipShape(Circle())
                                            .overlay{
                                                Image("HotelIconUploadCameraIcon")
                                                    .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                                    .offset(x:UIScreen.screenHeight/30,y:UIScreen.screenHeight/30)
                                                    .onTapGesture {
                                                        logoshowImagePicker.toggle()
                                                    }
                                            }
                                        } else {
                                            Image("HotelChainLogoIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                .clipShape(Circle())
                                                .offset(y:8)
                                                .overlay{
                                                    Image("HotelIconUploadCameraIcon")
                                                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                                        .offset(x:UIScreen.screenHeight/30,y:UIScreen.screenHeight/30)
                                                        .onTapGesture {
                                                            logoshowImagePicker.toggle()
                                                        }
                                                }
                                        }
                                    }
                                }
                            .padding(.vertical,UIScreen.screenHeight/50)
                            .sheet(isPresented: $logoshowImagePicker) {
                                ImagePickerView(image: $newBrandLogo)
                                    .onAppear(perform: {
                                        newBrandLogo = nil
                                    })
                                    .onDisappear(perform: {
                                        if newBrandLogo != nil {
                                            logoshowingCropper = true
                                        }
                                    })
                            }
                            .fullScreenCover(isPresented: $logoshowingCropper, content: {
                                ImageCropper(image: $newBrandLogo,
                                             cropShapeType: $logocropShapeType,
                                             presetFixedRatioType: $logopresetFixedRatioType,
                                             type: $logocropperType,
                                             cropMandatory: true)
                                    .ignoresSafeArea()
                            })
                            
                            //text
                            Text("Tell People How Your Brands Look’s Like")
                                .font(.body)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .padding(.horizontal,5)
                            Spacer()
                        }
                        .padding(.horizontal, UIScreen.screenWidth/20)
                    }
                    //Text Field Brand Name
                    TextField("Enter Brand Name", text: $loginData.brandName)
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
                                    Text("Brand Name")
                                        .font(.body)
                                        .background(Color.white)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/30, y: -UIScreen.screenHeight/90)
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        }
                        .focused($isKeyboardShowing)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()

                                Button("Done") {
                                    
                                    isKeyboardShowing = false
                                    globalVM.keyboardVisibility = false
                                }
                            }
                        }
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    //Text Field Brand Description
                    TextField("Enter Description", text: $loginData.brandDescription)
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
                                    Text("Description")
                                        .font(.body)
                                        .background(Color.white)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/30, y: -UIScreen.screenHeight/90)
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        }
                        .focused($isKeyboardShowing)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    //Text Field Service
                    TextField("Select Services in your brand woks", text: $loginData.brandServices)
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
                                    Text("Services in your brand woks")
                                        .font(.body)
                                        .background(Color.white)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/30, y: -UIScreen.screenHeight/90)
                                    Spacer()
                                }
                                Spacer()
                            }

                        }
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .onTapGesture {
                            loginData.showBrandServiceSheet = true
                        }
                    //Text Field Portfolio Link
//                    TextField("Enter Portfolio Link", text: $loginData.brandPortfolioLink)
//                        .padding()
//                        .cornerRadius(7)
//                        .overlay{
//                            // apply a rounded border
//                            RoundedRectangle(cornerRadius: 6)
//                                .stroke(.gray, lineWidth: 0.5)
//                            Text("Portfolio Link")
//                                .font(.system( size: 14))
//                                .foregroundColor(.black)
//                                .background(Color.white)
//                                .padding(.horizontal,5)
//                                .fontWeight(.ultraLight)
//                                .offset(x: -UIScreen.screenWidth/2.9, y: -27)
//
//                        }
//                        .padding(.vertical, UIScreen.screenHeight/50)
//                        .padding(.horizontal, UIScreen.screenWidth/30)
                    //Text Field Website Link
                    TextField("Website Link", text: $loginData.brandWebsiteLink)
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
                                        .background(Color.white)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/30, y: -UIScreen.screenHeight/90)
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        }
                        .focused($isKeyboardShowing)
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    Spacer()
                    //Button Next
                    
                    //Button Next
                    Button(action: {
                        if newBrandLogo == nil {
                            toastProfilePicture.toggle()
                        } else if loginData.brandName == "" {
                            toastbrandName.toggle()
                        } else if loginData.brandDescription == "" {
                            toastBrandDescription.toggle()
                        } else if globalVM.selectedVendorServicesList.count == 0 {
                            toastBrandServices.toggle()
                        } else {
                            
                            Task {
                                let res = await vendorPCS.updateVendorInfoDetails(userID: loginData.mainUserID, brandName: loginData.brandName, brandDescription: loginData.brandDescription, brandWebsiteLink: loginData.brandWebsiteLink, vendorImage: newBrandLogo, portfolio1img: vendorPortfolio1, portfolio2img: vendorPortfolio2, portfolio3img: vendorPortfolio3)
                                if res == "Success" {
                                    for i in 0..<globalVM.selectedVendorServicesList.count {
                                        let serviceName = globalVM.selectedVendorServicesList[i]
                                        Task{
                                            await vendorPCS.updateVendorService(loginData: loginData, serviceID: serviceName)
                                            
                                        }
                                    }
                                    userPCS.updateUserProfileCompletionStatus(loginData: loginData)
                                    navigateToMainFeed = true
                                } else {
                                    print("cant update")
                                }
                            }
                        }
                    }) {
                        Text("Next")
                            .foregroundColor(.black)
                            .font(.body)
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
                }
                BrandServiceBottomSheetView(loginData: loginData, globalVM: globalVM)
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .toast(isPresenting: $toastProfilePicture, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Brand Profile Picture not presnt", subTitle: ("Enter your brand pic to proceed"))
        }
        .toast(isPresenting: $toastbrandName, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Brand Name not present", subTitle: ("Enter your brand name to proceed"))
        }
        .toast(isPresenting: $toastBrandDescription, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Brand description is not present", subTitle: ("Enter your brand description to proceed"))
        }
        .toast(isPresenting: $toastBrandServices, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Brand Services are not present", subTitle: ("Select your brand service to proceed"))
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            Task {
                await vendorPCS.getServicesList(globalVM: globalVM)
            }
        }
    }
}

//struct VendorBasicInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorBasicInfoView()
//    }
//}
