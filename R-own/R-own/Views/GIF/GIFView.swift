//
//  GIFView.swift
//  R-own
//
//  Created by Aman Sharma on 07/08/23.
//

import SwiftUI
import ImageIO

struct GIFView: UIViewRepresentable {
    let gifName: String
    
    func makeUIView(context: Context) -> UIImageView {
        let gifView = UIImageView()
        gifView.contentMode = .scaleAspectFit
        
        if let gifURL = Bundle.main.url(forResource: gifName, withExtension: "gif"),
           let gifData = try? Data(contentsOf: gifURL),
           let gifImage = UIImage.gifImage(data: gifData) {
            gifView.image = gifImage
        }
        
        return gifView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        // Update view if needed
    }
}

extension UIImage {
    class func gifImage(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Unable to create image source for data")
            return nil
        }
        
        var images: [UIImage] = []
        let count = CGImageSourceGetCount(source)
        
        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }
        }
        
        return UIImage.animatedImage(with: images, duration: totalDurationForGif(source))
    }
    
    class func totalDurationForGif(_ source: CGImageSource) -> TimeInterval {
        var totalDuration: TimeInterval = 0
        
        let count = CGImageSourceGetCount(source)
        
        for i in 0..<count {
            if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any],
               let gifProperties = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any],
               let frameDuration = gifProperties[kCGImagePropertyGIFUnclampedDelayTime as String] as? TimeInterval {
                totalDuration += frameDuration
            }
        }
        
        return totalDuration
    }
}
