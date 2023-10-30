//
//  EventProfileListView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct EventProfileListView: View {
    
    @State var mainUser: Bool
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(1...5, id: \.self){ _ in
//                    EventProfilePostView(mainUser: mainUser)
                }
            }
        }
    }
}

//struct EventProfileListView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventProfileListView()
//    }
//}
