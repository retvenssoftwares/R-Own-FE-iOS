//
//  SelectedImagePreview.swift
//  R-own
//
//  Created by Aman Sharma on 18/07/23.
//

import SwiftUI
import Mantis

struct SelectedMessageImagePreview: View {
    
    @Binding var image: UIImage?
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var loginData: LoginViewModel
    
    @Binding var showSelectedImagePreview: Bool
    @State var message: String = ""
    @FocusState private var isKeyboardShowing: Bool
    @State var isGroup: Bool
    @State var communityName: String
    @State var groupID: String
    
    
    @State private var showingCropper = false
    
    @State private var cropShapeType: Mantis.CropShapeType = .rect
    @State private var presetFixedRatioType: Mantis.PresetFixedRatioType = .canUseMultiplePresetFixedRatio()
    @State private var cropperType: ImageCropperType = .normal
    
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var communityService = CommunityService()
    
    var body: some View {
        VStack{
            
            HStack{
                
                //button
                Button(action: {
                    showSelectedImagePreview = false
                }, label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                        .foregroundColor(.black)
                })
                Spacer()
                
                //text
                Text("Image Preview")
                    .font(.body)
                    .fontWeight(.bold)
                
                Spacer()
                
                    //button
                    Button(action: {
                        showingCropper.toggle()
                    }, label: {
                        Image(systemName: "crop")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .foregroundColor(.black)
                    })
                
            }
            .padding(.horizontal, UIScreen.screenWidth/40)
            .padding(.vertical, UIScreen.screenHeight/70)
            .background(greenUi)
            .border(width: 1, edges: [.bottom], color: .black)
            
            VStack{
                Spacer()
                
                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.vertical, UIScreen.screenHeight/70)
                
                Spacer()
                
                HStack{
                    TextField("Send Message", text: $message)
                        .keyboardType(.default)
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
                    
                    Button(action: {
                        if image != nil {
                            mesiboVM.onSendImageMessage(img: image!, loginData: loginData, text: message)
                            if isGroup{
                                print("sending group notification")
                                communityService.sendGroupNotificationWithImage(loginData: loginData, title: communityName, body: message, groupID: groupID, senderUserID: loginData.mainUserID, messageImage: image)
                            }
                            showSelectedImagePreview = false
                        }
                    }, label: {
                        Circle()
                            .fill(greenUi)
                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                            .padding(.horizontal, UIScreen.screenWidth/40)
                            .overlay{
                                Image(systemName: "paperplane.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                    .foregroundColor(.black)
                            }
                    })
                }
                .padding()
                .foregroundColor(.black)
                .frame(width: UIScreen.screenWidth/1.1)
                .background(.white)
                .cornerRadius(15)
                .padding(.vertical, UIScreen.screenHeight/70)
            }
            .frame(width: UIScreen.screenWidth)
            .background(.black)
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .fullScreenCover(isPresented: $showingCropper, content: {
            ImageCropper(image: $image,
                         cropShapeType: $cropShapeType,
                         presetFixedRatioType: $presetFixedRatioType,
                         type: $cropperType,
                         cropMandatory: false)
            .ignoresSafeArea()
        })
    }
}

//struct SelectedImagePreview_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedImagePreview()
//    }
//}
