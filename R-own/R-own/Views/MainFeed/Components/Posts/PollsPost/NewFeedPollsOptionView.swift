//
//  NewFeedPollsOptionView.swift
//  R-own
//
//  Created by Aman Sharma on 28/07/23.
//

import SwiftUI

struct NewFeedPollsOptionView: View {
    
    
    @State var poll: Option535
    @Binding var totalVotes: Int
    @State var totalVotesDisplay: Float
    @State var pollSelection: String = ""
    @State var postID: String
    @State var loginData: LoginViewModel
    
    @State var pollsSelected: Bool = false
    @State var progressViewPercent: Float = 0.0
    @StateObject var postService = PostsService()
    
    var body: some View {
        VStack{
            HStack{
                Text(poll.option)
                    .multilineTextAlignment(.leading)
                    .font(.body)
                
                Image(pollsSelected ? "PollsSelected" : "PollsUnselected")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenHeight/80,height: UIScreen.screenHeight/80)
                
                Spacer()
                
                if pollSelection == "yes" {
                    if totalVotes > 0 {
                        Text("\(Int((Float(poll.votes.count)/Float(totalVotes))*100)) %")
                    } else {
                        Text("0 %")
                    }
                }
            }
            if pollSelection == "yes" {
                ProgressView("", value: poll.votes.count == 0 ? 0 : progressViewPercent, total: 100)
                    .tint(pollsSelected ? greenUi : .black.opacity(0.8))
                    .frame(width: UIScreen.screenWidth/1.6)
                    .onAppear{
                        progressViewPercent = (Float(poll.votes.count)/Float(totalVotes))*100
                        progressViewPercent = round(progressViewPercent * 10) / 10.0
                    }
            }
        }
        .padding(.horizontal, UIScreen.screenWidth/30)
        .padding(.vertical, UIScreen.screenHeight/70)
        .frame(width: UIScreen.screenWidth/1.1)
        .overlay{
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 1)
        }
        .onTapGesture {
            if pollSelection == "no" {
                postService.updateOptionInPoll(loginData: loginData, postID: postID, optionID: poll.optionID)
                totalVotes += 1
                pollsSelected = true
                poll.votes.append(Vote535(userID: loginData.mainUserID, id: ""))
                progressViewPercent = (Float(poll.votes.count)/Float(totalVotes))*100
                progressViewPercent = round(progressViewPercent * 10) / 10.0
                pollSelection = "yes"
            }
        }
        .onAppear{
            if poll.votes.count > 0 {
                for i in 0..<poll.votes.count {
                    if poll.votes[i]!.userID == loginData.mainUserID {
                        pollsSelected = true
                        pollSelection = "yes"
                    } else {
                        pollsSelected = false
                        pollSelection = "no"
                    }
                }
            }
            progressViewPercent = (Float(poll.votes.count)/Float(totalVotes))*100
            progressViewPercent = round(progressViewPercent * 10) / 10.0
        }
    }
}

//struct NewFeedPollsOptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFeedPollsOptionView()
//    }
//}
