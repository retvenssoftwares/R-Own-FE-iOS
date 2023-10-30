//
//  AudioCallScreenView.swift
//  R-own
//
//  Created by Aman Sharma on 20/07/23.
//

import SwiftUI

struct AudioCallScreenView: View {
    
    @StateObject var mesiboVM: MesiboViewModel
    
    @Binding var timeElapsed: TimeInterval
    
    @Binding var callStarted: Bool
    
    @State private var timer: Timer? = nil
    var body: some View {
        VStack{
            if mesiboVM.mCall != nil {
                if mesiboVM.mCall.isCallInProgress() {
                    OutgoingAudioCallView(mesiboVM: mesiboVM, timeElapsed: $timeElapsed, callStarted: $callStarted)
                }
            } else {
                Text("Call initalised")
            }
        }
        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
    }
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                timeElapsed += 1.0
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

//struct AudioCallScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        AudioCallScreenView()
//    }
//}
