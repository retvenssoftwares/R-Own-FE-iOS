//
//  PDFPreviewTab.swift
//  R-own
//
//  Created by Aman Sharma on 19/07/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct PDFPreviewTab: View {
    @State var url: URL
    
    
    @StateObject var loginData: LoginViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            
            HStack{
                //button
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                        .foregroundColor(.black)
                })
                Spacer()
                //text
                Text("Document Preview")
                    .font(.body)
                    .fontWeight(.bold)
                
                Spacer()
                
            }
            .padding(.horizontal, UIScreen.screenWidth/40)
            .padding(.vertical, UIScreen.screenHeight/70)
            .background(greenUi)
            .border(width: 1, edges: [.bottom], color: .black)

            Spacer()
            
            VStack{
                if getDocumentType(from: url) == "application/pdf" {
                    PDFKitView(fileURL: url)
                        .frame(height: UIScreen.screenHeight/1.3)
                } else {
                    Image(systemName: "doc.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: UIScreen.screenHeight/10)
                        .foregroundColor(lightGreyUi)
                    
                    if let fileName = extractFileName(from: url) {
                        Text("File Name: \(fileName)")
                            .font(.body)
                            .foregroundColor(.white)
                    } else {
                        Text("Unknown File Name")
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    
                }
                
            }
            .frame(maxHeight: UIScreen.screenHeight/1.4)
            
            Spacer()
            
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .background(.black)
        .navigationBarBackButtonHidden()
    }
    
    func getDocumentType(from url: URL) -> String? {
        guard let uti = UTType(filenameExtension: url.pathExtension) else {
            return nil
        }
        return uti.preferredMIMEType
    }
    func extractFileName(from url: URL) -> String? {
        return url.lastPathComponent
    }
}

//struct PDFPreviewTab_Previews: PreviewProvider {
//    static var previews: some View {
//        PDFPreviewTab()
//    }
//}
