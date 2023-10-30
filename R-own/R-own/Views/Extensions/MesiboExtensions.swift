//
//  MesiboExtensions.swift
//  R-own
//
//  Created by Aman Sharma on 24/04/23.
//

import SwiftUI
import AVFoundation

extension AppDelegate {

    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .denied:
                print("Denied, request permission from settings line 288")
            //presentCameraSettings()
            case .restricted:
                print("Restricted, device owner must approve line 291")
            case .authorized:
                print("Authorized, proceed line 293")
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { success in
                    if success {
                        print("Permission granted, proceed line 297")
                    } else {
                        print("Permission denied")
                    }
            }
        }
    }

    func checkMicPermission() {
        switch AVAudioSession.sharedInstance().recordPermission {
            case AVAudioSession.RecordPermission.granted:
                print("mic Permission granted , line 305")
                break
            case AVAudioSession.RecordPermission.denied:
                print("mic Permission not granted , line 309")
                break
            case AVAudioSession.RecordPermission.undetermined:
                AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                    if granted {
                        print("mic Permission granted , line 312")

                    } else {
                        print("mic Permission denied , line 314")
                    }
                })
            default:
                break
        }
    }

}
