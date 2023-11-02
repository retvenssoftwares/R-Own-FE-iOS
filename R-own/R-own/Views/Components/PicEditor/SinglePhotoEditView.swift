//
//  SinglePhotoEditView.swift
//  R-own
//
//  Created by Aman Sharma on 22/05/23.
//
import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct SinglePhotoEditView: View {
    @StateObject var filterViewModel: FilterViewModel
    @State private var image = Image(systemName: "Example")
    @State private var filterIntensity = 0.5
    @State private var inputImage: UIImage?
    @State private var showImagePicker = false
    @State private var currentFilter = CIFilter.sepiaTone()
    
    // Lazy property to initialize CIContext
    private lazy var context: CIContext = {
        return CIContext()
    }()
    
    @Binding var photoTobeChanged: UIImage?
    
    @Environment(\.dismiss) private var dismiss
    
    // Change the accessibility level to 'internal'
    init(filterViewModel: FilterViewModel, photoTobeChanged: Binding<UIImage?>) {
        _filterViewModel = StateObject(wrappedValue: filterViewModel)
        _photoTobeChanged = photoTobeChanged
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenWidth/40, height: UIScreen.screenHeight/70)
                        .foregroundColor(.black)
                })
                Spacer()
                
                Button(action: {
                    save()
                    dismiss()
                }, label: {
                    Text("Save")
                })
            }
            .padding(.all)
            
            Spacer()
            
            filterViewModel.image
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            HStack {
                Text("Intensity")
                Slider(value: $filterViewModel.filterIntensity, in: 0.1...1.0)
                    .onChange(of: filterViewModel.filterIntensity) { _ in
                        filterViewModel.applyProcessing()
                    }
            }
            .padding(.all)
            
            ScrollView(.horizontal) {
                HStack {
                    Spacer()
                    ForEach(Filters.allCases, id: \.self) { filter in
                        Button(action: {
                            filterViewModel.setFilter(filter)
                        }, label: {
                            VStack {
                                Image(systemName: "camera.filters")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                    .foregroundColor(.black)
                                Text("\(filter.rawValue)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .foregroundColor(.black)
                            }
                        })
                    }
                    Spacer()
                }
            }
            .padding(.all)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
    
    private func save() {
        photoTobeChanged = filterViewModel.image.asUIImage()
    }
}


//struct SinglePhotoEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        SinglePhotoEditView()
//    }
//}
