//
//  OutgoingAudioTabView.swift
//  R-own
//
//  Created by Aman Sharma on 03/07/23.
//

import SwiftUI
import AVFoundation
import mesibo

class AudioPlayerManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var audioPlayer: AVAudioPlayer?
    @Published var currentTime: TimeInterval = 0.0
    @Published var duration: TimeInterval = 0.0
    
    func playAudio(from url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            duration = audioPlayer?.duration ?? 0.0
            audioPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func stopAudio() {
        audioPlayer?.stop()
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {
            print("Error stopping audio: \(error.localizedDescription)")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopAudio()
    }
}

struct OutgoingAudioTabView: View {
    
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
            Spacer()
            VStack(alignment: .leading){
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
                    
                    if message.status == 3{
                        Image("MessageSeenTick")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.screenHeight/90)
                    } else if message.status == 2{
                        Image("MessageDoubleTick")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.screenHeight/90)
                    } else if message.status == 1{
                        Image("MessageSingleTick")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.screenHeight/90)
                    } else {
                        Image("MessageNotSentTick")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.screenHeight/90)
                    }
                }
            }
            .padding()
            .frame(width: UIScreen.screenWidth/1.7)
            .background(.white)
            .cornerRadius(15, corners: [.bottomLeft])
            .cornerRadius(15, corners: [.topLeft])
            .cornerRadius(15, corners: [.topRight])
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
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

//struct OutgoingAudioTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        OutgoingAudioTabView()
//    }
//}
