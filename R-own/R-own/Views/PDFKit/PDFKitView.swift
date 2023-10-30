//
//  PdfKitView.swift
//  R-own
//
//  Created by Aman Sharma on 19/07/23.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let fileURL: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: fileURL)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(url: fileURL)
    }
}

//struct PDFKitView_Previews: PreviewProvider {
//    static var previews: some View {
//        PdfKitView()
//    }
//}
