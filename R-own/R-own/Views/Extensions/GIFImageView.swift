//
//  GIFImageView.swift
//  R-own
//
//  Created by Aman Sharma on 19/04/23.
//

import SwiftUI
import WebKit

struct GIFImageView: UIViewRepresentable {
    private let name: String
    
    init(_ name: String){
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView =  WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
    
}

//struct GIFImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        GIFImageView()
//    }
//}
