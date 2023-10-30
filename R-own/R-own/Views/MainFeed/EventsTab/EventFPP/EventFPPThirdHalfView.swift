//
//  EventFPPThirdHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct EventFPPThirdHalfView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var eventVM: EventViewModel
    @StateObject var globalVM: GlobalViewModel
    
    
    @State var navigateToNearestConcertAllView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Text("Nearest Concert")
                        .font(.system(size: UIScreen.screenHeight/50))
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        navigateToNearestConcertAllView.toggle()
                    }, label: {
                        Text("See All")
                            .font(.system(size: UIScreen.screenHeight/80))
                            .foregroundColor(.black)
                    })
                    .navigationDestination(isPresented: $navigateToNearestConcertAllView, destination: {
                        NearestConcertListView(loginData: loginData, globalVM: globalVM)
                    })
                }
                .padding(.trailing, UIScreen.screenWidth/20)
                
                ScrollView(.horizontal){
                    //Tabs
                    HStack {
                        if globalVM.nearestConcertList.count > 0 {
                            ForEach(0..<globalVM.nearestConcertList.count, id: \.self) { count in
                                NearestConcertCard(loginData: loginData, globalVM: globalVM, event: globalVM.nearestConcertList[count])
                                    .padding(.vertical, UIScreen.screenHeight/60)
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct EventFPPThirdHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventFPPThirdHalfView()
//    }
//}
