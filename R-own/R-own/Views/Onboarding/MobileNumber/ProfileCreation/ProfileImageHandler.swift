//
//  ProfileImageHandler.swift
//  R-own
//
//  Created by Aman Sharma on 08/04/23.
//

import SwiftUI
import Mantis

struct ProfileImageHandler: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Image Var
    @Binding var profilePic: UIImage?
    
    @State private var logoshowImagePicker = false
    @State private var logoshowingCropper = false
    @State private var logocropShapeType: Mantis.CropShapeType = .circle(maskOnly: true)
    @State private var logopresetFixedRatioType: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1/1)
    @State private var logocropperType: ImageCropperType = .normal
    
    @State private var currentUrl: URL?
    
    var body: some View {
        VStack{
            Image("ProfilePicCircle")
                .overlay{
                    if let profilePic {
                        Image(uiImage: profilePic)
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
                        
                        if loginData.mainUserProfilePic == "" {
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
                                Color.purple.opacity(0.1)
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
                                        currentUrl = URL(string: loginData.mainUserProfilePic)
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        .sheet(isPresented: $logoshowImagePicker) {
            ImagePickerView(image: $profilePic)
                .onAppear(perform: {
                    profilePic = nil
                })
                .onDisappear(perform: {
                    if profilePic != nil {
                        logoshowingCropper = true
                    }
                })
        }
        .fullScreenCover(isPresented: $logoshowingCropper, content: {
            ImageCropper(image: $profilePic,
                         cropShapeType: $logocropShapeType,
                         presetFixedRatioType: $logopresetFixedRatioType,
                         type: $logocropperType,
                         cropMandatory: true)
                .ignoresSafeArea()
        })
        .padding(.vertical,40)
    }
}

//struct ProfileImageHandler_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileImageHandler()
//    }
//}
