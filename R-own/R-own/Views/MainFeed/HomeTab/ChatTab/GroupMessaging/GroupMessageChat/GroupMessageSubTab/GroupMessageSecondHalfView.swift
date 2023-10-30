//
//  GroupMessageSecondHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI
import mesibo

struct GroupMessageSecondHalfView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    
    var body: some View {
        Text("hi")
//            GeometryReader { geometry in
//                ScrollViewReader { scrollViewProxy in
//                    ScrollView(.vertical) {
//                        VStack {
//                            Spacer(minLength: 0) // Spacer at the top to push messages to the bottom
//                            ForEach(mesiboVM.messageList) { text in
//                                if !mesiboVM.messageList.isEmpty {
//                                    if mesiboVM.messageList.last.mMessage == text.mMessage {
//                                        Text(text.getTimestamp().getDate(true))
//                                    }
//                                }
//                                if mesiboVM.messages.before(text)?.getTimestamp().getDate(true) !=  text.getTimestamp().getDate(true) {
//                                    if mesiboVM.messages.before(text)?.getTimestamp().getDate(true) != nil {
//                                        Text(mesiboVM.messages.before(text)?.getTimestamp().getDate(true) ?? "Date Retreiving")
//                                    }
//                                } else{
//                                    if (text.isIncoming()) {
//                                        MessageIncomingTabView(loginData: loginData, message: text )
//
//                                    }else{
//                                        if text.isVoiceCall(){
//                                            Text("missed voice call")
//                                        }
//                                        else{
//                                            if text.isVideoCall(){
//                                                Text("is video call")
//                                            }else{
//                                                MessageOutgoingTabView(loginData: loginData, message: text)
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        .onChange(of: mesiboVM.messageList.count) { _ in
//                            // Scroll to the last message when the content changes
//                            withAnimation {
//                                scrollViewProxy.scrollTo(mesiboVM.messageList.reversed().indices.last, anchor: .bottom)
//                            }
//                        }
//                        .frame(height: geometry.size.height) // Set the height of the VStack to fill the available space
//                    }
//                    .onAppear {
//                        // Scroll to the last message when the view appears
//                        scrollViewProxy.scrollTo(mesiboVM.messageList.reversed().indices.last, anchor: .bottom)
//                    }
//                }
//            }
//            .background(
//                Image("DefaultChatBG")
//                    .resizable()
//                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/1.2)
//            )
//            ScrollViewReader { scrollViewProxy in
//                VStack{
//                    ForEach( mesiboVM.messages.reversed(), id: \.self){ text in
//                        Text(text.message ?? "message popped")
//                        if !mesiboVM.messages.isEmpty {
//                            if mesiboVM.messages.last == text {
//                                Text(text.getTimestamp().getDate(true))
//                            }
//                        }
//                        if mesiboVM.messages.before(text)?.getTimestamp().getDate(true) !=  text.getTimestamp().getDate(true) {
//                            if mesiboVM.messages.before(text)?.getTimestamp().getDate(true) != nil {
//                                Text(mesiboVM.messages.before(text)?.getTimestamp().getDate(true) ?? "Date Retreiving")
//                            }
//                        } else{
//                            if (text.isIncoming()) {
//                                MessageIncomingTabView(loginData: loginData, message: text )
//
//                            }else{
//                                if text.isVoiceCall(){
//                                    Text("missed voice call")
//                                }
//                                else{
//                                    if text.isVideoCall(){
//                                        Text("is video call")
//                                    }else{
//                                        MessageOutgoingTabView(loginData: loginData, message: text)
//
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    HStack{ Spacer()}
//                        .id("Empty")
//                }
//                .onReceive(mesiboVM.$messages) { _ in
////                    withAnimation(.easeOut(duration: 0.5)){
//                        scrollViewProxy.scrollTo("Empty", anchor: .bottom)
////                    }
//                }
//            }
    }
}

//struct GroupMessageSecondHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupMessageSecondHalfView()
//    }
//}
