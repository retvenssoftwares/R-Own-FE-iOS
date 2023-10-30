////
////  ImageTEstScree.swift
////  R-own
////
////  Created by Aman Sharma on 07/06/23.
////
//
//import SwiftUI
//import CropImageView
//
//struct ImagePickerAndCropper: View {
//    @Binding var inputImage: UIImage
//    @Binding var croppedImage: UIImage?
//    @State var cropSize: CGSize
//    @State var imageNameforCropper: String
//    @State var imageIconWidth: CGFloat
//    @State var imageIconHeight: CGFloat
//    
//    
//    //Inputs preview
////    @State var inputImage: UIImage = UIImage(named: "demo") ??  UIImage(systemName: "sun.haze.fill")!
////    @State var croppedImage: UIImage?
////    @Binding var cropHeightSize: CGSize = CGSize(width: 500, height: 625)
//    
//    @State var isPresented: Bool = false
//    @State var showCropView: Bool = false
//    
//    var body: some View {
//        VStack{
//            Button(action: {
//                isPresented = true
//            }, label: {
//                Image(imageNameforCropper)
//                    .frame(width: imageIconWidth, height: imageIconHeight)
//            })
//            .sheet(isPresented: $isPresented, content: {
//                SUImagePickerView(image: $inputImage, isPresented: $isPresented, showCropView: $showCropView)
//            })
//            .sheet(isPresented: $showCropView,onDismiss:finishedCrop ) {
//                CropImageView(inputImage: self.inputImage, resultImage: self.$croppedImage, cropSize: cropSize)
//            }
//            //image preview
////            if self.croppedImage != nil {
////                Image(uiImage: self.croppedImage!)
////                    .resizable()
////                    .scaledToFit()
////                    .padding()
////            } else {
////                Image(uiImage: inputImage)
////                    .resizable()
////                    .aspectRatio(contentMode: .fill)
////                    .frame(width: 300, height: 300)
////            }
//        }
//    }
//    
//    func finishedCrop() {
//        print("cropped")
//    }
//}
//
////struct ImageTEstScree_Previews: PreviewProvider {
////    static var previews: some View {
////        ImageTEstScree()
////    }
////}
