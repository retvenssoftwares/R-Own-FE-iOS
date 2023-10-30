//
//  InProgressVideoCallView.swift
//  R-own
//
//  Created by Aman Sharma on 24/04/23.
//
import SwiftUI
import AVFoundation
import mesibo
import MesiboCall

struct VideoCallView: UIViewRepresentable {
    @Binding var isFrontCamera: Bool
    var callId: UInt32
    
    func makeUIView(context: Context) -> UIView {
        let cameraView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
//        MesiboCall.getInstance().setCallView(callId, videoView: cameraView)
        
        return cameraView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

struct VideoCallScreen: View {
    @StateObject var mesiboVM: MesiboViewModel
    @State private var isFrontCamera = true
    @State private var isCallConnected = false
    
    @State var displayBottomNavWhileCall: Bool = true
    
    @State var rectangleOffset = CGSize(width: -UIScreen.screenWidth/3, height: UIScreen.screenHeight/3)
    @State var originalOffset = CGSize(width: -UIScreen.screenWidth/3, height: UIScreen.screenHeight/3)
    
    @Binding var timeElapsed: TimeInterval
    @State private var timer: Timer? = nil
    
    let callId: UInt32
    
    var body: some View {
        
        VStack {
            if mesiboVM.callEnded {
                Text("call ended")
            } else if mesiboVM.callConnected || mesiboVM.callAnswered {
                VStack{
                    MesiboVideoWrapper(mesiboVM: mesiboVM)
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                        .onTapGesture {
                            displayBottomNavWhileCall.toggle()
                        }
                        .overlay{
                            
                            Text(timeString(timeElapsed))
                                .font(.body)
                                .fontWeight(.semibold)
                                .offset(y: -UIScreen.screenHeight/4)
                            
                            MesiboVideoWrapper1(mesiboVM: mesiboVM)
                                .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/5)
                                .offset(rectangleOffset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            let proposedOffset = originalOffset + gesture.translation
                                            let boundedOffset = restrictOffset(proposedOffset)
                                            rectangleOffset = boundedOffset
                                        }
                                        .onEnded { gesture in
                                            let proposedOffset = originalOffset + gesture.translation
                                            let boundedOffset = restrictOffset(proposedOffset)
                                            
                                            if boundedOffset == proposedOffset {
                                                originalOffset = boundedOffset
                                            } else {
                                                originalOffset = .zero
                                                animateBackToOriginalPosition()
                                            }
                                        }
                                )
                                .onTapGesture {
                                    mesiboVM.MesiboCall_OnVideoSwap()
                                }
                            if displayBottomNavWhileCall {
                                VStack{
                                    HStack{
                                        Button(action: {
                                            mesiboVM.MesiboCall_OnVideoSwitch()
                                        }, label: {
                                            Image("CallCameraSwitch")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/20,height: UIScreen.screenHeight/20)
                                                .padding()
                                        })
                                        //                                    Button(action: {
                                        //
                                        //                                    }, label: {
                                        //                                        Image("CallSpeaker")
                                        //                                            .resizable()
                                        //                                            .scaledToFit()
                                        //                                            .frame(width: UIScreen.screenHeight/20,height: UIScreen.screenHeight/20)
                                        //                                            .padding()
                                        //                                    })
                                        Button(action: {
                                            mesiboVM.MesiboCall_OnStopVideo()
                                        }, label: {
                                            Image(mesiboVM.videoToggle ? "CallStopVideoIcon" : "CallVideoIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/20,height: UIScreen.screenHeight/20)
                                                .padding()
                                        })
                                        Button(action: {
                                            mesiboVM.MesiboCall_OnMute()
                                        }, label: {
                                            Image(mesiboVM.muteToggle ? "CallMuteIcon" : "CallUnmuteIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/20,height: UIScreen.screenHeight/20)
                                                .padding()
                                        })
                                        Button(action: {
                                            mesiboVM.MesiboCall_OnHangup()
                                        }, label: {
                                            Image("CallEnd")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/20,height: UIScreen.screenHeight/20)
                                                .padding()
                                        })
                                        
                                    }
                                    Spacer()
                                }
                                .padding()
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/8 )
                                .background(jobsDarkBlue)
                                .offset(y: UIScreen.screenHeight/2.2)
                            }
                        }
                        .onDisappear {
                        }
                }
            } else if mesiboVM.callConnecting{
                MesiboVideoWrapper1(mesiboVM: mesiboVM)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                    .onTapGesture {
                        displayBottomNavWhileCall.toggle()
                    }
                    .overlay{
                        VStack {
                            
                            Spacer()
                                    
                            VStack{
                                
                                ProfilePictureView(profilePic: mesiboVM.mProfile.getImageUrl() ?? "", verified: false, height: UIScreen.screenHeight/8, width: UIScreen.screenHeight/8)
                                
                                if mesiboVM.mProfile.getName() ?? "" != "" {
                                    Text(mesiboVM.mProfile.getName() ?? "")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding()
                                }
                                
                                Text("Initiating Call")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                
                            }
                                    
                            Spacer()
                            if displayBottomNavWhileCall {
                                VStack{
                                    
                                    VStack{
                                        HStack{
                                            Button(action: {
                                                mesiboVM.MesiboCall_OnVideoSwitch()
                                            }, label: {
                                                Image("CallCameraSwitch")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/20,height: UIScreen.screenHeight/20)
                                                    .padding()
                                            })
                                            //                                    Button(action: {
                                            //
                                            //                                    }, label: {
                                            //                                        Image("CallSpeaker")
                                            //                                            .resizable()
                                            //                                            .scaledToFit()
                                            //                                            .frame(width: UIScreen.screenHeight/20,height: UIScreen.screenHeight/20)
                                            //                                            .padding()
                                            //                                    })
                                            Button(action: {
                                                mesiboVM.MesiboCall_OnStopVideo()
                                            }, label: {
                                                Image("CallVideoIcon")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/20,height: UIScreen.screenHeight/20)
                                                    .padding()
                                            })
                                            Button(action: {
                                                mesiboVM.MesiboCall_OnMute()
                                            }, label: {
                                                Image("CallMuteIcon")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/20,height: UIScreen.screenHeight/20)
                                                    .padding()
                                            })
                                            Button(action: {
                                                mesiboVM.MesiboCall_OnHangup()
                                            }, label: {
                                                Image("CallEnd")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/20,height: UIScreen.screenHeight/20)
                                                    .padding()
                                            })
                                            
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/8 )
                                    .background(jobsDarkBlue)
                                }
                            }
                        }
                    }
            }
        }
        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
        .navigationBarBackButtonHidden()
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
    
    private func restrictOffset(_ offset: CGSize) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let rectangleWidth: CGFloat = UIScreen.screenWidth/4
        let rectangleHeight: CGFloat = UIScreen.screenHeight/5
        
        let minX = -(screenWidth / 2) + (rectangleWidth / 2)
        let maxX = (screenWidth / 2) - (rectangleWidth / 2)
        let minY = -(screenHeight / 2) + (rectangleHeight / 2)
        let maxY = (screenHeight / 2) - (rectangleHeight / 2)
        
        let restrictedX = min(maxX, max(minX, offset.width))
        let restrictedY = min(maxY, max(minY, offset.height))
        
        return CGSize(width: restrictedX, height: restrictedY)
    }
    
    private func animateBackToOriginalPosition() {
        withAnimation(.spring()) {  
            rectangleOffset = originalOffset
        }
    }
}

