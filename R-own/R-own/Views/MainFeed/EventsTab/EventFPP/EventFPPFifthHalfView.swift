//
//  EventFPPFifthHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct EventFPPFifthHalfView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    
    @State var navigateToOnGoingView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Text("On Going")
                        .font(.system(size: UIScreen.screenHeight/50))
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        navigateToOnGoingView.toggle()
                    }, label: {
                        Text("See All")
                            .font(.system(size: UIScreen.screenHeight/80))
                            .foregroundColor(.black)
                    })
                    .navigationDestination(isPresented: $navigateToOnGoingView, destination: {
                        OnGoingEventListView(globalVM: globalVM, loginData: loginData)
                    })
                }
                .padding(.trailing, UIScreen.screenWidth/20)
                if globalVM.ongoingEventList.count > 0 {
                    ForEach(0..<globalVM.ongoingEventList.count, id: \.self){ count in
                        OnGoingTabView(event: globalVM.ongoingEventList[count], loginData: loginData, globalVM: globalVM)
                    }
                } else {
                    Text("Nothing is going on right now!")
                }
            }
        }
    }
}

//struct EventFPPFifthHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventFPPFifthHalfView()
//    }
//}
