//
//  OutgoingVideoCallView.swift
//  R-own
//
//  Created by Aman Sharma on 24/04/23.
//

import SwiftUI

struct OutgoingVideoCallView: View {
    
    @StateObject var mesiboVM: MesiboViewModel
    
    @Binding var timeElapsed: TimeInterval
    @Binding var callStarted: Bool
    
    var body: some View {
        VStack{
            if mesiboVM.mCall != nil {
                if mesiboVM.mCall.isCallInProgress(){
                    if mesiboVM.mCall.isAnswered() {
                        if mesiboVM.mCall.isCallConnected()  {
                            InProgressAudioCallView(mesiboVM: mesiboVM, callStatus: "", timeElapsed: $timeElapsed)
                        }
                    } else {
                        ConnectionAudioCallView(mesiboVM: mesiboVM, callStatus: "Connecting")
                    }
                } else {
                    ConnectionAudioCallView(mesiboVM: mesiboVM, callStatus: "Initiating Call")
                }
                
            } else {
                CompletedAudioCallView(mesiboVM: mesiboVM, timeElapsed: timeElapsed, callStarted: $callStarted)
            }
        }
    }
}

//struct OutgoingVideoCallView_Previews: PreviewProvider {
//    static var previews: some View {
//        OutgoingVideoCallView()
//    }
//}
