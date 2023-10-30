//
//  ChatTabStruct.swift
//  R-own
//
//  Created by Aman Sharma on 22/09/23.
//

import SwiftUI
import mesibo

struct ChatTabStruct: View {
    
    @StateObject var mesiboVM: MesiboViewModel
    @State var message: MesiboMessage
    @State var mesiboProfile: MesiboProfile = MesiboProfile()
    @State var longTapChat: Bool = false
    
    @State var decodedData: [String: String] = ["": ""]
    
    var body: some View {
        VStack{
            HStack{
                if message.isGroupMessage() {
                    ProfilePictureView(profilePic: message.groupProfile?.getImageUrl() ?? "", verified: false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                        .padding(.trailing, UIScreen.screenWidth/40)
                } else {
                    ProfilePictureView(profilePic: message.profile?.getImageUrl() ?? "", verified: false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                        .padding(.trailing, UIScreen.screenWidth/40)
                }
                VStack(alignment: .leading){
                    if message.isGroupMessage() {
                        Text(message.groupProfile?.getName() ?? "Fetching group name")
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    } else {
                        Text(message.profile?.getName() ?? "Fetching UserName")
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    if message.isMissedCall(){
                        if message.isVoiceCall() {
                            HStack(spacing: 5){
                                Image(systemName: "phone.down.fill")
                                    .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                    .foregroundColor(.gray)
                                Text("Missed Voice Call")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                        } else if message.isVideoCall() {
                            HStack(spacing: 5){
                                Image(systemName: "video.fill")
                                    .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                    .foregroundColor(.gray)
                                Text("Missed Video Call")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                        }
                    } else {
                        if message.isImage() {
                            HStack(spacing: 5){
                                Image(systemName: "photo.fill")
                                    .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                    .foregroundColor(.gray)
                                Text(message.message ?? "Sent you an image" )
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                        } else if message.isAudio() {
                            HStack(spacing: 5){
                                Image(systemName: "headphones.circle.fill")
                                    .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                    .foregroundColor(.gray)
                                Text(message.message ?? "Sent you an audio" )
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                        } else if message.isVideo() {
                            HStack(spacing: 5){
                                Image(systemName: "video.circle.fill")
                                    .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                    .foregroundColor(.gray)
                                Text(message.message ?? "Sent you a video" )
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                        } else if message.isDocument() {
                            HStack(spacing: 5){
                                Image(systemName: "doc.fill")
                                    .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                    .foregroundColor(.gray)
                                Text(message.message ?? "Sent you a document")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                        } else if message.isMessage() {
                            if message.isDeleted() {
                                Text("Message is deleted")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            } else if decodedData["messageType"] == "Profile" {
                                Text("Shared a profile")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            } else if decodedData["messageType"] == "Post" {
                                Text("Shared a post")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            } else {
                                Text(message.message ?? "Sent you a message")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                        }
                    }
                }
                Spacer()
                VStack{
                    HStack(spacing: 5){
                        if (message.getTimestamp().daysElapsed == 0){
                            Text(convertTo12HourClock(message.getTimestamp().getTime(true))!)
                                .foregroundColor(.gray)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .frame(alignment: .leading)
                        } else{
                            Text("\(message.getTimestamp().daysElapsed) days ago")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .frame(alignment: .leading)
                        }
                    }
                    if mesiboProfile.getUnreadMessageCount() != 0{
                        Text("\(mesiboProfile.getUnreadMessageCount())")
                            .foregroundColor(.black)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .padding(4)
                            .background(greenUi)
                            .cornerRadius(4)
                            .frame(alignment: .leading)
                    }
                }
                .padding(.leading, 10)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(.white.opacity(0.1))
            .frame(width: UIScreen.screenWidth)
            .onAppear{
                //            firstFourLetter = getFirstFourLetters(text.message ?? "")
                decodedData = decodeData(message.message ?? "")
                print(decodeData(message.message ?? ""))
            }
            .onLongPressGesture(perform: {
                longTapChat.toggle()
            })
            .sheet(isPresented: $longTapChat, content: {
                VStack{
                    Button(action: {
                        
                    }, label: {
                        HStack{
                            Text("Delete Chat")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                            Spacer()
                            Image(systemName: "xmark.bin.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                .foregroundColor(.red)
                            
                        }
                        .padding(.horizontal, UIScreen.screenWidth/30)
                    })
                }
                .presentationDetents([ .height(UIScreen.screenHeight/10)])
            })
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

//struct ChatTabStruct_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatTabStruct()
//    }
//}
