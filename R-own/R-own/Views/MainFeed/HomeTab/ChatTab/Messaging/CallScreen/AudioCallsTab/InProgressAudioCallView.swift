//
//  InProgressAudioCallView.swift
//  R-own
//
//  Created by Aman Sharma on 24/04/23.
//

import SwiftUI

struct InProgressAudioCallView: View {
    
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var callStatus: String
    
    @State var muteToggle: Bool = false
    @State var speakerToggle: Bool = false
    
    @Binding var timeElapsed: TimeInterval 
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack{
            
            Spacer()
            
            VStack{
                ProfilePictureView(profilePic: mesiboVM.mProfile.getImageUrl() ?? "", verified: false, height: UIScreen.screenHeight/8, width: UIScreen.screenHeight/8)
                
                
                Text(timeString(timeElapsed))
                    .font(.body)
                    .fontWeight(.semibold)
                if mesiboVM.mCall != nil {
                    if mesiboVM.mCall.isLinkUp() == false {
                        Text("Reconnecting")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                }
            }
            
            Spacer()
            
            HStack{
                
                Spacer()
                
                Button(action: {
                    mesiboVM.MesiboCall_OnSpeaker()
                    speakerToggle.toggle()
                    print(mesiboVM.mCall.getActiveAudioDevice())
                }, label: {
                    Image(speakerToggle ? "CallSpeaker" : "CallNoSpeakerIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/20,height: UIScreen.screenHeight/20)
                        .padding()
                })
                
                Spacer()
                
                Button(action: {
                    mesiboVM.MesiboCall_OnMute()
                    muteToggle.toggle()
                }, label: {
                    Image(muteToggle ? "CallMuteIcon" : "CallUnmuteIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/20,height: UIScreen.screenHeight/20)
                        .padding()
                })
                
                Spacer()
                
                Button(action: {
                    mesiboVM.MesiboCall_OnHangup()
                }, label: {
                    
                        Image("CallEnd")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/20,height: UIScreen.screenHeight/20)
                            .padding()
                })
                
                Spacer()
            }
            .padding()
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/8 )
            .background(jobsDarkBlue)
        }
        .background(
            Image("DefaultChatBG")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/1.2)
        )
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

//struct InProgressAudioCallView_Previews: PreviewProvider {
//    static var previews: some View {
//        InProgressAudioCallView()
//    }
//}
