//
//  MessageOutgoingTabView.swift
//  R-own
//
//  Created by Aman Sharma on 23/04/23.
//

import SwiftUI
import mesibo

struct MessageOutgoingTabView: View {
    
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    @State var messageStatus = "notSent"
    @State var message: MesiboMessage
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                
                VStack(alignment: .leading, spacing: 0){
                    HStack{
                        Text(message.message ?? "")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                            .padding(.vertical, UIScreen.screenHeight/80)
                            .padding(.horizontal, UIScreen.screenWidth/40)
                        
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Text(convertTo12HourClock(message.getTimestamp().getTime(true))!)
                            .font(.footnote)
                        
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
                .frame(maxWidth: UIScreen.screenWidth/1.8)
                .background(chatLightGreenColorUI)
                .cornerRadius(10, corners: .bottomLeft)
                .cornerRadius(10, corners: .topLeft)
                .cornerRadius(10, corners: .topRight)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
            }
        }
    }
}

//struct MessageOutgoingTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageOutgoingTabView()
//    }
//}
