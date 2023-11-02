//
//  MessageViewSecondHalf.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import SwiftUI

struct MessageViewSecondHalf: View {
    
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    // MARK: User Var
    
    //MesiboVar
    @StateObject var mesiboVM : MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State private var vStackHeight: CGFloat = 0
    
    @State var firstFourLetter: String = ""
    @State private var scrollToBottom = false
    
    @Binding var keyboardVisibility: Bool
    @State private var lazyVStackID: UUID = UUID()
    
    var body: some View {
            VStack{
                ScrollViewReader { scrollView in
                    ScrollView {
                        LazyVStack {
                            ForEach( mesiboVM.chatMessageList, id: \.id){ meess in
                                VStack{
                                    let text = meess.mMessage
                                    if mesiboVM.chatMessageList.before(meess)?.mMessage.getTimestamp().getDate(true) !=  text.getTimestamp().getDate(true) {
                                        MessageDateTab(date: formatDate(text.getTimestamp().getDate(true)))
                                        if (text.isIncoming()) {
                                            if text.isMissedCall(){
                                                if text.isVoiceCall() {
                                                    AudioMissedCallMessageTab()
                                                } else if text.isVideoCall() {
                                                    VideoMissedCallMessage()
                                                }
                                            } else {
                                                if text.isImage() {
                                                    ImageIncomingTabView(loginData: loginData, message: text )
                                                } else if text.isAudio() {
                                                    IncomingAudioTabView(audioURL: URL(string: text.getFile()?.url ?? ""), audioName: text.getFile()?.name ?? "", message: text)
                                                } else if text.isVideo() {
                                                    VideoIncomingTabView(loginData: loginData, message: text)
                                                } else if text.isDocument() {
                                                    DocumentIncomingMessageTab(loginData: loginData, mesiboVM: mesiboVM, messageStatus: "Incoming", message: text)
                                                } else if text.isMessage() {
                                                    if text.isDeleted() {
                                                        DeletedIncomingMessageTab(loginData: loginData, message: text)
                                                    } else {
                                                        MessageDetailView(message: text, messageNature: "Incoming", loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM)
                                                    }
                                                }
                                            }
                                        }else{
                                            if text.isMissedCall(){
                                                if text.isVoiceCall() {
                                                    AudioMissedCallMessageTab()
                                                } else if text.isVideoCall() {
                                                    VideoMissedCallMessage()
                                                }
                                            } else {
                                                if text.isImage() {
                                                    ImageOutGoingTabView(loginData: loginData, message: text )
                                                }  else if text.isAudio() {
                                                    OutgoingAudioTabView(audioURL: URL(string: text.getFile()?.url ?? ""), audioName: text.getFile()?.name ?? "", message: text)
                                                } else if text.isVideo() {
                                                    VideoOutgoingTabView(loginData: loginData, message: text)
                                                } else if text.isDocument() {
                                                    DocumentOutgoingMessageTab(loginData: loginData, mesiboVM: mesiboVM, messageStatus: "Outgoing", message: text)
                                                } else if text.isMessage() {
                                                    if text.isDeleted() {
                                                        DeletedOutgoingMessageTab(loginData: loginData, message: text)
                                                    } else {
                                                        MessageDetailView(message: text, messageNature: "Outgoing", loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM)
                                                    }
                                                }
                                            }
                                        }
                                    } else {
                                        if (text.isIncoming()) {
                                            if text.isMissedCall(){
                                                if text.isVoiceCall() {
                                                    AudioMissedCallMessageTab()
                                                } else if text.isVideoCall() {
                                                    VideoMissedCallMessage()
                                                }
                                            } else {
                                                if text.isImage() {
                                                    ImageIncomingTabView(loginData: loginData, message: text )
                                                } else if text.isAudio() {
                                                    IncomingAudioTabView(audioURL: URL(string: text.getFile()?.url ?? ""), audioName: text.getFile()?.name ?? "", message: text)
                                                } else if text.isVideo() {
                                                    VideoIncomingTabView(loginData: loginData, message: text)
                                                } else if text.isDocument() {
                                                    DocumentIncomingMessageTab(loginData: loginData, mesiboVM: mesiboVM, messageStatus: "Incoming", message: text)
                                                } else if text.isMessage() {
                                                    if text.isDeleted() {
                                                        DeletedIncomingMessageTab(loginData: loginData, message: text)
                                                    } else {
                                                        MessageDetailView(message: text, messageNature: "Incoming", loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM)
                                                    }
                                                }
                                            }
                                        }else{
                                            if text.isMissedCall(){
                                                if text.isVoiceCall() {
                                                    AudioMissedCallMessageTab()
                                                } else if text.isVideoCall() {
                                                    VideoMissedCallMessage()
                                                }
                                            } else {
                                                if text.isImage() {
                                                    ImageOutGoingTabView(loginData: loginData, message: text )
                                                }  else if text.isAudio() {
                                                    OutgoingAudioTabView(audioURL: URL(string: text.getFile()?.url ?? ""), audioName: text.getFile()?.name ?? "", message: text)
                                                } else if text.isVideo() {
                                                    VideoOutgoingTabView(loginData: loginData, message: text)
                                                } else if text.isDocument() {
                                                    DocumentOutgoingMessageTab(loginData: loginData, mesiboVM: mesiboVM, messageStatus: "Outgoing", message: text)
                                                } else if text.isMessage() {
                                                    if text.isDeleted() {
                                                        DeletedOutgoingMessageTab(loginData: loginData, message: text)
                                                    } else {
                                                        MessageDetailView(message: text, messageNature: "Outgoing", loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                .onAppear{
                                    print(meess.id)
                                }
                            }
                        }
                        .onTapGesture {
                            print("hjhjhj")
                            keyboardVisibility = false
                        }
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                print("=============================")
                                // Scroll to the bottom when the view appears
                                scrollView.scrollTo(1, anchor: .bottom)
                            }
                        }
                        .onChange(of: mesiboVM.chatMessageList, perform: { _ in
                            withAnimation {
                                scrollView.scrollTo(mesiboVM.chatMessageList.count, anchor: .bottom)
                            }
                        })
                    }
                }
            }
    }
    
    func getFirstFourLetters(_ input: String) -> String {
        let endIndex = input.index(input.startIndex, offsetBy: min(4, input.count))
        return String(input[..<endIndex])
    }
    func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        if dateString != "" {
            guard let date = dateFormatter.date(from: dateString) else {
                return dateString // Return the original string if the date cannot be parsed
            }
            
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
            
            if calendar.isDateInToday(date) {
                return "Today"
            } else if calendar.isDateInYesterday(date) {
                return "Yesterday"
            } else if calendar.isDate(date, equalTo: today, toGranularity: .weekOfYear) {
                dateFormatter.dateFormat = "EEEE" // Display day of the week
                return dateFormatter.string(from: date)
            } else {
                return dateString // Return the original string if it's older than a week
            }
        } else {
            return dateString
        }
    }

}
//struct MessageViewSecondHalf_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageViewSecondHalf()
//    }
//}
struct GeometryPreferenceKey: PreferenceKey {
    typealias Value = [GeometryPreferenceData]

    static var defaultValue: [GeometryPreferenceData] = []

    static func reduce(value: inout [GeometryPreferenceData], nextValue: () -> [GeometryPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

struct GeometryPreferenceData: Equatable {
    var size: CGSize
}

struct GeometryGetter: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: GeometryPreferenceKey.self, value: [GeometryPreferenceData(size: geometry.size)])
        }
    }
}
struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
