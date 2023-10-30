//
//  SendImagePostBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 02/07/23.
//

import SwiftUI

struct SendImagePostBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var postID: String
    @State var firstImageLink: String
    @State var caption: String
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var connectionSearch: String = ""
    
    @StateObject var mesiboVM = MesiboViewModel()
    
    var filteredConnections: [ProfileConnectionListModel] {
        connectionSearch.isEmpty ? globalVM.getConnectionList : globalVM.getConnectionList.filter { $0.conns[0].fullName.localizedCaseInsensitiveContains(connectionSearch) }
    }
    
    var body: some View {
        VStack{
            VStack(spacing: 20){
                Text("Share with your connections")
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top,30)
                
                HStack{
                    TextField("Search connections Profile", text: $connectionSearch)
                        .font(.body)
                        .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/30, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .overlay(alignment: .trailing, content: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        })
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 0.8)
                                .foregroundColor(lightGreyUi)
                        }
                        .focused($isKeyboardShowing)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    
                                    isKeyboardShowing = false
                                    globalVM.keyboardVisibility = false
                                }
                            }
                        }
                }
                
                //Location Array
                if filteredConnections.count > 0{
                    if filteredConnections[0].conns.count > 0{
                        ScrollView{
                            VStack(alignment: .leading){
                                ForEach(0..<filteredConnections[0].conns.count, id: \.self) {count in
                                    SendImageToUserTab(globalVM: globalVM, loginData: loginData, mesiboVM: mesiboVM, count: count, postID: postID, firstImageLink: firstImageLink, caption: caption, filteredConnections: filteredConnections)
                                }
                            }
                        }
                    } else {
                        Text("Oops, You dont have any connection to show yet!")
                            .font(.body)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                else {
                    Text("Error occured, please try again")
                        .font(.body)
                        .foregroundColor(.black)
                }
//                Button(action: {
//
//                }, label: {
//                    Text(
//                })
            }
            Spacer()
        }
        .frame(width: UIScreen.screenWidth)
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
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

//struct SendImagePostBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        SendImagePostBottomSheet()
//    }
//}
