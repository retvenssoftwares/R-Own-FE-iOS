//
//  CommentTabView.swift
//  R-own
//
//  Created by Aman Sharma on 22/05/23.
//

import SwiftUI

struct CommentTabView: View {
    
    @State var comment: Comment5355
    @Binding var replySelected: Bool
    @Binding var selectedCommentID: String
    @Binding var selectedCommentUserName: String
    @Binding var newComment: String
    @Binding var replyCount: Int
    @Binding var selectedComment: String
    @Binding var selectedCommentFullName: String
    @State var count: Int
    
    @State var replyView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top){
                
                ProfilePictureView(profilePic: comment.profilePic, verified: false, height: UIScreen.screenHeight/25, width: UIScreen.screenHeight/25)
                    .padding(.vertical, UIScreen.screenHeight/80)
                    .padding(.horizontal, 4)
                
                VStack(alignment: .leading, spacing: 2){
                    Text(comment.userName != "" ? comment.userName : comment.fullName)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.vertical, UIScreen.screenHeight/80)
                    Text(comment.comment)
                        .font(.body)
                        .fontWeight(.light)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    
                    HStack{
                        
                        Button(action: {
                            print("clicked on reply")
                            selectedCommentUserName = comment.userName
                            selectedCommentID = comment.commentID
                            selectedComment = comment.comment
                            selectedCommentFullName = comment.fullName
                            print(selectedCommentID)
                            replyCount = count
                            replySelected = true
                            replyView = true
                        }, label: {
                            HStack{
                                Image(systemName: "arrowshape.turn.up.left.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                    .foregroundColor(.black)
                                Text("Reply")
                                    .font(.footnote)
                                .foregroundColor(.black)
                                
                            }
                        })
                        .padding(10)
                        .background(lightGreyUi.opacity(0.4))
                        .cornerRadius(10)
                        if comment.replies != nil {
                            if comment.replies!.count > 0 {
                                if !replyView{
                                    Button(action: {
                                        replyView = true
                                    }, label: {
                                        Text("View \(comment.replies!.count) reply")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .foregroundColor(.black)
                                    })
                                }
                            }
                        }
                        Spacer()
                        
                        HStack(spacing: 3){
                            Image(systemName: "clock")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                            Text(comment.dateAdded == "few seconds ago" ? comment.dateAdded : relativeTime(from: comment.dateAdded) ?? "")
                                .font(.footnote)
                                .fontWeight(.light)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            if comment.replies != nil {
                if comment.replies!.count > 0 {
                    if replyView{
                        ForEach(0..<comment.replies!.count, id: \.self){ count in
                            if comment.replies![count].displayStatus == "1" {
                                CommentReplyTabView(commentReply: comment.replies![count])
                            }
                        }
                    }
                    if replyView {
                        Button(action: {
                            replyView = false
                        }, label: {
                            Text("Hide replies")
                                .font(.footnote)
                                .fontWeight(.light)
                                .foregroundColor(.black)
                        })
                    }
                }
            }
        }
    }
}

//struct CommentTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentTabView()
//    }
//}