struct MesiboVideoWrapper: View {
    @StateObject var mesiboVM: MesiboViewModel // Assuming you have an instance of MesiboVM
    
    var body: some View {
        if mesiboVM.mCall == nil {
            Text("Ended")
        } else {
            if let videoView = mesiboVM.mCall.getVideoView(true) {
                // Wrap the non-nil video view in a UIViewRepresentable
                UIViewRepresentableWrapper(view: videoView)
            } else {
                MesiboVideoWrapper1(mesiboVM: mesiboVM)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                    .overlay{
                        VStack {
                            
                            Spacer()
                                    
                            VStack{
                                
                                ProfilePictureView(profilePic: mesiboVM.mProfile.getImageUrl() ?? "", verified: false, height: UIScreen.screenHeight/8, width: UIScreen.screenHeight/8)
                                
                                if mesiboVM.mProfile.getName() ?? "" != "" {
                                    Text(mesiboVM.mProfile.getName() ?? "")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding()
                                }
                                
                                Text("Connecting")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                
                            }
                                    
                            Spacer()
                        }
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                        .background(.white)
                    }
            }
        }
    }
}

struct UIViewRepresentableWrapper: UIViewRepresentable {
    typealias UIViewType = UIView
    let view: UIView
    
    func makeUIView(context: Context) -> UIView {
        view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct MesiboVideoWrapper1: View {
    @StateObject var mesiboVM: MesiboViewModel // Assuming you have an instance of MesiboVM
    
    var body: some View {
        if mesiboVM.mCall == nil {
            Text("Ended")
        } else {
            if let videoView = mesiboVM.mCall.getVideoView(false) {
                // Wrap the non-nil video view in a UIViewRepresentable
                UIViewRepresentableWrapper1(view: videoView)
            } else {
                // Display connecting text message
                Text("Connecting...")
            }
        }
    }
}

struct UIViewRepresentableWrapper1: UIViewRepresentable {
    typealias UIViewType = UIView
    let view: UIView
    
    func makeUIView(context: Context) -> UIView {
        view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}


struct ConnectingCallView: View{
    
    @StateObject var mesiboVM: MesiboViewModel
    
    var body: some View {
        VStack{
            
        }
    }
}

struct SelfCameraView: UIViewRepresentable {
    @State var mesiboVM: MesiboViewModel
    @Binding var isFrontCamera: Bool
    
    func makeUIView(context: Context) -> UIView {
        let cameraView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: UIScreen.screenHeight/1.2))
        
        setupCameraView(cameraView)
        
        return cameraView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    private func setupCameraView(_ cameraView: UIView) {
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: isFrontCamera ? .front : .back) else {
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: AVCaptureSession())
            previewLayer.frame = cameraView.bounds
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.connection?.videoOrientation = .portrait
            
            cameraView.layer.addSublayer(previewLayer)
            
            let session = AVCaptureSession()
            session.addInput(input)
            session.startRunning()
            
            previewLayer.session = session
        } catch {
            print("Failed to set up camera: \(error.localizedDescription)")
        }
    }
}


