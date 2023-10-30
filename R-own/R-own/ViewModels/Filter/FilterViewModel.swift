//
//  FilterViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 22/05/23.
//

import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI


@MainActor class FilterViewModel: ObservableObject {
    @Published var image = Image("Example")
    @Published var filterIntensity = 0.5
    @Published var inputImage: UIImage?
    @Published var showImagePicker = false
    @Published var currentFilter: CIFilter?
    @Published var currentImage: Int = 1
    
    let context = CIContext()
    
    public func loadImage() {
        guard let inputImage = inputImage else { return }
        guard var beginImage = CIImage(image: inputImage) else { return }
        
        let orientation = inputImage.imageOrientation
        
        switch orientation {
        case .up :
            beginImage = beginImage.oriented(.up)
        case .right:
            beginImage = beginImage.oriented(.right)
        case .left:
            beginImage = beginImage.oriented(.up)
        case .down:
            beginImage = beginImage.oriented(.up)
        case .upMirrored:
            beginImage = beginImage.oriented(.up)
        case .downMirrored:
            beginImage = beginImage.oriented(.up)
        case .leftMirrored:
            beginImage = beginImage.oriented(.up)
        case .rightMirrored:
            beginImage = beginImage.oriented(.up)
        @unknown default:
            beginImage = beginImage.oriented(.up)
        }
        
        
        guard let currentFilter = currentFilter else {
            if let cgimg = context.createCGImage(beginImage, from: beginImage.extent) {
                let uiImage = UIImage(cgImage: cgimg)
                
                image = Image(uiImage: uiImage)
            }
            return
        }
        
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        guard let outputImage: CIImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            
            image = Image(uiImage: uiImage)
        }
    }
    
    public func applyProcessing() {
        guard let currentFilter = currentFilter else { return }
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) && currentFilter.name == "CISepiaTone" {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) && inputKeys.contains(kCIInputIntensityKey) && currentFilter.name == "CIUnsharpMask" {
            currentFilter.setValue(filterIntensity * 5.0, forKey: kCIInputIntensityKey)
            currentFilter.setValue(filterIntensity * 2.0, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) && inputKeys.contains(kCIInputIntensityKey) && currentFilter.name == "CIGloom" {
            currentFilter.setValue(filterIntensity * 5.0, forKey: kCIInputIntensityKey)
            currentFilter.setValue(filterIntensity * 2.0, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputSaturationKey) && inputKeys.contains(kCIInputContrastKey) && inputKeys.contains(kCIInputBrightnessKey) && currentFilter.name == "CIColorControls"{
            currentFilter.setValue(filterIntensity * 0.5, forKey: ColorAdjustment.Saturation.rawValue)
            currentFilter.setValue(filterIntensity * 0.5, forKey: ColorAdjustment.Brightness.rawValue)
            currentFilter.setValue(filterIntensity * 1.5, forKey: ColorAdjustment.Contrast.rawValue)
        }
        
        if inputKeys.contains(kCIInputEVKey) && currentFilter.name == "CIExposureAdjust"{
            currentFilter.setValue(filterIntensity, forKey: kCIInputEVKey)
        }
        
        
        loadImage()
    }
    
    public func setFilter(_ filter: Filters) {
        
        switch filter {
        case .Sepia_Tone:
            currentFilter = CIFilter.sepiaTone()
        case .UnSharpMask:
            currentFilter = CIFilter.unsharpMask()
        case .CIColorControls:
            currentFilter = CIFilter.colorControls()
        case .Exposure:
            currentFilter = CIFilter.exposureAdjust()
        case .Gloom:
            currentFilter = CIFilter.gloom()
            applyProcessing()
        }
    }
}
