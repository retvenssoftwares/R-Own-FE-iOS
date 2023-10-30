//
//  VideoPicker.swift
//  R-own
//
//  Created by Aman Sharma on 18/07/23.
//

import SwiftUI

import MobileCoreServices
import AVKit


struct VideoPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    @Binding var selectedVideoURL: URL?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var selectedVideoURL: URL?
        let parent: VideoPicker

        init(parent: VideoPicker, selectedVideoURL: Binding<URL?>) {
            self.parent = parent
            _selectedVideoURL = selectedVideoURL
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let videoURL = info[.mediaURL] as? URL {
                selectedVideoURL = videoURL
            }

            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, selectedVideoURL: $selectedVideoURL)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [kUTTypeMovie as String]
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

//struct VideoPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoPicker()
//    }
//}
