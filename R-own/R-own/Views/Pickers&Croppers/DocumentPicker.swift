//
//  DocumentPicker.swift
//  R-own
//
//  Created by Aman Sharma on 18/07/23.
//

import SwiftUI

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var selectedURL: URL?

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: DocumentPicker

        init(_ parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let selectedURL = urls.first else { return }
            parent.selectedURL = selectedURL
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            // Handle document picker cancellation
        }
    }
}

//struct DocumentPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentPicker()
//    }
//}
