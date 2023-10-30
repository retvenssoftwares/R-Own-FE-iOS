//
//  ProfilePictureEditCard.swift
//  R-own
//
//  Created by Aman Sharma on 23/05/23.
//

import SwiftUI

struct ProfilePictureEditCard: View {
    
    @StateObject var loginData: LoginViewModel
    
    
    @State var commmunityProfilePic: String
    
    //Image Var
    @State private var showPicker: Bool = false
    @State private var croppedImage: UIImage?
    
    @State private var currentUrl: URL?
    
    var body: some View {
        VStack{
            Image("ProfilePicCircle")
                .overlay{
                    if let croppedImage{
                    Image(uiImage: croppedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 230, height: 230)
                        .clipShape(Circle())
                        .overlay{
                            Image("ProfilePicCamera")
                                .offset(x:80,y:80)
                                .onTapGesture {
                                    showPicker.toggle()
                                }
                        }
                    } else {
                        
                        if commmunityProfilePic == "" {
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
                                            showPicker.toggle()
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
                            .offset(y:8)
                            .overlay{
                                Image("ProfilePicCamera")
                                    .offset(x:80,y:80)
                                    .onTapGesture {
                                        commmunityProfilePic = ""
                                        showPicker.toggle()
                                    }
                            }
                            .onAppear {
                                if currentUrl == nil {
                                    DispatchQueue.main.async {
                                        currentUrl = URL(string: commmunityProfilePic)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        .padding(.vertical,40)
//        .cropImagePicker(show: $showPicker, croppedImage: $croppedImage, userImage: $loginData.userImage)
    }
}

//struct ProfilePictureEditCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfilePictureEditCard()
//    }
//}
