//
//  NormalProfileFPPPollsTabStruct.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI

struct NormalProfileFPPPollsTabStruct: View {
    
    @State var poll: Option344
    @StateObject var loginData: LoginViewModel
    
    @Binding var totalVotes: Int
    @State var totalVotesDisplay: Float
    @State var postID: String
    @State var pollsSelected: Bool = false
    @Binding var pollSelection: String
    @State var progressViewPercent: Float = 0.0
    
    @StateObject var postService = PostsService()
    
    var body: some View {
        VStack{
            Button(action: {
                print("Tapped")
                if pollSelection == "no" {
                    postService.updateOptionInPoll(loginData: loginData, postID: postID, optionID: poll.optionID)
                    totalVotes += 1
                    pollsSelected = true
                    poll.votes!.append(Vote344(userID: loginData.mainUserID, fullName: loginData.mainUserFullName, role: loginData.mainUserRole, id: ""))
                    progressViewPercent = (Float(poll.votes!.count)/Float(totalVotes))*100
                    progressViewPercent = round(progressViewPercent * 10) / 10.0
                    pollSelection = "yes"
                }
            }, label: {
                
                VStack(spacing: 1){
                    HStack{
                        Text(poll.option)
                            .foregroundColor(.black)
                        Image(pollsSelected ? "PollsSelected" : "PollsUnselected")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/80,height: UIScreen.screenHeight/80)
                        Spacer()
                        
                        if pollSelection == "yes" {
                            if totalVotes > 0 {
                                Text("\(Int((Float(poll.votes!.count)/Float(totalVotes))*100)) %")
                                    .foregroundColor(.black)
                            } else {
                                Text("0 %")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    if pollSelection == "yes" {
                        ProgressView("", value: poll.votes!.count == 0 ? 0 : progressViewPercent, total: 100)
                            .tint(pollsSelected ? greenUi : .black.opacity(0.8))
                            .frame(width: UIScreen.screenWidth/1.4)
                            .onAppear{
                                progressViewPercent = (Float(poll.votes!.count)/Float(totalVotes))*100
                                progressViewPercent = round(progressViewPercent * 10) / 10.0
                            }
                    }
                }
                .padding(.vertical, UIScreen.screenHeight/90)
                .padding(.horizontal, UIScreen.screenWidth/40)
            })
        }
        .overlay{
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 1)
        }
        .onAppear{
            if poll.votes!.count > 0 {
                for i in 0..<poll.votes!.count {
                    if poll.votes![i].userID == loginData.mainUserID {
                        pollsSelected = true
                    }
                }
            }
            progressViewPercent = (Float(poll.votes!.count)/Float(totalVotes))*100
            progressViewPercent = round(progressViewPercent * 10) / 10.0
        }
        .padding(.horizontal, UIScreen.screenWidth/8)
        
    }
}

//struct NormalProfileFPPPollsTabStruct_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileFPPPollsTabStruct()
//    }
//}
