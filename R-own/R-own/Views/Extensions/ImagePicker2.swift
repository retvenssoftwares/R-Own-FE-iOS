//
//  ImagePicker2.swift
//  R-own
//
//  Created by Aman Sharma on 20/05/23.
//

//import SwiftUI
//import PhotosUI
//
//@MainActor
//class ImagePicker2: ObservableObject {
//    
//    @Published var image: Image?
//    @Published var images: [Image] = []
//    
//    @Published var imageSelection: PhotosPickerItem? {
//        didSet {
//            if let imageSelection {
//                Task {
//                    try await loadTransferable(from: imageSelection)
//                }
//            }
//        }
//    }
//    
//    @Published var imageSelections: [PhotosPickerItem] = [] {
//        didSet {
//            Task {
//                if !imageSelections.isEmpty {
//                    try await loadTransferable(from: imageSelections)
//                    imageSelections = []
//                }
//            }
//        }
//    }
//    
//    func loadTransferable(from imageSelections: [PhotosPickerItem]) async throws {
//        do {
//            for imageSelection in imageSelections {
//                if let data = try await imageSelection.loadTransferable(type: Data.self) {
//                    if let uiImage = UIImage(data: data) {
//                        self.images.append(Image(uiImage: uiImage))
//                    }
//                }
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
////        print(Image.transferRepresentation)
//        do {
//            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
//                if let uiImage = UIImage(data: data) {
//                    self.image = Image(uiImage: uiImage)
//                }
//            }
//        } catch {
//            print(error.localizedDescription)
//            image = nil
//        }
//    }
//}
