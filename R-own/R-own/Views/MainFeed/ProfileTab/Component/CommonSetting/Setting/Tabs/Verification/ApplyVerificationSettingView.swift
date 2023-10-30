//
//  ApplyVerificationSettingView.swift
//  R-own
//
//  Created by Aman Sharma on 25/07/23.
//

import SwiftUI
import Mantis
import AlertToast

struct ApplyVerificationSettingView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var openDocumentTypeBottomSheet: Bool = false
    @State var openuplaodTypeBottomSheet: Bool = false
    @State var selectedDocumentType: String = ""
    
    @State var image: UIImage?
    @State private var showingCropShapeList = false
    @State private var showImagePicker = false
    @State private var showCamera = false
    @State private var showingCropper = false
    @State private var cropShapeType: Mantis.CropShapeType = .rect
    @State private var presetFixedRatioType: Mantis.PresetFixedRatioType = .canUseMultiplePresetFixedRatio()
    @State private var cropperType: ImageCropperType = .normal
    
    @State var alertNoPic: Bool = false
    @State var alertCantPost: Bool = false
    @State var alertDocumentNotSelected: Bool = false
    
    @StateObject var verificationService = VerificationService()
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Spacer()
                    Text("Apply for")
                        .font(.body)
                        .fontWeight(.bold)
                    Image("RownLogoWithIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: UIScreen.screenHeight/30)
                    Text("Verification")
                        .font(.body)
                        .fontWeight(.bold)
                    Spacer()
                }
                Text("Verified accounts display a green checkmark next to their names, indicating that we have verified their authenticity as representatives of public figures, celebrities, or brands.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .fontWeight(.regular)
                
            }
            .padding(.vertical, UIScreen.screenHeight/60)
            
            Spacer()
            
            HStack{
                VStack(alignment: .leading){
                    Text("Confirm Authenticity")
                        .font(.body)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                    
                    Text("Add 1-2 documents to identify yourself or your business")
                        .font(.body)
                        .foregroundColor(.black)
                        .fontWeight(.regular)
                }
                Spacer()
            }
            .padding(.top, UIScreen.screenHeight/50)
            
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("Username")
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                        Text(loginData.mainUserUserName)
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.regular)
                        Divider()
                    }
                    Spacer()
                }
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Full Name")
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                        Text(loginData.mainUserFullName)
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.regular)
                        Divider()
                    }
                    Spacer()
                }
            }
            .padding(.vertical, UIScreen.screenHeight/60)
            
            HStack{
                VStack(alignment: .leading){
                    Button(action: {
                        openDocumentTypeBottomSheet.toggle()
                    }, label: {
                        HStack{
                            Text("Select your documents")
                                .font(.body)
                                .foregroundColor(.black)
                                .fontWeight(.regular)
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                .foregroundColor(.black)
                        }
                    })
                    .sheet(isPresented: $openDocumentTypeBottomSheet, content: {
                        VStack(alignment: .leading, spacing: UIScreen.screenHeight/80){
                            Text("Select the type of document you are going to use.")
                                .font(.body)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, UIScreen.screenHeight/60)
                            
                            VStack{
                                Button(action: {
                                    selectedDocumentType = "Driver’s License"
                                    openDocumentTypeBottomSheet.toggle()
                                }, label: {
                                    Text("Driver’s License")
                                        .font(.body)
                                        .foregroundColor(.black)
                                })
                                
                                Divider()
                                
                                Button(action: {
                                    selectedDocumentType = "Passport"
                                    openDocumentTypeBottomSheet.toggle()
                                }, label: {
                                    Text("Passport")
                                        .font(.body)
                                        .foregroundColor(.black)
                                })
                                
                                Divider()
                                
                                Button(action: {
                                    selectedDocumentType = "Aadhar Card"
                                    openDocumentTypeBottomSheet.toggle()
                                }, label: {
                                    Text("Aadhar Card")
                                        .font(.body)
                                        .foregroundColor(.black)
                                })
                                
                                Divider()
                                
                                Button(action: {
                                    selectedDocumentType = "Tax Filing"
                                    openDocumentTypeBottomSheet.toggle()
                                }, label: {
                                    Text("Tax Filing")
                                        .font(.body)
                                        .foregroundColor(.black)
                                })
                                
                                Divider()
                                
                                Button(action: {
                                    selectedDocumentType = "Recent Utility Bill"
                                    openDocumentTypeBottomSheet.toggle()
                                }, label: {
                                    Text("Recent Utility Bill")
                                        .font(.body)
                                        .foregroundColor(.black)
                                })
                            }
                            Spacer()
                        }
                    })
                    
                    if selectedDocumentType != "" {
                        Text(selectedDocumentType)
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.regular)
                    }
                }
                Spacer()
            }
            
            Button(action: {
                if selectedDocumentType == "" {
                    alertDocumentNotSelected.toggle()
                } else {
                    openuplaodTypeBottomSheet = true
                }
            }, label: {
                HStack{
                    Text("Upload")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, UIScreen.screenWidth/20)
                .padding(.vertical, UIScreen.screenHeight/70)
                .background(lightGreyUi)
                .cornerRadius(15)
            })
            .sheet(isPresented: $openuplaodTypeBottomSheet, content: {
                VStack( spacing: UIScreen.screenHeight/80){
                    Button(action: {
                        showCamera.toggle()
                        openuplaodTypeBottomSheet.toggle()
                    }, label: {
                        Text("Camera")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                    })
                    
                    Divider()
                    
                    Button(action: {
                        showImagePicker.toggle()
                        openuplaodTypeBottomSheet.toggle()
                    }, label: {
                        Text("Gallery")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                    })
                    Spacer()
                }
                .padding(.top, UIScreen.screenHeight/50)
            })
            .sheet(isPresented: $showCamera) {
                CameraView(image: $image)
                    .onAppear(perform: {
                    })
                    .onDisappear(perform: {
                        if image != nil {
                            showingCropper = true
                        }
                    })
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(image: $image)
                    .onAppear(perform: {
                    })
                    .onDisappear(perform: {
                        if image != nil {
                            showingCropper = true
                        }
                    })
            }
            .fullScreenCover(isPresented: $showingCropper, content: {
                ImageCropper(image: $image,
                             cropShapeType: $cropShapeType,
                             presetFixedRatioType: $presetFixedRatioType,
                             type: $cropperType,
                             cropMandatory: false)
                .onAppear{
                    if image == nil {
                        showingCropper.toggle()
                    }
                }
                .ignoresSafeArea()
            })
            
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.screenHeight/4)
                    .padding(.vertical, UIScreen.screenHeight/70)
            }
            
            
            Button(action: {
                Task{
                    if image == nil {
                        alertNoPic.toggle()
                    } else {
                        let response = await verificationService.uplaodVerificationDocuments(userID: loginData.mainUserID, location: loginData.mainUserLocation, documentType: selectedDocumentType, userName: loginData.mainUserUserName, fullName: loginData.mainUserFullName, document: image)
                        if response == "Success" {
                            globalVM.verificationStatusResponse = "applied"
                        } else {
                            alertCantPost.toggle()
                        }
                    }
                }
            }, label: {
                Text("Done")
                    .font(.body)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .padding(.horizontal, UIScreen.screenWidth/20)
                    .padding(.vertical, UIScreen.screenWidth/90)
                    .background(greenUi)
                    .cornerRadius(15)
            })
            .padding(.vertical, UIScreen.screenHeight/60)
            
            Spacer()
        }
        .padding(.horizontal, UIScreen.screenWidth/10)
        .toast(isPresenting: $alertNoPic, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "No document selected", subTitle: ("Select a document to get verified"))
        }
        .toast(isPresenting: $alertCantPost, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try again!", subTitle: ("Unable to post"))
        }
        .toast(isPresenting: $alertDocumentNotSelected, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Select type of document")
        }
    }
}

//struct ApplyVerificationSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ApplyVerificationSettingView()
//    }
//}
