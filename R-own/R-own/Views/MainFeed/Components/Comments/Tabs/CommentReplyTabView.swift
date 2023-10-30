//
//  CommentReplyTabView.swift
//  R-own
//
//  Created by Aman Sharma on 22/05/23.
//

import SwiftUI

struct CommentReplyTabView: View {
    
    @State var commentReply: Reply5355
    
    var body: some View {
        HStack(alignment: .top){
            
            if commentReply.fullName != "" {
                ProfilePictureView(profilePic: commentReply.profilePic, verified: false, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                    .padding(.vertical, UIScreen.screenHeight/80)
                    .padding(.horizontal, UIScreen.screenWidth/40)
                VStack(alignment: .leading, spacing: 2){
                    Text(commentReply.userName != "" ? commentReply.userName : commentReply.fullName)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.vertical, UIScreen.screenHeight/90)
                    Text(commentReply.comment)
                        .font(.body)
                        .fontWeight(.light)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    HStack{
                        
                        //                    Button(action: {
                        //                        print("clicked on reply")
                        //                    }, label: {
                        //                        HStack{
                        //                            Image(systemName: "arrowshape.turn.up.left.fill")
                        //                                .resizable()
                        //                                .scaledToFit()
                        //                                .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                        //                                .foregroundColor(.black)
                        //                            Text("Reply")
                        //                            .font(.system(size: UIScreen.screenHeight/80))
                        //                            .foregroundColor(.black)
                        //                        }
                        //                    })
                        //                    .padding(10)
                        //                    .background(lightGreyUi.opacity(0.4))
                        //                    .cornerRadius(10)
                        
                        Spacer()
                        HStack(spacing: 1){
                            Image(systemName: "clock")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                            Text((commentReply.dateAdded == "few seconds ago" ? commentReply.dateAdded : relativeTime(from: commentReply.dateAdded)) ?? "")
                                .font(.footnote)
                                .fontWeight(.light)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
        .padding(.leading, UIScreen.screenHeight/40)
        .padding(.vertical, UIScreen.screenHeight/100)
    }
}

//struct CommentReplyTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentReplyTabView()
//    }
//}
