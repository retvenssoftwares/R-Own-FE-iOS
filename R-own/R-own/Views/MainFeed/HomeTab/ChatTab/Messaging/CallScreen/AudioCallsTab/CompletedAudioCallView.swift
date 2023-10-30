//
//  CompletedAudioCallView.swift
//  R-own
//
//  Created by Aman Sharma on 20/07/23.
//

import SwiftUI

struct CompletedAudioCallView: View {
    
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var timeElapsed: TimeInterval 
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @Binding var callStarted: Bool
    
    var body: some View {
        VStack{
            
            Spacer()
            
            VStack{
                ProfilePictureView(profilePic: mesiboVM.mProfile.getImageUrl() ?? "", verified: false, height: UIScreen.screenHeight/8, width: UIScreen.screenHeight/8)
                
                if timeElapsed == 0 {
                    Text("Call Initialised")
                        .font(.body)
                        .fontWeight(.semibold)
                } else {
                    VStack{
                        Text("Call Completed")
                            .font(.body)
                            .fontWeight(.semibold)
                        
                        Text(timeString(timeElapsed))
                            .font(.footnote)
                            .fontWeight(.regular)
                    }
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            
            Spacer()
        }
        .background(
            Image("DefaultChatBG")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/1.2)
        )
    }
    
    func timeString(_ time: TimeInterval) -> String {
        if time >= 3600 { // If time is in hours or more
            let hours = Int(time) / 3600
            let minutes = (Int(time) % 3600) / 60
            let seconds = Int(time) % 60
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else if time >= 60 { // If time is in minutes
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        } else { // If time is in seconds
            let seconds = Int(time) % 60
            return String(format: "00:%02d", seconds)
        }
    }
}

//struct CompletedAudioCallView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompletedAudioCallView()
//    }
//}
