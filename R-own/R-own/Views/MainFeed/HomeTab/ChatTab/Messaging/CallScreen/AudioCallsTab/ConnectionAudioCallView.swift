//
//  ConnectionAudioCallView.swift
//  R-own
//
//  Created by Aman Sharma on 20/07/23.
//

import SwiftUI

struct ConnectionAudioCallView: View {
    
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var callStatus: String
    
    @State var muteToggle: Bool = false
    @State var speakerToggle: Bool = false
    
    var body: some View {
        VStack{
            
            Spacer()
            
            VStack{
                ProfilePictureView(profilePic: mesiboVM.mProfile.getImageUrl() ?? "", verified: false, height: UIScreen.screenHeight/8, width: UIScreen.screenHeight/8)
                Text(callStatus)
                    .font(.body)
                    .fontWeight(.semibold)
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
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        )
    }
}

//struct ConnectionAudioCallView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConnectionAudioCallView()
//    }
//}
