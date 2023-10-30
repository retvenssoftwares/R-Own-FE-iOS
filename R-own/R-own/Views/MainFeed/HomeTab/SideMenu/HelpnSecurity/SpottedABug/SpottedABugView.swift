//
//  SpottedABugView.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI
import Mantis
import AlertToast

struct SpottedABugView: View {
    
    @State var bugText: String = ""
    
    @State var image1: UIImage?
    @State var image2: UIImage?
    @State private var showingCropShapeList = false
    @State private var showImagePicker = false
    @State private var showCamera = false
    @State private var showingCropper = false
    @State private var cropShapeType: Mantis.CropShapeType = .rect
    @State private var presetFixedRatioType: Mantis.PresetFixedRatioType = .canUseMultiplePresetFixedRatio()
    @State private var cropperType: ImageCropperType = .normal
    
    
    @State var alertNoPic: Bool = false
    @State var alertCantPost: Bool = false
    @State var alertPosted: Bool = false
    @State var alertDescription: Bool = false
    
    @State var spottedabugservice = SpottedABugService()
    @StateObject var globalVM: GlobalViewModel
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        VStack{
            //Nav
            BasicNavbarView(navbarTitle: "Spotted A Bug?")
            
            TextEditor(text: $bugText)
                .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenWidth/4)
                .font(.body)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 2, y: 2)
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
                .overlay{
                    if bugText == ""{
                        VStack{
                            HStack{
                                Text("So you spotted a bug? Report it to us...!!")
                                    .foregroundColor(.black.opacity(0.5))
                                    .padding()
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.vertical, UIScreen.screenHeight/50)
            
            Button(action: {
                showCamera.toggle()
            }, label: {
                HStack{
                    Image(systemName: "paperclip")
                        .resizable()
                        .scaledToFit()
                        .frame(width:  UIScreen.screenWidth/50, height: UIScreen.screenHeight/50)
                        .foregroundColor(.white)
                    Text("Add Attachment")
                        .font(.body)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, UIScreen.screenWidth/50)
                .padding(.vertical, UIScreen.screenHeight/70)
                .background(greenUi)
                .cornerRadius(5)
            })
            .sheet(isPresented: $showCamera) {
                ImagePickerView(image: $image1)
                    .onAppear(perform: {
                        image1 = nil
                    })
                    .onDisappear(perform: {
                        if image1 != nil {
                            showingCropper = true
                        }
                    })
            }
            .fullScreenCover(isPresented: $showingCropper, content: {
                ImageCropper(image: $image1,
                             cropShapeType: $cropShapeType,
                             presetFixedRatioType: $presetFixedRatioType,
                             type: $cropperType,
                             cropMandatory: true)
                .ignoresSafeArea()
            })
            
            if image1 != nil {
                Image(uiImage: image1!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.screenHeight/4)
            } 
            
            Spacer()
            
            Text("The report will include some details about your device and account to provide us with further context for your report. We may contact you via email if you've confirmed your email address. Visit our Privacy Policy to find out what information we use and how.")
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .frame(width: UIScreen.screenWidth/1.3)
            
            Button(action: {
                Task{
                    if bugText == "" {
                        alertDescription.toggle()
                    } else if image1 == nil {
                        alertNoPic.toggle()
                    } else {
                        let res = await  spottedabugservice.postABug(img: image1, description: bugText)
                        if res == "Success" {
                            alertPosted.toggle()
                            bugText = ""
                            image1 = nil
                        } else {
                            alertNoPic.toggle()
                        }
                    }
                }
            }, label: {
                Text("SEND")
                    .font(.body)
                    .fontWeight(.bold)
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .padding(.vertical, UIScreen.screenHeight/90)
                    .foregroundColor(greenUi)
                    .background(jobsDarkBlue)
                    .cornerRadius(5)
                
            })
            Spacer()
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .toast(isPresenting: $alertNoPic, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "No image", subTitle: ("Select atleast one bugpic to post"))
        }
        .toast(isPresenting: $alertCantPost, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try again!", subTitle: ("Unable to post"))
        }
        .toast(isPresenting: $alertPosted, duration: 2, tapToDismiss: true){
            AlertToast( type: .complete(greenUi), title: "Bug Posted", subTitle: ("Thanks for makign R-own better."))
        }
        .toast(isPresenting: $alertDescription, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Description not found", subTitle: ("Add descroption of your bug"))
        }
        .navigationBarBackButtonHidden()
    }
}

//struct SpottedABugView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpottedABugView()
//    }
//}
