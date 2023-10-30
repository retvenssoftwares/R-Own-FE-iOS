//
//  GroupMessageThirdHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI

struct GroupMessageThirdHalfView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    
    //Keyboard
    @FocusState private var isKeyboardShowing: Bool
    @State var message: String = ""
    
    
    var body: some View {
        HStack{
            Button(action: {}, label: {
                Image("ChatEmoji")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                    .padding(5)
                    .padding(.vertical, 10)
            })
            TextField("Type your message...", text: $message)
                .focused($isKeyboardShowing)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isKeyboardShowing = false
                        }
                    }
                }
            if message != "" {
                Button(action: {
                    mesiboVM.onSendMessage( messageText: message, loginData: loginData)
                    message = ""
                }, label: {
                        Image(systemName: "arrowshape.turn.up.right.circle")
                        .foregroundColor(.black)
                        .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                })
            } else {
                HStack{
                    Button(action: {}, label: {
                        Image("ChatAttachment")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                            .padding(5)
                            .padding(.vertical, 10)
                    })
                    Button(action: {}, label: {
                        Image("ChatCamera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                            .padding(5)
                            .padding(.vertical, 10)
                    })
                    Button(action: {}, label: {
                        Image("ChatVoice")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                            .padding(5)
                            .padding(.vertical, 10)
                    })
                }
            }
        }
        .frame(width: UIScreen.screenWidth/1.1)
        .background(lightGreyUi)
        .cornerRadius(5)
    }
}

//struct GroupMessageThirdHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupMessageThirdHalfView()
//    }
//}
