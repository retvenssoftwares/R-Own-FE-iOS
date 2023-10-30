//
//  HotelProfileListView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct HotelProfileListView: View {
    
    @State var mainUser: Bool
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(1...15, id: \.self){ _ in
//                    HotelProfilePostView(mainUser: mainUser)
                }
            }
        }
    }
}

//struct HotelProfileListView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelProfileListView()
//    }
//}
