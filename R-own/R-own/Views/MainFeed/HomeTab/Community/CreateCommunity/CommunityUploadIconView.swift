//
//  CommunityUploadIconView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI
import Mantis
import AlertToast

struct CommunityUploadIconView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var navigateToCommunityChatView: Bool = false
    
    //Image Var
    @State private var showPicker: Bool = false
    @State private var croppedImage: UIImage?
    @State var imageNotSelected: Bool = false
    
    @State private var logoshowImagePicker = false
    @State private var logoshowingCropper = false
    @State private var logocropShapeType: Mantis.CropShapeType = .circle(maskOnly: true)
    @State private var logopresetFixedRatioType: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1/1)
    @State private var logocropperType: ImageCropperType = .normal
    
    @State var communityService = CommunityService()
    
    @State var alertCantPost: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    VStack{
                        //topnav
                        HStack{
                            //BackButton
                            
                            //Text
                            Spacer()
                            Text("Create Community")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.bold)
                                .frame(alignment: .leading)
                            Spacer()
                        }
                        .padding(.vertical, UIScreen.screenHeight/50)
                        .overlay{
                            HStack{
                                
                                Button(action: {
                                    dismiss()
                                }, label: {
                                    Circle()
                                        .strokeBorder(Color.black,lineWidth: 1)
                                        .background(Circle().foregroundColor(Color.white))
                                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                        .overlay{
                                            Image(systemName: "arrow.left")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                                .foregroundColor(.black)
                                        }
                                })
                                .padding(.leading, UIScreen.screenWidth/20)
                                Spacer()
                            }
                        }
                        
                        //headingnav
                        Text("Upload an Icon")
                            .foregroundColor(communityTextGreenColorUI)
                            .font(.body)
                            .fontWeight(.bold)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .frame(alignment: .leading)
                            .frame(width: UIScreen.screenWidth)
                            .background(communityBGBlueColorUI)
                            .border(width: 1, edges: [.bottom], color: greenUi)
                            .cornerRadius(3, corners: .bottomLeft)
                            .cornerRadius(3, corners: .bottomRight)
                        
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
                                                        logoshowImagePicker.toggle()
                                                    }
                                            }
                                    } else {
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
                                    }
                                }
                        }
                        .padding(.vertical,40)
                        ScrollView{
                            VStack{
                                if communityVM.selectedGroupMember.count > 0 {
                                    ForEach(0..<communityVM.selectedGroupMember.count, id: \.self){ count in
                                        VStack{
                                            CommunityUserSubTabView(communityVM: communityVM, user: communityVM.selectedGroupMember[count])
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, UIScreen.screenHeight/80)
                        }
                    }
                    VStack{
                        //button
                        HStack{
                            Spacer()
                            Button(action: {
                                if croppedImage == nil {
                                    imageNotSelected.toggle()
                                } else {
                                    Task{
//                                        communityService.ownDetailToMakeCommunity(loginData: loginData, communityVM: communityVM)
                                        
                                        let response = await communityService.createMesiboGroup(loginData: loginData, communityVM: communityVM, image: croppedImage)
                                        if response == "Success" {
                                            navigateToCommunityChatView.toggle()
                                        } else {
                                            alertCantPost.toggle()
                                        }
//                                        mesiboVM.mesiboGroupSet(UInt32(communityVM.communityJustMadeID))
//
                                    }
                                }
                                
                            }, label: {
                                Circle()
                                    .strokeBorder(Color.white,lineWidth: 1)
                                    .background(Circle().foregroundColor(Color.green))
                                    .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                    .overlay{
                                        Image(systemName: "arrow.right")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                            .foregroundColor(.white)
                                    }
                            })
                            .padding(.trailing, UIScreen.screenWidth/30)
                            .navigationDestination(isPresented: $navigateToCommunityChatView, destination: {
                                GroupMessageView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, groupID: String(communityVM.communityJustMadeID), communityName: communityVM.communityName, communityPic: "", globalVM: globalVM, profileVM: profileVM)
                            })
                        }
                    }
                    Spacer()
                }
                .sheet(isPresented: $logoshowImagePicker) {
                    ImagePickerView(image: $croppedImage)
                        .onAppear(perform: {
                            croppedImage = nil
                        })
                        .onDisappear(perform: {
                            if croppedImage != nil {
                                logoshowingCropper = true
                            }
                        })
                }
                .fullScreenCover(isPresented: $logoshowingCropper, content: {
                    ImageCropper(image: $croppedImage,
                                 cropShapeType: $logocropShapeType,
                                 presetFixedRatioType: $logopresetFixedRatioType,
                                 type: $logocropperType,
                                 cropMandatory: true)
                        .ignoresSafeArea()
                })
            }
        }
        .toast(isPresenting: $alertCantPost, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try again!", subTitle: ("Unable to post"))
        }
        .toast(isPresenting: $imageNotSelected, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Please select group icon")
        }
        .navigationBarBackButtonHidden()
    }
}

//struct CommunityUploadIconView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityUploadIconView()
//    }
//}
