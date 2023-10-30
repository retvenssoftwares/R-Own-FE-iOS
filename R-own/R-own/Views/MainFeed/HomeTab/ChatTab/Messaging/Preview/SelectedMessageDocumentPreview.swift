//
//  SelectedMessageDocumentPreview.swift
//  R-own
//
//  Created by Aman Sharma on 18/07/23.
//

import SwiftUI
import UniformTypeIdentifiers
import PDFKit

struct SelectedMessageDocumentPreview: View {
    let url: URL
    
    @Binding var showSelectedDocumentPreview: Bool
    @State var message: String = ""
    @FocusState private var isKeyboardShowing: Bool
    @State var alertLargerDocumentSize: Bool = false
    
    
    @StateObject var loginData: LoginViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var globalVM: GlobalViewModel
    
    
    var body: some View {
        VStack {
            
            HStack{
                //button
                Button(action: {
                   showSelectedDocumentPreview  = false
                }, label: {
                    Image(systemName: "arrow.backward.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
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
            .padding(.top, UIScreen.screenHeight/40)
            .padding(.bottom, UIScreen.screenHeight/70)
            .background(greenUi)
            .border(width: 1, edges: [.bottom], color: .black)

            Spacer()
            
            VStack{
                if getDocumentType(from: url) == "application/pdf" {
                    PDFKitView(fileURL: url)
                        .frame(height: UIScreen.screenHeight/1.4)
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
                    Text("File Size: \(getDocumentSize(from: url))")
                        .font(.footnote)
                        .foregroundColor(.white)
                    
                }
                
            }
            .frame(maxHeight: UIScreen.screenHeight/1.4)
            
            Spacer()
            
            HStack{
                TextField("Send Message", text: $message)
                    .keyboardType(.default)
                    .focused($isKeyboardShowing)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                            }
                        }
                    }
                
                Button(action: {
                    if (extractFloatNumber(from: getDocumentSize(from: url)) ?? 31.00) < 30.00 {
                        mesiboVM.onSendVideoMessage(videoURL: url, loginData: loginData, text: message)
                        showSelectedDocumentPreview.toggle()
                    } else {
                        print("error")
                        alertLargerDocumentSize.toggle()
                    }
                }, label: {
                    Circle()
                        .fill(greenUi)
                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        .overlay{
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                .foregroundColor(.black)
                        }
                })
            }
            .padding()
            .foregroundColor(.black)
            .frame(width: UIScreen.screenWidth/1.1)
            .background(.white)
            .cornerRadius(15)
            .padding(.vertical, UIScreen.screenHeight/70)
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .background(.black)
    }
    
    func getDocumentSize(from url: URL) -> String {
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: url.path)
            if let fileSize = fileAttributes[.size] as? Int64 {
                let byteCountFormatter = ByteCountFormatter()
                byteCountFormatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB]
                byteCountFormatter.countStyle = .file
                let fileSizeString = byteCountFormatter.string(fromByteCount: fileSize)
                print(fileSizeString)
                return fileSizeString
            }
        } catch {
            print("Error retrieving document size: \(error.localizedDescription)")
        }
        return "Unknown"
    }
    func extractFloatNumber(from string: String) -> Float? {
        let numberString = string.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined(separator: "")

        var extractedNumber: Float?
        
        if let floatNumber = Float(numberString) {
            if string.contains("MB") {
                extractedNumber = floatNumber
            } else if string.contains("Bytes") || string.contains("KB") {
                extractedNumber = 1.00
            } else if string.contains("GB") {
                extractedNumber = 31.00
            }
        }
        
        return extractedNumber
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

//struct SelectedMessageDocumentPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedMessageDocumentPreview()
//    }
//}

