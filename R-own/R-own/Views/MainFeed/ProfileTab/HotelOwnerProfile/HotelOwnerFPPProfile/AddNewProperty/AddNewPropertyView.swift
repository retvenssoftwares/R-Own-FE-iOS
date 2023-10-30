//
//  AddNewPropertyView.swift
//  R-own
//
//  Created by Aman Sharma on 09/06/23.
//

import SwiftUI
import AlamofireImage
import Alamofire
import Mantis

struct AddNewPropertyView: View {
    
    
    @StateObject var loginData: LoginViewModel
    
    @StateObject var globalVM: GlobalViewModel

//    @State var hotelLogoURL: String
    
    @State var hotelBGCropped: UIImage?
    @State var hotelLogo = UIImage(named: "HotelBGIllustration")
    
    @State var hotelName1: String = ""
    @State var hotelDescription1: String = ""
    @State var hotelAddress1: String = ""
    @State var hotelRating1: String = ""
    @State var hotelCountry: String = ""
    @State var hotelState: String = ""
    @State var hotelCity: String = ""
    @State var hotelCountryCode: String = ""
    @State var hotelStateCode: String = ""
    @State var searchHotelCountry: String = ""
    @State var searchHotelState: String = ""
    @State var searchHotelCity: String = ""
    @State var hotelCoverpicURL1: String = ""
    @State var showLocation: Bool = false
    @State var showRating: Bool = false
    @State var showCountry: Bool = false
    @State var showState: Bool = false
    @State var showCity: Bool = false
    
    
    @State private var coverPicshowImagePicker = false
    @State private var coverPicshowingCropper = false
    @State private var coverPiccropShapeType: Mantis.CropShapeType = .rect
    @State private var coverPicpresetFixedRatioType: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 3/2)
    @State private var coverPiccropperType: ImageCropperType = .normal
    
    @FocusState private var isKeyboardShowing: Bool
    
    @StateObject var locationService = LocationService()
    
    @StateObject var addNewHotelService = HotelOwnerUserProfileCompletionService()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    BasicNavbarView(navbarTitle: "New Property Details")
                    ScrollView{
                        VStack{
                            //img Hotelimg
                            
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
                                Image("HotelBGIllustration")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenWidth/1.3)
                                    .padding(.vertical, UIScreen.screenHeight/30)
                                    .onTapGesture {
                                        coverPicshowImagePicker.toggle()
                                    }
                            }
                            
                            //Text Field Hotel Name
                            
                            TextField("Enter hotel name", text: $hotelName1)
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
                            
                            //Text Field Hotel Description
                            
                            TextField("Enter hotel description", text: $hotelDescription1)
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
                            
                            //Text Field Hotel Address
                            
                            AutoFetchLocationTab(autoLocation: $hotelAddress1, loginData: loginData, globalVM: globalVM, width: UIScreen.screenWidth/1.1)
                                                        
                            //Text Field Hotel Star Rating
                            
                            TextField("Select Hotel Star Rating", text: $hotelRating1)
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
                                                            
                                                            hotelRating1 = "1 Star"
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
                                                            
                                                            hotelRating1 = "2 Star"
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
                                                            
                                                            hotelRating1 = "3 Star"
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
                                                            
                                                            hotelRating1 = "4 Star"
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
                                                            
                                                            hotelRating1 = "5 Star"
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
                                                            
                                                            hotelRating1 = "6 Star"
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
                                                            
                                                            hotelRating1 = "7 Star"
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
                                    .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                                }
                                .onTapGesture {
                                    showRating.toggle()
                                }
                            
                            //save button (append in hotel list)
                            Button(action: {
                                
                                loginData.hotelChainList.append(Hotel(
                                    hotelOwnerID: loginData.mainUserID,
                                    hotelName: hotelName1,
                                    hotelAddress: hotelAddress1,
                                    hotelRating: hotelRating1,
                                    hotelLogoURL: loginData.hotelLogoURL,
                                    hotelDescription: hotelDescription1,
                                    hotelProfilepicURL: hotelLogo,
                                    hotelCoverpicURL: hotelBGCropped)
                                )
                                print(loginData.hotelChainList)
                                addNewHotelService.updateHotelInfoIndividually(loginData: loginData, hotelLogo: hotelLogo!, hotelBG: hotelBGCropped!, hotelName: hotelName1, hotelAddress: hotelAddress1, hotelRating: hotelRating1, hotelDescription: hotelDescription1)
                                dismiss()
                                
                            }) {
                                Text("Save")
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
                            .padding(.top, UIScreen.screenHeight/20)
                            .padding(.bottom, UIScreen.screenHeight/30)
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
                }
                MainLocationBottomSheetView(loginData: loginData, globalVM: globalVM, location: $hotelAddress1)
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
        .onAppear{
//            let url = URL(string: hotelLogoURL)
//                if let data = try? Data(contentsOf: url!)
//                {
//                    let hotelLogo: UIImage = UIImage(data: data)!
//                }
        }
    }
}

//struct AddNewPropertyView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewPropertyView()
//    }
//}
