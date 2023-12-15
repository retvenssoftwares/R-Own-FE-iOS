//
//  MessageViewThirdHalf.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import SwiftUI
import Mantis

import MobileCoreServices
import AVKit

struct MessageViewThirdHalf: View {
    
    //Keyboard
    
    @FocusState private var isKeyboardShowing: Bool
    @State var message: String = ""
    @State private var keyboardHeight: CGFloat = 0
    
    
    @Binding var image: UIImage?
    @Binding var showSelectedImagePreview: Bool
    @State private var showingCropShapeList = false
    
    @State private var showImagePicker = false
    @State private var showCamera = false
    
    @State private var isShowingVideoPicker = false
    @Binding var selectedVideoURL: URL?
    @Binding var showSelectedVideoPreview: Bool
    
    @State private var isEmojiKeyboardVisible = false
    @State var chatAttachmentTapped = false
    
    @State private var showDocumentPicker = false
    @Binding var selectedDocumentURL: URL?
    @Binding var showSelectedDocumentPreview: Bool
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    // MARK: User Var
    
    //MesiboVar
    @StateObject var mesiboVM : MesiboViewModel
    @StateObject var notificationService = NotificationService()
    
    @State var decodedData: [String: String] = ["": ""]
    
    @Binding var keyboardVisibility: Bool
    
    @StateObject var globalVM: GlobalViewModel
    
    @State var isGroup: Bool
    @State var communityName: String
    @State var groupID: String
    
    @StateObject var communityService = CommunityService()
    
    var body: some View {
        VStack{
            HStack{
//                Button(action: {
//                    isKeyboardShowing = true
//
//                    isEmojiKeyboardVisible.toggle()
//                }, label: {
//                    Image("ChatEmoji")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
//                        .padding(.vertical, UIScreen.screenHeight/100)
//                        .padding(.horizontal, UIScreen.screenWidth/50)
//                })
                
//                EmojiTextField(text: $message, placeholder: "Type your message...", isEmoji: $isEmojiKeyboardVisible)
//                    .focused($isKeyboardShowing)
//                    .frame(height: UIScreen.screenHeight/40)
//                    .toolbar {
//                        ToolbarItemGroup(placement: .keyboard) {
//                            Spacer()
//                            Button("Done") {
//                            isKeyboardShowing = false
//                            globalVM.keyboardVisibility = false
//                            }
//                        }
//                    }
                
                
                TextEditor(text: $message)
                    .lineLimit(5)
                    .focused($isKeyboardShowing)
                    .frame(width: UIScreen.screenWidth/1.4, height: UIScreen.screenHeight/40)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button(action: {
                                isKeyboardShowing = false
                            }, label: {
                                Text("Done")
                                    .font(.footnote)
                                    .foregroundColor(.black)
                            })
                        }
                    }
                    .onChange(of: message) { newValue in
                        mesiboVM.Mesibo_onSendPresence()
//                        mesiboVM.mProfile.sendTyping()
                    }
                Spacer()
                if message != "" {
                    Button(action: {
                        mesiboVM.onSendMessage( messageText: message, loginData: loginData)
                        decodedData = decodeData(encodedData: mesiboVM.mProfile.getStatus() ?? "")
                        
                        let senderUser = decodedData["userID"] ?? ""
                        print(senderUser)
                        
                        if isGroup{
                            print("sending group notification")
                            communityService.sendGroupNotificationWithoutImage(loginData: loginData, title: communityName, body: message, groupID: groupID, senderUserID: loginData.mainUserID)
                        } else {
                            
                            notificationService.sendMessageNotification(loginData: loginData, userID: senderUser, header: loginData.mainUserFullName, body: message)
                        }
                        message = ""
                    }, label: {
                        Image(systemName: "paperplane.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                            .padding(.vertical, UIScreen.screenHeight/90)
                            .padding(.leading, UIScreen.screenWidth/80)
                            .foregroundColor(.black)
                    })
                } else {
                    HStack{
                        Button(action: {
                            withAnimation(.spring()){
                                chatAttachmentTapped.toggle()
                                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                            }
                        }, label: {
                            Image("ChatAttachment")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                .padding(5)
                                .padding(.vertical, UIScreen.screenHeight/90)
                        })
                        Button(action: {
                            showCamera.toggle()
                        }, label: {
                            Image("ChatCamera")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                .padding(5)
                                .padding(.vertical, UIScreen.screenHeight/90)
                        })
                    }
                }
            }
            .frame(width: UIScreen.screenWidth/1.1)
            .background(.white)
            .cornerRadius(5)
            .edgesIgnoringSafeArea(.bottom)
            .animation(.easeOut(duration: 0.16))
            .overlay{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: chatAttachmentTapped ? UIScreen.screenWidth/1.1 : 0)
                    .overlay{
                        if chatAttachmentTapped {
                            VStack{
                                Button(action: {
                                    showImagePicker.toggle()
                                    chatAttachmentTapped = false
                                }, label: {
                                    HStack{
                                        Image("ChatGallery")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/45, height: UIScreen.screenHeight/45)
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                        Text("Gallery")
                                            .font(.body)
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/60)
                                })
                                Divider()
                                    .frame(width: UIScreen.screenWidth/1.3)
                                Button(action: {
                                    
                                    isShowingVideoPicker = true
                                    chatAttachmentTapped = false
                                }, label: {
                                    HStack{
                                        Image("ChatVideo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/45, height: UIScreen.screenHeight/45)
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                        Text("Videos")
                                            .font(.body)
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/60)
                                })
                                Divider()
                                    .frame(width: UIScreen.screenWidth/1.3)
                                Button(action: {
                                    showDocumentPicker = true
                                    chatAttachmentTapped = false
                                }, label: {
                                    HStack{
                                        Image("ChatDocuments")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/45, height: UIScreen.screenHeight/45)
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                        Text("Documents")
                                            .font(.body)
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/60)
                                })
                            }
                            .background(.white)
                        }
                    }
                    .offset(y: chatAttachmentTapped ? -UIScreen.screenHeight/7 : 0)
            }
