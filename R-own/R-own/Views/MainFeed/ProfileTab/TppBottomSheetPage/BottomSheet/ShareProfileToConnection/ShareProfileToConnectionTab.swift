//
//  ShareProfileToConnectionTab.swift
//  R-own
//
//  Created by Aman Sharma on 15/08/23.
//

import SwiftUI

struct ShareProfileToConnectionTab: View {
    
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var userRole: String
    @State var profileConnection: Conn334
    
    @State var encodedString: String = ""
    @State var connectionSearch: String = ""
    
    @State var isLoading: Bool = false
    
    @StateObject var mesiboVM = MesiboViewModel()
    
    @StateObject var profileService = ProfileService()
    
    @State var sentStatus: Bool = false
    
    
    
    
    var body: some View {
        VStack{
            HStack{
                ProfilePictureView(profilePic: profileConnection.profilePic, verified: profileConnection.verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                
                VStack(alignment: .leading){
                    
                    Text(profileConnection.fullName)
                        .font(.body)
                        .fontWeight(.semibold)
                    Text("username")
                        .font(.body)
                        .fontWeight(.light)
                    
                }
                
                Spacer()
                
                Button(action: {
                    if !sentStatus {
                        encodedString = encodeData(messageType: "Profile", userID: profileConnection.userID, verificationStatus: profileConnection.verificationStatus, fullName: profileConnection.fullName, userName: "username", userRole: userRole, profilePic: profileConnection.profilePic)
                        print(encodedString)
                        mesiboVM.mesiboSetTPPUser(profileConnection.mesiboAccount[0].address)
                        mesiboVM.onSendMessage(messageText: encodedString, loginData: loginData)
                        sentStatus = true
                    }
                }, label: {
                    Text(sentStatus ? "Sent" : "Share")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.horizontal, UIScreen.screenWidth/60)
                        .padding(.vertical, UIScreen.screenHeight/90)
                        .background(greenUi)
                        .cornerRadius(10)
                        .padding()
                })
            }
            Divider()
        }
    }
    func encodeData(
        messageType: String,
        userID: String,
        verificationStatus: String,
        fullName: String,
        userName: String,
        userRole: String,
        profilePic: String
    ) -> String {
        let encodedMessageType = encodeString(messageType, shift: 3)
        let encodedUserID = encodeString(userID, shift: 5)
        let encodedVerificationStatus = encodeString(verificationStatus, shift: 2)
        let encodedFullName = encodeString(fullName, shift: 4)
        let encodedUserName = encodeString(userName, shift: 1)
        let encodedUserRole = encodeString(userRole, shift: 6)
        let encodedProfilePic = encodeString(profilePic, shift: 7)

        return "\(encodedMessageType)|\(encodedUserID)|\(encodedVerificationStatus)|\(encodedFullName)|\(encodedUserName)|\(encodedUserRole)|\(encodedProfilePic)"
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
}

//struct ShareProfileToConnectionTab_Previews: PreviewProvider {
//    static var previews: some View {
//        ShareProfileToConnectionTab()
//    }
//}
