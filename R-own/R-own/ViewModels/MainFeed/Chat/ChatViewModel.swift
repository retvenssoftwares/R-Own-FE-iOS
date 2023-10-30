//
//  ChatViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 18/04/23.
//

import SwiftUI


//class ChatViewModel: ObservableObject{
//    @Published var messagesList = [MessageModel]()
//
//    //the user whose message list we want
//    @Published var selectedTPPUser: Int = 0
//
//
//    //@Published var messages: Set<Int>
//
//    //list of messages of respective chat for each  contact
//    var respectiveTPPChat: [MessageModel]{
//        if selectedTPPUser != 0 {
//            return messagesList.contains(where: $0.id == selectedTPPUser)
//        } else {
//            print("No messages found")
//        }
//    }
//    private var db = MessageDatabase()
//
//    init() {
//        self.messages = db.load()
//        self.messagesList = messages
//    }
//}


//struct ChatViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatViewModel()
//    }
//}
