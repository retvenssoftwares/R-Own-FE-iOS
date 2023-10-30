//
//  VideoPreviewTab.swift
//  R-own
//
//  Created by Aman Sharma on 30/06/23.
//
import AVKit
import SwiftUI

struct VideoPreviewTab: View {
    
    @State var videoURL: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            VStack{
                //Navbar
                HStack{
                    //button
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .foregroundColor(.white)
                    })
                    Spacer()
                }
                .padding(.horizontal, UIScreen.screenWidth/40)
                .padding(.vertical, UIScreen.screenHeight/70)
                Divider()
                    .frame(width: UIScreen.screenWidth)
            }
            Spacer()
            VideoPlayerView(videoURL: URL(string: videoURL)!)
                .frame(height: UIScreen.screenHeight/1.2)
            Spacer()
        }
        .background(.black)
        .navigationBarBackButtonHidden()
    }
}

struct VideoPlayerView: UIViewControllerRepresentable {
    let videoURL: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        // Automatically play the video
        player.play()
        
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // No need to update anything in this case
    }
}

//struct VideoPreviewTab_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoPreviewTab()
//    }
//}