//            .overlay{
//                if message == "" {
//                    HStack{
//                        Text("Type your message...")
//                            .font(.body)
//                            .foregroundColor(lightGreyUi)
//                            .padding(.leading, UIScreen.screenWidth/20)
//                        Spacer()
//                    }
//                }
//            }
        }
        .sheet(isPresented: $isShowingVideoPicker) {
            VideoPicker(selectedVideoURL: $selectedVideoURL)
                .onAppear(perform: {
                    selectedVideoURL = nil
                })
                .onDisappear(perform: {
                    showSelectedVideoPreview = true
                })
        }
        .sheet(isPresented: $showCamera) {
            CameraView(image: $image)
                .onAppear(perform: {
                    image = nil
                })
                .onDisappear(perform: {
                    showSelectedImagePreview = true
                })
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(image: $image)
                .onAppear(perform: {
                    image = nil
                })
                .onDisappear(perform: {
                    showSelectedImagePreview = true
                })
        }
        .sheet(isPresented: $showDocumentPicker) {
            DocumentPicker(selectedURL: $selectedDocumentURL)
                .onAppear(perform: {
                    selectedDocumentURL = nil
                })
                .onDisappear(perform: {
                    showSelectedDocumentPreview = true
                })
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    keyboardHeight = keyboardFrame.height
                }
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
                keyboardHeight = 0
            }
        }
        .onChange(of: keyboardVisibility) { newValue in
            // Update the value of the second bool variable based on the change in the first bool variable
            print("value changing")
            
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
            isEmojiKeyboardVisible = false
        }
        
    }
    
    func decodeString(input: String, shift: Int) -> String {
        var decodedData = ""
        for char in input {
            let decodedChar: Character
            if char.isLetter {
                let base = char.isLowercase ? Character("a") : Character("A")
                let decodedAscii = (Int(char.asciiValue ?? 0) - Int(base.asciiValue ?? 0) - shift + 26) % 26
                decodedChar = Character(UnicodeScalar(decodedAscii + Int(base.asciiValue ?? 0))!)
            } else {
                decodedChar = char
            }
            decodedData.append(decodedChar)
        }
        return decodedData
    }
    
    func decodeData(encodedData: String) -> [String: String] {
        let decodedValues = encodedData.split(separator: "|")
        let keys = ["userID", "userRole"]
        var values = [String]()

        for (index, value) in decodedValues.enumerated() {
            let shift: Int
            switch index {
            case 0:
                shift = 5
            case 1:
                shift = 6
            default:
                shift = 0
            }
            let decodedValue = decodeString(input: String(value), shift: shift)
            values.append(decodedValue)
        }

        return Dictionary(uniqueKeysWithValues: zip(keys, values))
    }
}

//extension UIResponder {
//    @objc func toggleEmojiKeyboard() {
//        for window in UIApplication.shared.windows {
//            window.endEditing(true)
//            window.windowScene?.value(forKey: "delegate")?.value(forKey: "textDocumentProxy")?.perform(NSSelectorFromString("setKeyboardType:"), with: 0)
//            window.windowScene?.value(forKey: "delegate")?.value(forKey: "textDocumentProxy")?.perform(NSSelectorFromString("keyboardInputMode:"))?.perform(NSSelectorFromString("toggleEmojiKeyboard"))
//        }
//    }
//}
//struct MessageViewThirdHalf_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageViewThirdHalf()
//    }
//}
class UIEmojiTextField: UITextField {
    
    var isEmoji = false {
        didSet {
            setEmoji()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setEmoji() {
        self.reloadInputViews()
    }
    
    override var textInputContextIdentifier: String? {
        return ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" && self.isEmoji{
                self.keyboardType = .default
                return mode
                
            } else if !self.isEmoji {
                return mode
            }
        }
        return nil
    }
    
}

struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    @Binding var isEmoji: Bool
    
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        emojiTextField.isEmoji = self.isEmoji
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
        uiView.isEmoji = isEmoji
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
