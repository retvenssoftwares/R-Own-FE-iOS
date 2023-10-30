//
//  MessageDetailView.swift
//  R-own
//
//  Created by Aman Sharma on 03/07/23.
//

import SwiftUI
import mesibo

struct MessageDetailView: View {
    
    @State var message: MesiboMessage
    @State var messageNature: String
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var decodedData: [String: String] = ["": ""]
    
    var body: some View {
        VStack{
            if decodedData["messageType"] == "Profile" {
                if messageNature == "Incoming"{
                    IncomeProfileTabView(fullname: decodedData["profilePictureLink"] ?? "", username: decodedData["firstImageLink"] ?? "", profilePictureLink: decodedData["caption"] ?? "", userId: decodedData["userId"] ?? "", verificationStatus: decodedData["postId"] ?? "", profilePic: decodedData["caption"] ?? "", userRole: decodedData["username"] ?? "", loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, message: message)
                } else if messageNature == "Outgoing" {
                    OutgoingProfileTabView(fullname: decodedData["profilePictureLink"] ?? "", username: decodedData["firstImageLink"] ?? "", profilePictureLink: decodedData["caption"] ?? "", userId: decodedData["userId"] ?? "", verificationStatus: decodedData["postId"] ?? "", profilePic: decodedData["caption"] ?? "", userRole: decodedData["username"] ?? "", loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, message: message)
                }
            } else if decodedData["messageType"] == "Post" {
                if messageNature == "Incoming"{
                    IncomingPostTabView(caption: decodedData["caption"] ?? "", fullname: decodedData["fullName"] ?? "", username: decodedData["username"] ?? "", profilePictureLink: decodedData["profilePictureLink"] ?? "", userId: decodedData["userId"] ?? "", firstImageLink: decodedData["firstImageLink"] ?? "", postId: decodedData["postId"] ?? "", verificationStatus: decodedData["verificationStatus"] ?? "", message: message)
                } else if messageNature == "Outgoing" {
                    OutgoingPostView(caption: decodedData["caption"] ?? "", fullname: decodedData["fullName"] ?? "", username: decodedData["username"] ?? "", profilePictureLink: decodedData["profilePictureLink"] ?? "", userId: decodedData["userId"] ?? "", firstImageLink: decodedData["firstImageLink"] ?? "", postId: decodedData["postId"] ?? "", verificationStatus: decodedData["verificationStatus"] ?? "", message: message)
                }
            } else {
                if messageNature == "Incoming"{
                    MessageIncomingTabView(loginData: loginData, message: message )
                } else if messageNature == "Outgoing" {
                    MessageOutgoingTabView(loginData: loginData, message: message)
                }
            }
        }
        .onAppear{
//            firstFourLetter = getFirstFourLetters(text.message ?? "")
            decodedData = decodeData(message.message ?? "")
            print(decodeData(message.message ?? ""))
        }
    }
    func decodeString(_ input: String, shift: Int) -> String {
        var decodedData = ""
        for char in input {
            if let asciiValue = char.asciiValue, char.isLetter {
                let isUppercase = char.isUppercase
                let base: Int = isUppercase ? 65 : 97
                let decodedAscii = (Int(asciiValue) - base - shift + 26) % 26
                let decodedChar = Character(UnicodeScalar(decodedAscii + base)!)
                decodedData.append(decodedChar)
            } else {
                decodedData.append(char)
            }
        }
        return decodedData
    }
    
    func decodeData(_ encodedData: String) -> [String: String] {
        let keys = ["messageType", "userId", "postId", "profilePictureLink", "firstImageLink", "username", "caption", "verificationStatus", "fullName"]
        let values = encodedData.components(separatedBy: "|")
        var decodedData = [String: String]()
        
        for (index, value) in values.enumerated() {
            let shift: Int
            switch index {
            case 0:
                shift = 3
            case 1:
                shift = 5
            case 2:
                shift = 2
            case 3:
                shift = 4
            case 4:
                shift = 1
            case 5:
                shift = 6
            case 6:
                shift = 7
            case 7:
                shift = 8
            case 8:
                shift = 9
            default:
                shift = 0
            }
            let decodedValue = decodeString(value, shift: shift)
            decodedData[keys[index]] = decodedValue
        }
        
        return decodedData
    }
    
    func decodeProfileData(_ encodedData: String) -> [String: String] {
        let keys = ["messageType", "userID", "verificationStatus", "fullName", "userName", "userRole"]
        let values = encodedData.components(separatedBy: "|")
        var decodedData = [String: String]()
        
        for (index, value) in values.enumerated() {
            let shift: Int
            switch index {
            case 0:
                shift = 3
            case 1:
                shift = 5
            case 2:
                shift = 2
            case 3:
                shift = 4
            case 4:
                shift = 1
            case 5:
                shift = 6
            default:
                shift = 0
            }
            let decodedValue = decodeString(value, shift: shift)
            decodedData[keys[index]] = decodedValue
        }
        
        return decodedData
    }
}

//struct MessageDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageDetailView()
//    }
//}
