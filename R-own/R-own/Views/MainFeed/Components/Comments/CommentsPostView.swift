//
//  CommentsPostView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct CommentsPostView: View {
    
    @State var postID: String
    @State var posterID: String
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    
    @State var replySelected: Bool = false
    @State var newComment: String = ""
    
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView{
                VStack(alignment: .leading){
                    if globalVM.commentList.post.comments.count > 0 {
                        ForEach(0..<globalVM.commentList.post.comments.count, id: \.self){ count in
//                            CommentTabView(comment: globalVM.commentList.post.comments[count])
                        }
                    } else {
                        Text("No one has commented yet. Be first one to do so.")
                    }
                }
                .padding(.horizontal, UIScreen.screenWidth/40)
            }
        }
    }
}

//struct CommentsPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentsPostView()
//    }
//}
