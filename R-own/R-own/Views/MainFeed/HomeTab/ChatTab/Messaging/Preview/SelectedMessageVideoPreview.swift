//
//  SelectedMessageVideoPreview.swift
//  R-own
//
//  Created by Aman Sharma on 18/07/23.
//

import SwiftUI
import MobileCoreServices
import AVKit
import AVFoundation

struct SelectedMessageVideoPreview: View {
    let url: URL
    @State var isTrimming: Bool = true
    @State private var startTime: Double = 0
    @State private var endTime: Double = 0

    
    @Binding var showSelectedVideoPreview: Bool
    @State var message: String = ""
    @FocusState private var isKeyboardShowing: Bool
    @State var alertLargerVideoSize: Bool = false
    
    @StateObject var loginData: LoginViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var globalVM: GlobalViewModel
    
    
    private var player: AVPlayer {
        return AVPlayer(url: url)
    }
    
    var body: some View {
        VStack {
            
            HStack{
                //button
                Button(action: {
                   showSelectedVideoPreview  = false
                }, label: {
                    Image(systemName: "arrow.backward.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                        .foregroundColor(.black)
                })
                Spacer()
                //text
                Text("Video Preview")
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
                
                VideoPlayerView(videoURL: url)
                    .aspectRatio(contentMode: .fit)
                    .padding()
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
                    if (extractFloatNumber(from: getVideoSize()) ?? 31.00) < 30.00 {
                        mesiboVM.onSendVideoMessage(videoURL: url, loginData: loginData, text: message)
                        showSelectedVideoPreview.toggle()
                    } else {
                        alertLargerVideoSize.toggle()
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
    
    private func getVideoSize() -> String {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
            if let fileSize = attributes[FileAttributeKey.size] as? NSNumber {
                let sizeInBytes = fileSize.intValue
                let sizeInMB = Double(sizeInBytes) / (1024 * 1024)
                return String(format: "%.2f MB", sizeInMB)
            }
        } catch {
            print("Error getting video size: \(error)")
        }
        return "Unknown"
    }
    
    func extractFloatNumber(from string: String) -> Float? {
        let pattern = "[-+]?\\d*\\.?\\d+"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        let range = NSRange(string.startIndex..<string.endIndex, in: string)
        if let match = regex.firstMatch(in: string, options: [], range: range),
           let matchedRange = Range(match.range, in: string) {
            let matchedString = String(string[matchedRange])
            return Float(matchedString)
        }
        return nil
    }

}



//struct SelectedMessageVideoPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedMessageVideoPreview()
//    }
//}
