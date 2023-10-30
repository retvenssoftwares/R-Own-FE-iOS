//
//  ImagePicker3.swift
//  R-own
//
//  Created by Aman Sharma on 22/05/23.
//
//
//import PhotosUI
//import SwiftUI
//
//struct ImagePicker3: UIViewControllerRepresentable {
//    
//    @Binding public var image: UIImage?
//    
//    class Coordinator: NSObject, PHPickerViewControllerDelegate  {
//        
//        var parent: ImagePicker3
//        
//        init(parent: ImagePicker3) {
//            self.parent = parent
//        }
//        
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            picker.dismiss(animated: true)
//            
//            guard let provider = results.first?.itemProvider else { return }
//            if provider.canLoadObject(ofClass: UIImage.self) {
//                provider.loadObject(ofClass: UIImage.self) { image, _ in
//                    self.parent.image = image as? UIImage
//                }
//            }
//        }
//        
//    }
//    
//    func makeUIViewController(context: Context) -> PHPickerViewController {
//        var configuration = PHPickerConfiguration()
//        configuration.filter = .images
//        
//        let picker = PHPickerViewController(configuration: configuration)
//        picker.delegate = context.coordinator
//        return picker
//    }
//    
//    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
//        
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//}
