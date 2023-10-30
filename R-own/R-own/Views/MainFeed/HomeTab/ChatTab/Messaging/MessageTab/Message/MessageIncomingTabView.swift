//
//  MessageIncomingTabView.swift
//  R-own
//
//  Created by Aman Sharma on 23/04/23.
//

import SwiftUI
import mesibo

struct MessageIncomingTabView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    @State var messageStatus = "read"
    @State var message: MesiboMessage
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading, spacing: 0){
                    if message.isGroupMessage(){
                        HStack{
                            Text(message.profile?.getName() ?? "group member")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .padding(.top, UIScreen.screenHeight/80)
                                .padding(.horizontal, UIScreen.screenWidth/40)
                            
                            Spacer()
                        }
                    }
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
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                }
                .frame(minWidth: UIScreen.screenWidth/7, maxWidth: UIScreen.screenWidth/1.8)
                .background(.white)
                .cornerRadius(10, corners: .bottomRight)
                .cornerRadius(10, corners: .topLeft)
                .cornerRadius(10, corners: .topRight)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                
                
                Spacer()
            }
        }
    }
}

//struct MessageIncomingTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageIncomingTabView()
//    }
//}
