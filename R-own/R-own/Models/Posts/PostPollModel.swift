//
//  PostPollModel.swift
//  R-own
//
//  Created by Aman Sharma on 30/05/23.
//

import Foundation

struct PostPollsModel: Decodable {
    var Question: String
    var Options: [PollOptions]
}

struct PollOptions: Decodable {
    var Option: String
}

//struct PostPollModel_Previews: PreviewProvider {
//    static var previews: some View {
//        PostPollModel()
//    }
//}
