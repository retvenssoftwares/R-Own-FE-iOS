//
//  MessageViewFirstHalf.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import SwiftUI
import MesiboUI

struct MessageViewFirstHalf: View {
    
    //back button var
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    // MARK: User Var
    
    
    //MesiboVar
    @StateObject var mesiboVM : MesiboViewModel
    
    @Binding var callStarted: Bool 
    
    @State var navigateToVideoCallScreen: Bool = false
    
    @State var navigateToProfileScreen: Bool = false
    
    @StateObject var mesiboChatService = MesiboChatService()
    
    @State var decodedData: [String: String] = ["": ""]
    
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var mesivoChatService = MesiboChatService()
    
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            if loginData.longTapActiveMessage == false {
                HStack{
                    Button(action: {
                        if loginData.notificationMessageView{
                            loginData.notificationMessageView.toggle()
                        } else {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }, label: {
                        Image("BackBtn")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                            .foregroundColor(.black)
                            .padding(.leading, UIScreen.screenWidth/40)
                    })
                    
                    if mesiboVM.mProfile != nil {
                        Button(action: {
                            navigateToProfileScreen.toggle()
                        }, label: {
                            
                            if mesiboVM.mProfile.getImageUrl() == "" || mesiboVM.mProfile.getImageUrl() == nil {
                                Image("UserIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                    .padding(.horizontal, UIScreen.screenWidth/50)
                            } else {
                                AsyncImage(url: currentUrl) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    Color.purple.opacity(0.1)
                                }
                                .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                .clipShape(Circle())
                                .padding(.horizontal, UIScreen.screenWidth/50)
                                .onAppear {
                                    if currentUrl == nil {
                                        DispatchQueue.main.async {
                                            currentUrl = URL(string: mesiboVM.mProfile.getImageUrl() ?? "")
                                        }
                                    }
                                }
                            }
                            
                        })
                        VStack(alignment: .leading){
                            NavigationLink(destination: ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: decodedData["userRole"] ?? "", mainUser: false, userID: decodedData["userID"] ?? ""), label: {
                                
                                    Text(mesiboVM.mProfile.getName() ?? "")
                                        .foregroundColor(.black)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .frame(alignment: .leading)
                            })
                            if Int(mesiboVM.mProfile.getLastSeen()) > 0 {
                                Text("last seen at \( timeAgoString(fromSeconds: Int(mesiboVM.mProfile.getLastSeen())) )")
                                    .foregroundColor(.black)
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                    .frame(alignment: .leading)
                            } else if Int(mesiboVM.mProfile.getLastSeen()) == 0{
                                Text("Online")
                                    .foregroundColor(greenUi)
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                    .frame(alignment: .leading)
                            }
                        }
                    }
                    
                    Spacer()
                    NavigationLink(destination: CallScreenView(mesiboVM: mesiboVM), isActive: $navigateToVideoCallScreen, label: {
                        Text("")
                    })
                    Button(action: {
                        mesiboVM.onAudioCall(loginData: loginData)
                        loginData.callActivated = true
                        mesiboChatService.callingNotification(receiveruserID: decodedData["userID"] ?? "", sendingUserID: loginData.mainUserID)
                        navigateToVideoCallScreen.toggle()
                    }) {
                        Image("ChatCall")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                    }
                    .padding(.horizontal, UIScreen.screenWidth/50)
                    
                    Button(action: {
                        mesiboVM.onVideoCall(loginData: loginData)
                        loginData.callActivated = true
                        mesiboChatService.callingNotification(receiveruserID: decodedData["userID"] ?? "", sendingUserID: loginData.mainUserID)
                        navigateToVideoCallScreen.toggle()
                    }) {
                        Image("ChatVideoCall")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                    }
                    .padding(.horizontal, UIScreen.screenWidth/50)
                    
                }
                .frame(width: UIScreen.screenWidth)
                .padding(.bottom, UIScreen.screenHeight/70)
                .padding(.top, UIScreen.screenHeight/70)
                .background(.white)
            } else {
                HStack{
                    
                }
                .frame(width: UIScreen.screenWidth)
                .padding(.vertical, UIScreen.screenHeight/80)
                .background(.white)
            }
        }
        .onAppear{
            print("=======================================")
            print(mesiboVM.mProfile.getStatus() ?? "")
            decodedData = decodeData(encodedData: mesiboVM.mProfile.getStatus() ?? "")
            
            print("=======================================")
        }
    }
    
    func decodeString(input: String, shift: Int) -> String {
        var decodedData = ""
        for char in input {
            let decodedChar: Character
            if char.isLetter {
                let base = char.isLowercase ? Character("a") : Character("A")
                let decodedAscii = (Int(char.asciiValue ?? 0) - Int(base.asciiValue ?? 0) - shift + 26) % 26
                decodedChar = Character(UnicodeScalar(decodedAscii + Int(base.asciiValue ?? 0))!)
            } else {
                decodedChar = char
            }
            decodedData.append(decodedChar)
        }
        return decodedData
    }
    
    func decodeData(encodedData: String) -> [String: String] {
        let decodedValues = encodedData.split(separator: "|")
        let keys = ["userID", "userRole"]
        var values = [String]()

        for (index, value) in decodedValues.enumerated() {
            let shift: Int
            switch index {
            case 0:
                shift = 5
            case 1:
                shift = 6
            default:
                shift = 0
            }
            let decodedValue = decodeString(input: String(value), shift: shift)
            values.append(decodedValue)
        }

        return Dictionary(uniqueKeysWithValues: zip(keys, values))
    }
    
    
}

//struct MessageViewFirstHalf_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageViewFirstHalf()
//    }
//}
