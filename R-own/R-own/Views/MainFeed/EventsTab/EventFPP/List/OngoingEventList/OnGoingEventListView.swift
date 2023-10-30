//
//  OnGoingEventListView.swift
//  R-own
//
//  Created by Aman Sharma on 19/05/23.
//

import SwiftUI

struct OnGoingEventListView: View {
    
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    
    var body: some View {
        VStack{
            VStack{
                BasicNavbarView(navbarTitle: "Ongoing Events")
                VStack {
                    ScrollView{
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
        .navigationBarBackButtonHidden()
    }
}

//struct OnGoingEventListView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnGoingEventListView()
//    }
//}
