//
//  DiscardPostBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI

struct DiscardPostBottomSheet: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    
    @State var hotelSearch: String = ""
        
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
                            Text("Going Back ?")
                                .font(.body)
                                .fontWeight(.bold)
                                .padding(.vertical, UIScreen.screenHeight/60)
                            VStack(alignment: .leading){
                                HStack{
                                    Image("PostDiscardEditing")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                    Text("Keep editing")
                                        .font(.body)
                                        .fontWeight(.bold)
                                }
                                Text("Keep editing and proceed with sharing with your community")
                                    .font(.body)
                                    .fontWeight(.thin)
                            }
                            Divider()
                            
                            VStack(alignment: .leading){
                                HStack{
                                    Image("PostDiscardIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                    Text("Discard")
                                        .font(.body)
                                        .fontWeight(.bold)
                                }
                                Text("Media is not saved, you will loose all the progress and you will have to start again.")
                                    .font(.body)
                                    .fontWeight(.thin)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/2.6)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: createPostVM.canSeeAudienceBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(createPostVM.canSeeAudienceBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        createPostVM.canSeeAudienceBottomSheet.toggle()
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
                    createPostVM.canSeeAudienceBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct DiscardPostBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        DiscardPostBottomSheet()
//    }
//}
