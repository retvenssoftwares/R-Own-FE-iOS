//
//  ImagePicker4.swift
//  R-own
//
//  Created by Aman Sharma on 22/05/23.
//
//
//import SwiftUI
//import UIKit
//
//struct SUImagePickerView: UIViewControllerRepresentable {
//    
//    var sourceType: UIImagePickerController.SourceType = .photoLibrary
//    @Binding var image: UIImage
//    @Binding var isPresented: Bool
//    @Binding var showCropView: Bool
//    
//    func makeCoordinator() -> ImagePickerViewCoordinator {
//        return ImagePickerViewCoordinator(image: $image, isPresented: $isPresented, showCropView: $showCropView)
//    }
//    
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let pickerController = UIImagePickerController()
//        pickerController.sourceType = sourceType
//        pickerController.delegate = context.coordinator
//        return pickerController
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//        // Nothing to update here
//    }
//}
//
//class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//    
//    @Binding var image: UIImage
//    @Binding var isPresented: Bool
//    @Binding var showCropView: Bool
//    
//    init(image: Binding<UIImage>, isPresented: Binding<Bool>, showCropView: Binding<Bool>) {
//        self._image = image
//        self._isPresented = isPresented
//        self._showCropView = showCropView
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            self.image = image
//        }
//        self.isPresented = false
//        self.showCropView = true
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        self.isPresented = false
//        self.showCropView = true
//    }
//}
