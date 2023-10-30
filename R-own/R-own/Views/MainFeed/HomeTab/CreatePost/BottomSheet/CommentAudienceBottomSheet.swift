//
//  CommentAudienceBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI

struct CommentAudienceBottomSheet: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    
    @Binding var audienceName: String
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                    VStack(alignment: .leading){
                        Text("Comment Audience")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(UIScreen.screenHeight/70)
                        Button(action: {
                            audienceName = "Anyone"
                            createPostVM.canCommentAudienceBottomSheet = false
                        }, label: {
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Anyone")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    Image("PostAudienceAnyone")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                }
                                Text("Anyone on the app with similar interests as the topic of the post can interact with your post.")
                                    .font(.footnote)
                                    .fontWeight(.thin)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                            }
                        })
                            
                        Divider()
                            
                        Button(action: {
                            audienceName = "Connections"
                            createPostVM.canCommentAudienceBottomSheet = false
                        }, label: {
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Connections")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    Image("PostAudienceConnections")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                }
                                Text("Only people you are connected with can interact with your post.")
                                    .font(.footnote)
                                    .fontWeight(.thin)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                            }
                        })
                        Divider()
                        Spacer()
                        
                    }
                    .padding(.horizontal, UIScreen.screenWidth/30)
                    .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/3.5)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: createPostVM.canCommentAudienceBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(createPostVM.canCommentAudienceBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        createPostVM.canCommentAudienceBottomSheet.toggle()
                    }
                }
            )
    }
    func onChanged(value: DragGesture.Value){
        if value.translation.height > 0{
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value){
        if value.translation.height > 0{
            withAnimation(Animation.easeInOut(duration: 0.2)){
                
                //onChecking
                
                let height = UIScreen.screenHeight/3
                
                if value.translation.height > height/1.5 {
                    createPostVM.canCommentAudienceBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct CommentAudienceBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentAudienceBottomSheet()
//    }
//}