struct InProgressVideoCallView: View {
    @State var mesiboVM: MesiboViewModel
    @Binding var isFrontCamera: Bool
    let callId: UInt32
    
    @State private var currentUrl: URL?
    
    var body: some View {
        VStack {
            VideoCallView(isFrontCamera: $isFrontCamera, callId: callId)
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/1.3)
                .overlay{
                    VStack{
                        AsyncImage(url: currentUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Color.purple.opacity(0.1)
                        }
                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                        .clipShape(Circle())
                        .padding(10)
                        .onAppear {
                            if currentUrl == nil {
                                DispatchQueue.main.async {
                                    currentUrl = URL(string: mesiboVM.mProfile.getImageUrl() ?? "")
                                }
                            }
                        }
                    }
                }
            HStack{
                
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight-UIScreen.screenHeight/1.3)
            .background(.white)
            
        }
    }
    
    private func toggleCamera() {
        isFrontCamera.toggle()
        print("switching camera")
        mesiboVM.mCall.switchCamera()
        print("switched camera")
//        MesiboCall.getInstance().switchCamera(callId, camera: isFrontCamera ? MesiboCall.CAMERA_FRONT : MesiboCall.CAMERA_BACK)
    }
}


//struct InProgressVideoCallView_Previews: PreviewProvider {
//    static var previews: some View {
//        InProgressVideoCallView()
//    }
//}
