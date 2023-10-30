//
//  EventFPPFirstHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct EventFPPFirstHalfView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var eventVM: EventViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Welcome, \(loginData.mainUserFullName)!")
                    .font(.system(size: UIScreen.screenHeight/50))
                    .fontWeight(.thin)
                
                Spacer()
                
                Button(action: {
                    eventVM.showEventLocationBottomSheet.toggle()
                }, label: {
                    HStack{
                        Image("LocationIconWhite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                        Text("Indore")
                            .font(.system(size: UIScreen.screenHeight/100))
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                    }
                    .padding(10)
                    .background(.black)
                    .cornerRadius(5)
                })
            }
            .padding(.vertical, UIScreen.screenHeight/50)
            
            HStack{
                Text("Let’s discover an event.")
                    .font(.system(size: UIScreen.screenHeight/40))
                    .fontWeight(.bold)
                    .padding(.vertical, UIScreen.screenHeight/50)
                Spacer()
            }
        }
        .padding(.horizontal, UIScreen.screenWidth/40)
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/4)
        
    }
}

//struct EventFPPFirstHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventFPPFirstHalfView()
//    }
//}
