//
//  DeletedIncomingMessageTab.swift
//  R-own
//
//  Created by Aman Sharma on 19/07/23.
//

import SwiftUI
import mesibo

struct DeletedIncomingMessageTab: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    @State var message: MesiboMessage
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading, spacing: 0){
                        if message.isGroupMessage(){
                            Text(message.profile?.getName() ?? "group member")
                                .font(.footnote)
                        }
                            HStack{
                                Text("This message was deleted.")
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 10)
                                Spacer()
                            }
                        
                        HStack{
                            Spacer()
                            Text(message.getTimestamp().getTime(true))
                                .font(.footnote)
                            
                        }
                        .padding(.horizontal, UIScreen.screenWidth/40)
                    }
                    .padding()
                    .frame(width: UIScreen.screenWidth/2.2)
                    .background(.white)
                    .cornerRadius(10, corners: .bottomRight)
                    .cornerRadius(10, corners: .topLeft)
                    .cornerRadius(10, corners: .topRight)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    
                    Spacer(minLength: UIScreen.screenWidth/3)
                }
            }
        }
    }
    
}

//struct DeletedIncomingMessageTab_Previews: PreviewProvider {
//    static var previews: some View {
//        DeletedIncomingMessageTab()
//    }
//}
