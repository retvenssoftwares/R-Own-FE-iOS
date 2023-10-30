//
//  CallScreenView.swift
//  R-own
//
//  Created by Aman Sharma on 20/07/23.
//

import SwiftUI

struct CallScreenView: View {
    
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var timeElapsed: TimeInterval = 0
    
    @State var callStarted: Bool = false
    
    var body: some View {
        VStack{
            if mesiboVM.mCall != nil {
                if mesiboVM.mCall.isVideoCall(){
                    VideoCallScreen(mesiboVM: mesiboVM, timeElapsed: $timeElapsed, callId: 0)
                } else {
                    AudioCallScreenView(mesiboVM: mesiboVM, timeElapsed: $timeElapsed, callStarted: $callStarted)
                }
            } else {
                CompletedAudioCallView(mesiboVM: mesiboVM, timeElapsed: timeElapsed, callStarted: $callStarted)
            }
        }
        .background(
            Image("DefaultChatBG")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        )
        .navigationBarBackButtonHidden()
    }
}

//struct CallScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        CallScreenView()
//    }
//}
