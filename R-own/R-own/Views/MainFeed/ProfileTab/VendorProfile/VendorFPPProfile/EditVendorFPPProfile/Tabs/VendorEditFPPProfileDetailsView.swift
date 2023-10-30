//
//  VendorEditFPPProfileDetailsView.swift
//  R-own
//
//  Created by Aman Sharma on 19/06/23.
//

import SwiftUI
import Mantis

struct VendorEditFPPProfileDetailsView: View {
    
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    
    
    @State var portfolioImage1: UIImage = UIImage(named: "demo") ??  UIImage(named: "HotelBGIllustration")!
    @Binding var portfolioImage1Cropped: UIImage?
    @State var portfolioImage2: UIImage = UIImage(named: "demo") ??  UIImage(named: "HotelBGIllustration")!
    @Binding var portfolioImage2Cropped: UIImage?
    @State var portfolioImage3: UIImage = UIImage(named: "demo") ??  UIImage(named: "HotelBGIllustration")!
    @Binding var portfolioImage3Cropped: UIImage?
    
    @State private var cropShapeType: Mantis.CropShapeType = .rect
    @State private var presetFixedRatioType: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 3/4)
    @State private var cropperType: ImageCropperType = .normal
    @State private var shouldPresentCropper1 = false
    @State private var shouldPresentCamera1 = false
    
    @State private var shouldPresentCropper2 = false
    @State private var shouldPresentCamera2 = false
    
    @State private var shouldPresentCropper3 = false
    @State private var shouldPresentCamera3 = false
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State private var currentUrl1: URL?
    @State private var currentUrl2: URL?
    @State private var currentUrl3: URL?
    
    var body: some View {
            ZStack {
                VStack{
                    
                    //username
                    VStack{
                        ZStack{
                            Divider()
                                .background(greenUi)
                                .overlay{
                                    HStack{
                                        Text("Change your brand name")
                                            .font(.body)
                                            .fontWeight(.thin)
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                            .foregroundColor(greenUi)
                                            .background(.white)
                                            .offset(x: UIScreen.screenWidth/40)
                                        Spacer()
                                    }
                                }
                        }
                        TextField("Enter Brand Name", text: $globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorName)
                            .autocapitalization(.none)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .padding(.vertical, UIScreen.screenHeight/60)
                            .focused($isKeyboardShowing)
                            
                        
                    }
                    
                    //edit bio
                    VStack{
                        Divider()
                            .background(greenUi)
                            .overlay{
                                HStack{
                                    Text("Edit your brand description")
                                        .font(.body)
                                        .fontWeight(.thin)
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                        .foregroundColor(greenUi)
                                        .background(.white)
                                        .offset(x: UIScreen.screenWidth/40)
                                    Spacer()
                                }
                            }
                        
                        TextEditor(text: $globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorDescription)
                            .frame(height: UIScreen.screenHeight/8)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                    }
                    
                    
                    
                    
                    //website
                    VStack{
                        ZStack{
                            Divider()
                                .background(greenUi)
                                .overlay{
                                    HStack{
                                        Text("Change your Website Link")
                                            .font(.body)
                                            .fontWeight(.thin)
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                            .foregroundColor(greenUi)
                                            .background(.white)
                                            .offset(x: -UIScreen.screenWidth/3)
                                            .offset(x: UIScreen.screenWidth/40)
                                        Spacer()
                                    }
                                }
                        }
                        TextField("Enter Website Link", text: $globalVM.getVendorProfileHeader.roleDetails.vendorInfo.websiteLink)
                            .autocapitalization(.none)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .padding(.vertical, UIScreen.screenHeight/60)
                            .focused($isKeyboardShowing)
//
                    }
                    
                    VStack{
                        ZStack{
                            Divider()
                                .background(greenUi)
                                .overlay{
                                    HStack{
                                        Text("Your Brand Portfolio")
                                            .font(.body)
                                            .fontWeight(.thin)
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                            .foregroundColor(greenUi)
                                            .background(.white)
                                            .offset(x: -UIScreen.screenWidth/3)
                                            .offset(x: UIScreen.screenWidth/40)
                                        Spacer()
                                    }
                                }
                        }
                        
                        HStack(spacing: UIScreen.screenWidth/40){
                            if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink.count > 0 {
                                if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image1 != "" {
                                    
                                    AsyncImage(url: currentUrl1) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/5)
                                            .clipped()
                                            .padding(.vertical, UIScreen.screenHeight/30)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Button(action: {
                                                            globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image1 = ""
                                                        }, label: {
                                                            Image(systemName: "xmark.circle")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .foregroundColor(Color.red)
                                                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/70)
                                                        })
                                                        .offset(x: UIScreen.screenWidth/50, y: UIScreen.screenHeight/13)
                                                        Spacer()
                                                    }
                                                    Spacer()
                                                }
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
                                        if currentUrl1 == nil {
                                            DispatchQueue.main.async {
                                                currentUrl1 = URL(string: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image1.replacingOccurrences(of: " ", with: "%20"))
                                            }
                                        }
                                    }
                                } else {
                                    if self.portfolioImage1Cropped != nil {
                                        Image(uiImage: self.portfolioImage1Cropped!)
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
                                
                                if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image2 != "" {
                                    
                                    AsyncImage(url: currentUrl2) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                            .clipped()
                                            .padding(.vertical, UIScreen.screenHeight/30)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Button(action: {
                                                            globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image2 = ""
                                                        }, label: {
                                                            Image(systemName: "xmark.circle")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .foregroundColor(Color.red)
                                                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/70)
                                                        })
                                                        .offset(x: UIScreen.screenWidth/50, y: UIScreen.screenHeight/13)
                                                        Spacer()
                                                    }
                                                    Spacer()
                                                }
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
                                                currentUrl2 = URL(string: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image2.replacingOccurrences(of: " ", with: "%20"))
                                            }
                                        }
                                    }
                                } else {
                                    if self.portfolioImage2Cropped != nil {
                                        Image(uiImage: self.portfolioImage2Cropped!)
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
                            
                                if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image3 != "" {
                                    
                                    AsyncImage(url: currentUrl3) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/6)
                                            .clipped()
                                            .padding(.vertical, UIScreen.screenHeight/30)
                                            .overlay{
                                                VStack{
                                                    HStack{
                                                        Button(action: {
                                                            globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image3 = ""
                                                        }, label: {
                                                            Image(systemName: "xmark.circle")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .foregroundColor(Color.red)
                                                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/70)
                                                        })
                                                        .offset(x: UIScreen.screenWidth/50, y: UIScreen.screenHeight/13)
                                                        Spacer()
                                                    }
                                                    Spacer()
                                                }
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
                                                currentUrl3 = URL(string: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image3.replacingOccurrences(of: " ", with: "%20"))
                                            }
                                        }
                                    }
                                } else {
                                    if self.portfolioImage3Cropped != nil {
                                        Image(uiImage: self.portfolioImage3Cropped!)
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
                                
                                if self.portfolioImage1Cropped != nil {
                                    Image(uiImage: self.portfolioImage1Cropped!)
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
                                
                                if self.portfolioImage2Cropped != nil {
                                    Image(uiImage: self.portfolioImage2Cropped!)
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
                                
                                if self.portfolioImage3Cropped != nil {
                                    Image(uiImage: self.portfolioImage3Cropped!)
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
                            ImagePickerView(image: $portfolioImage1Cropped)
                                .onAppear(perform: {
                                    portfolioImage1Cropped = nil
                                })
                                .onDisappear(perform: {
                                    if portfolioImage1Cropped != nil {
                                        shouldPresentCropper1 = true
                                    }
                                })
                        }
                        .fullScreenCover(isPresented: $shouldPresentCropper1, content: {
                            ImageCropper(image: $portfolioImage1Cropped,
                                         cropShapeType: $cropShapeType,
                                         presetFixedRatioType: $presetFixedRatioType,
                                         type: $cropperType,
                                         cropMandatory: true)
                            .ignoresSafeArea()
                            .onDisappear {
                            }
                        })
                        .sheet(isPresented: $shouldPresentCamera2) {
                            ImagePickerView(image: $portfolioImage2Cropped)
                                .onAppear(perform: {
                                    portfolioImage2Cropped = nil
                                })
                                .onDisappear(perform: {
                                    if portfolioImage2Cropped != nil {
                                        shouldPresentCropper2 = true
                                    }
                                })
                        }
                        .fullScreenCover(isPresented: $shouldPresentCropper2, content: {
                            ImageCropper(image: $portfolioImage2Cropped,
                                         cropShapeType: $cropShapeType,
                                         presetFixedRatioType: $presetFixedRatioType,
                                         type: $cropperType,
                                         cropMandatory: true)
                            .ignoresSafeArea()
                            .onDisappear {
                            }
                        })
                        .sheet(isPresented: $shouldPresentCamera3) {
                            ImagePickerView(image: $portfolioImage3Cropped)
                                .onAppear(perform: {
                                    portfolioImage3Cropped = nil
                                })
                                .onDisappear(perform: {
                                    if portfolioImage3Cropped != nil {
                                        shouldPresentCropper3 = true
                                    }
                                })
                        }
                        .fullScreenCover(isPresented: $shouldPresentCropper3, content: {
                            ImageCropper(image: $portfolioImage3Cropped,
                                         cropShapeType: $cropShapeType,
                                         presetFixedRatioType: $presetFixedRatioType,
                                         type: $cropperType,
                                         cropMandatory: true)
                            .ignoresSafeArea()
                            .onDisappear {
                            }
                        })
                    }
                }
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
    }
}

//struct VendorEditFPPProfileDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorEditFPPProfileDetailsView()
//    }
//}
