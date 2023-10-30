//
//  MessageModel.swift
//  R-own
//
//  Created by Aman Sharma on 18/04/23.
//

import Foundation

struct MessageModel: Identifiable, Codable{
    
    var id: Int
    var sentMessage: SentMessage
    var receivedMessage: ReceivedMessage
    
    static var messageStream: [MessageModel] {
        var messageList = [MessageModel]()
        
        return messageList
    }
    
}

struct SentMessage: Codable{
    var token: String
    var messageText: String
    var dateSent: Date
}

struct ReceivedMessage: Codable{
    var token: String
    var messageText: String
    var dateReceived: Date
}

//old
struct FPPMessage: Identifiable{
    var id: UUID = UUID()
    var name: String
    var image: String
}

struct TPPMessage: Identifiable{
    var id: UUID = UUID()
    var name: String
    var image: String
}
