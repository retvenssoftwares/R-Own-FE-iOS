//
//  DocumentIncomingMessageTab.swift
//  R-own
//
//  Created by Aman Sharma on 19/07/23.
//

import SwiftUI
import mesibo

struct DocumentIncomingMessageTab: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var messageStatus = "read"
    @State var message: MesiboMessage
    
    @State var navigatePdfPreview: Bool = false
    
    var body: some View {
        NavigationStack{
            NavigationLink(destination: {
                PDFPreviewTab(url: URL(string: message.getFile()?.url ?? "")!, loginData: loginData, mesiboVM: mesiboVM)
            }, label: {
                VStack(alignment: .leading){
                    
                    if message.getFile()?.url ?? "" != "" || message.getFile()?.url != nil {
                        HStack{
                            VStack(alignment: .leading, spacing: 0){
                                if message.isGroupMessage(){
                                    HStack{
                                        Text(message.profile?.getName() ?? "group member")
                                            .font(.footnote)
                                            .padding(.horizontal, UIScreen.screenWidth/30)
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                }
                                HStack{
                                    
                                    if message.getFile()?.url ?? "" != "" || message.getFile()?.url != nil{
                                        Image(systemName: "doc.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: UIScreen.screenHeight/13)
                                            .foregroundColor(lightGreyUi)
                                        VStack(alignment: .leading){
                                            Text(extractFileName(from: URL(string: (message.getFile()?.url!)!)!) ?? "")
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            Text(getDocumentSize(from: URL(string: message.getFile()?.url ?? "")!) )
                                                .font(.footnote)
                                                .fontWeight(.regular)
                                                .foregroundColor(.black)
                                        }
                                    }
                                    Spacer()
                                }
                                if message.message ?? "" != "" {
                                    HStack{
                                        Text(message.message ?? "")
                                            .font(.body)
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.black)
                                            .padding(.vertical, 10)
                                        Spacer()
                                    }
                                }
                                
                                HStack{
                                    Spacer()
                                    Text(convertTo12HourClock(message.getTimestamp().getTime(true))!)
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                }
                                .padding(.horizontal, UIScreen.screenWidth/40)
                            }
                            .padding()
                            .frame(width: UIScreen.screenWidth/2.2)
                            .background(.white)
                            .cornerRadius(10, corners: .bottomRight)
                            .cornerRadius(10, corners: .topLeft)
                            .cornerRadius(10, corners: .topRight)
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 3, y: 4)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            
                            Spacer(minLength: UIScreen.screenWidth/3)
                        }
                    }
                }
            })
        }
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
            return "Unknown"
        }
        return "Unknown"
    }
    
    func extractFileName(from url: URL) -> String? {
        return url.lastPathComponent
    }
}

//struct DocumentIncomingMessageTab_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentIncomingMessageTab()
//    }
//}
