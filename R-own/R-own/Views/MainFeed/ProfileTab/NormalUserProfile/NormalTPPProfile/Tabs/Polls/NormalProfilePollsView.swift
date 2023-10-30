//
//  NormalProfilePollsView.swift
//  R-own
//
//  Created by Aman Sharma on 12/05/23.
//

import SwiftUI

struct NormalProfilePollsView: View {
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text("2 Weeks ago")
            Text("When Travelling, what do you guys prefer more ?")
            ForEach(1...4, id: \.self){_ in
                NormalProfilePollsTabStructView()
            }
            HStack{
                Text("dobrev_karsten")
                    .font(.body)
                    .fontWeight(.bold)
                Text("Are you guys more comfortable in staying in a good comfy hostel or a magnificent luxury stays..?")
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

//struct NormalProfilePollsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfilePollsView()
//    }
//}
