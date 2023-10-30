//
//  PollsListView.swift
//  R-own
//
//  Created by Aman Sharma on 16/05/23.
//

import SwiftUI

struct PollsProfileListView: View {
    var body: some View {
        ScrollView{
            VStack{
                ForEach(1...5, id: \.self){ _ in
//                    PollsTabView()
                }
            }
        }
    }
}

//struct PollsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PollsListView()
//    }
//}
