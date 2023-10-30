//
//  EditFPPProfilePicView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI
import Mantis
import Shimmer

struct EditFPPProfilePicView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    
    @State private var logoshowImagePicker = false
    @State private var logoshowingCropper = false
    @State private var logocropShapeType: Mantis.CropShapeType = .circle(maskOnly: true)
    @State private var logopresetFixedRatioType: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1/1)
    @State private var logocropperType: ImageCropperType = .normal
    @Binding var newHotelLogo: UIImage?
    @State var currentLogoURL: String
    
    @State private var currentUrl: URL?
    
    var body: some View {
        VStack{
            Image("ProfilePicCircle")
                .overlay{
                    if let newHotelLogo{
                    Image(uiImage: newHotelLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 230, height: 230)
                        .clipShape(Circle())
                        .overlay{
                            Image("ProfilePicCamera")
                                .offset(x:80,y:80)
                                .onTapGesture {
                                    logoshowImagePicker.toggle()
                                }
                        }
                    } else {
                        if currentLogoURL == "" {
                            Image("ProfilePicUser")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 230, height: 230)
                                .clipShape(Circle())
                                .offset(y:8)
                                .overlay{
                                    Image("ProfilePicCamera")
                                        .offset(x:80,y:80)
                                        .onTapGesture {
                                            logoshowImagePicker.toggle()
                                        }
                                }
                        }else {
                            AsyncImage(url: currentUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Circle()
                                    .fill(lightGreyUi)
                                    .shimmering(active: true)
                            }
                            .frame(width: 230, height: 230)
                            .clipShape(Circle())
                            .overlay{
                                Image("ProfilePicCamera")
                                    .offset(x:80,y:80)
                                    .onTapGesture {
                                        logoshowImagePicker.toggle()
                                    }
                            }
                            .onAppear {
                                if currentUrl == nil {
                                    DispatchQueue.main.async {
                                        currentUrl = URL(string: currentLogoURL)!
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        .sheet(isPresented: $logoshowImagePicker) {
            ImagePickerView(image: $newHotelLogo)
                .onAppear(perform: {
                    newHotelLogo = nil
                })
                .onDisappear(perform: {
                    if newHotelLogo != nil {
                        logoshowingCropper = true
                    }
                })
        }
        .fullScreenCover(isPresented: $logoshowingCropper, content: {
            ImageCropper(image: $newHotelLogo,
                         cropShapeType: $logocropShapeType,
                         presetFixedRatioType: $logopresetFixedRatioType,
                         type: $logocropperType,
                         cropMandatory: true)
                .ignoresSafeArea()
        })
        .padding(.vertical,40)
    }
}

//struct EditFPPProfilePicView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditFPPProfilePicView()
//    }
//}
