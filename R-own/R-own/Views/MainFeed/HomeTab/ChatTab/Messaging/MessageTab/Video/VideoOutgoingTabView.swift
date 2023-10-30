//
//  VideoOutgoingTabView.swift
//  R-own
//
//  Created by Aman Sharma on 30/06/23.
//

import SwiftUI
import mesibo

struct VideoOutgoingTabView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    @State var messageStatus = "read"
    @State var message: MesiboMessage
    
    @State var openVideoPreviewChat: Bool = false
    
    var body: some View {
        NavigationStack{
            NavigationLink(destination: {
                VideoPreviewTab(videoURL: message.getFile()?.url ?? "")
            }, label: {
                
                VStack(alignment: .leading){
                    HStack{
                        Spacer(minLength: UIScreen.screenWidth/3)
                        VStack(alignment: .leading, spacing: 0){
                            
                            Image( uiImage: message.getThumbnail()!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.screenWidth/1.9)
                                .clipped()
                                .padding()
                                .overlay{
                                    Image(systemName: "play.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                }
                            
                            if message.message != nil {
                                if message.message ?? "" != "" {
                                    HStack{
                                        Text(message.message ?? "")
                                            .font(.body)
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.black)
                                            .padding(.vertical, UIScreen.screenHeight/100)
                                            .padding(.horizontal, UIScreen.screenWidth/35)
                                    }
                                }
                            }
                            
                            HStack{
                                Spacer()
                                Text(convertTo12HourClock(message.getTimestamp().getTime(true))!)
                                    .font(.footnote)
                                    .foregroundColor(.black)
                                
                                if message.status == 3{
                                    Image("MessageSeenTick")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: UIScreen.screenHeight/90)
                                } else if message.status == 2{
                                    Image("MessageDoubleTick")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: UIScreen.screenHeight/90)
                                } else if message.status == 1{
                                    Image("MessageSingleTick")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: UIScreen.screenHeight/90)
                                } else {
                                    Image("MessageNotSentTick")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: UIScreen.screenHeight/90)
                                }
                            }
                            .padding(.horizontal, UIScreen.screenWidth/40)
                        }
                        .padding()
                        .frame(width: UIScreen.screenWidth/1.7)
                        .background(chatLightGreenColorUI)
                        .cornerRadius(10, corners: .bottomLeft)
                        .cornerRadius(10, corners: .topLeft)
                        .cornerRadius(10, corners: .topRight)
                        .shadow(color: .black.opacity(0.3), radius: 4, x: 3, y: 4)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                    }
                }
            })
        }
    }
}

//struct VideoOutgoingTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoOutgoingTabView()
//    }
//}
