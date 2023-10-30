//
//  ImagePicker.swift
//  R-own
//
//  Created by Aman Sharma on 08/04/23.
//

//import SwiftUI
//import PhotosUI
//
//extension View{
//    @ViewBuilder
//    func cropImagePicker( show: Binding<Bool>, croppedImage: Binding<UIImage?>, userImage: Binding<UIImage?>)->some View{
//        ImagePicker( show: show, croppedImage: croppedImage, userImage: userImage){
//            self
//        }
//    }
//    
//    //for simpler usage
//    @ViewBuilder
//    func frame(_ size: CGSize)->some View{
//        self
//            .frame(width: size.width, height: size.height)
//    }
//    
//    //hapticfeedback
//    func haptics(_ style: UIImpactFeedbackGenerator.FeedbackStyle){
//        UIImpactFeedbackGenerator(style: style).impactOccurred()
//    }
//}
//
//
//fileprivate struct ImagePicker<Content : View>: View {
//    
//    var content : Content
//    @Binding var show: Bool
//    @Binding var croppedImage: UIImage?
//    
//    //Login Var
//    @Binding var userImage: UIImage?
//    
//    init( show: Binding<Bool>, croppedImage: Binding<UIImage?>, userImage: Binding<UIImage?>, @ViewBuilder content: @escaping ()-> Content){
//        self.content = content()
//        self._show = show
//        self._croppedImage = croppedImage
//        self._userImage = userImage
//    }
//    
//    @State private var photosItem: PhotosPickerItem?
//    @State private var selectedImage: UIImage?
//    @State private var showDialog: Bool = false
//    @State private var showCropView: Bool = false
//    
//    var body: some View {
//        content
//            .photosPicker(isPresented: $show, selection: $photosItem)
//            .onChange(of: photosItem){ newValue in
//                if let newValue{
//                    Task{
//                        if let imageData = try? await newValue.loadTransferable(type: Data.self), let image = UIImage(data: imageData){
//                            await MainActor.run(body: {
//                                selectedImage = image
//                                showCropView.toggle()
//                                showDialog.toggle()
//                            })
//                        }
//                    }
//                }
//            }
//            .fullScreenCover(isPresented: $showCropView){
//                selectedImage = selectedImage
//            } content: {
//                CropView(crop: .circle, image: selectedImage){ croppedImage, status in
//                    if let croppedImage{
//                        self.userImage = croppedImage
//                        self.croppedImage = croppedImage
//                        let uiImage: UIImage = croppedImage
//                        let imgData = uiImage.jpegData(compressionQuality: 0.5)!
//                        print(imgData)
//                    }
//                }
//            }
//    }
//}
//
//
//
////struct ImagePicker_Previews: PreviewProvider {
////    static var previews: some View {
////        ImagePicker()
////    }
////}
