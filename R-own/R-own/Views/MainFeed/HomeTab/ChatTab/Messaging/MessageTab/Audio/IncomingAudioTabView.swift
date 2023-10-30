//
//  IncomingAudioTabView.swift
//  R-own
//
//  Created by Aman Sharma on 30/06/23.
//

import SwiftUI
import AVFoundation
import mesibo


struct IncomingAudioTabView: View {
    
    let audioURL: URL?
    @State var audioName: String
    @State var message: MesiboMessage
    @StateObject private var audioPlayerManager = AudioPlayerManager()
    @State private var isPlaying: Bool = false
    
    private var progress: Double {
        return audioPlayerManager.currentTime / audioPlayerManager.duration
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                if message.isGroupMessage(){
                    HStack{
                        Text(message.profile?.getName() ?? "group member")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundColor(.black)
                        Spacer()
                    }
                }
                HStack{
                    Button(action: {
                        if isPlaying {
                            audioPlayerManager.stopAudio()
                        } else {
                            if let audioURL = audioURL {
                                audioPlayerManager.playAudio(from: audioURL)
                            }
                        }
                        isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .padding()
                            .foregroundColor(.white)
                            .background(greenUi)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                    VStack(alignment: .leading){
                        Text(audioName)
                            .font(.body)
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                        Slider(value: Binding(get: { self.audioPlayerManager.currentTime }, set: { _ in }), in: 0...audioPlayerManager.duration, onEditingChanged: sliderEditingChanged)
                            .accentColor(.green)
                            .padding(.horizontal, 20)
                        
                        HStack {
                            Text("\(formattedTime(time: audioPlayerManager.currentTime))")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Text("\(formattedTime(time: audioPlayerManager.duration))")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 20)
                    }
                }
                HStack{
                    Text(message.message ?? "")
                        .font(.body)
                        .foregroundColor(.black)
                    Spacer()
                }
                HStack{
                    Spacer()
                    Text(convertTo12HourClock(message.getTimestamp().getTime(true))!)
                        .font(.footnote)
                        .foregroundColor(.black)
                }
            }
            .padding()
            .frame(width: UIScreen.screenWidth/1.7)
            .background(.white)
            .cornerRadius(15, corners: [.bottomRight])
            .cornerRadius(15, corners: [.topLeft])
            .cornerRadius(15, corners: [.topRight])
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            Spacer()
        }
    }
    
    private func sliderEditingChanged(editingStarted: Bool) {
        if editingStarted {
            audioPlayerManager.audioPlayer?.pause()
        } else {
            audioPlayerManager.audioPlayer?.currentTime = audioPlayerManager.currentTime
            audioPlayerManager.audioPlayer?.play()
        }
    }
    
    private func formattedTime(time: TimeInterval) -> String {
        let minutes = Int(time / 60)
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


//struct IncomingAudioTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncomingAudioTabView()
//    }
//}
