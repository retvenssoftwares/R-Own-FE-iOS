//
//  SendImageToUserTab.swift
//  R-own
//
//  Created by Aman Sharma on 05/07/23.
//

import SwiftUI

struct SendImageToUserTab: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @State var count: Int
    @State var postID: String
    @State var firstImageLink: String
    @State var caption: String
    
    @State var encodedString: String = ""
    
    @State var sentStatus: Bool = false
    
    @State var filteredConnections: [ProfileConnectionListModel]
    
    var body: some View {
        VStack{
            HStack{
                ProfilePictureView(profilePic: filteredConnections[0].conns[count].profilePic, verified: filteredConnections[0].conns[count].verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                VStack(alignment: .leading){
                    Text(filteredConnections[0].conns[count].fullName)
                        .font(.body)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                    if filteredConnections[0].conns[count].userName == ""{
                        Text(filteredConnections[0].conns[count].userName)
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.light)
                    }
                }
                Spacer()
                Button(action: {
                    if !sentStatus {
                        sentStatus.toggle()
                        encodedString = encodeData(messageType: "Post", userId: filteredConnections[0].conns[count].userID, postId: postID, profilePictureLink: filteredConnections[0].conns[count].profilePic, firstImageLink: firstImageLink, username: "username", caption: caption, verificationStatus: filteredConnections[0].conns[count].verificationStatus, fullName: filteredConnections[0].conns[count].fullName)
                        print(encodedString)
                        mesiboVM.mesiboSetTPPUser(filteredConnections[0].conns[count].mesiboAccount[0].address)
                        mesiboVM.onSendMessage(messageText: encodedString, loginData: loginData)
                    }
                }, label: {
                    Text(sentStatus ? "Sent" : "Share")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(sentStatus ? greenUi : jobsDarkBlue)
                        .padding(.horizontal, UIScreen.screenWidth/60)
                        .padding(.vertical, UIScreen.screenHeight/90)
                        .background(sentStatus ? jobsDarkBlue : greenUi)
                        .cornerRadius(10)
                        .padding()
                })
            }
            .padding(.horizontal, UIScreen.screenWidth/20)
            Divider()
        }
    }
    
    func encodeString(_ input: String, shift: Int) -> String {
        var encodedData = ""
        for char in input {
            if let asciiValue = char.asciiValue, char.isLetter {
                let isUppercase = char.isUppercase
                let base: Int = isUppercase ? 65 : 97
                let encodedAscii = (Int(asciiValue) - base + shift) % 26
                let encodedChar = Character(UnicodeScalar(encodedAscii + base)!)
                encodedData.append(encodedChar)
            } else {
                encodedData.append(char)
            }
        }
        return encodedData
    }

    func encodeData(
        messageType: String,
        userId: String,
        postId: String,
        profilePictureLink: String,
        firstImageLink: String,
        username: String,
        caption: String,
        verificationStatus: String,
        fullName: String
    ) -> String {
        let encodedMessageType = encodeString(messageType, shift: 3)
        let encodedUserId = encodeString(userId, shift: 5)
        let encodedPostId = encodeString(postId, shift: 2)
        let encodedProfilePictureLink = encodeString(profilePictureLink, shift: 4)
        let encodedFirstImageLink = encodeString(firstImageLink, shift: 1)
        let encodedUsername = encodeString(username, shift: 6)
        let encodedCaption = encodeString(caption, shift: 7)
        let encodedVerificationStatus = encodeString(verificationStatus, shift: 8)
        let encodedFullName = encodeString(fullName, shift: 9)

        return "\(encodedMessageType)|\(encodedUserId)|\(encodedPostId)|\(encodedProfilePictureLink)|\(encodedFirstImageLink)|\(encodedUsername)|\(encodedCaption)|\(encodedVerificationStatus)|\(encodedFullName)"
    }
}

//struct SendImageToUserTab_Previews: PreviewProvider {
//    static var previews: some View {
//        SendImageToUserTab()
//    }
//}
