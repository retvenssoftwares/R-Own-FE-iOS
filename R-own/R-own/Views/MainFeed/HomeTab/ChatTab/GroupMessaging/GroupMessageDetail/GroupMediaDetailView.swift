//
//  GroupMediaDetailView.swift
//  R-own
//
//  Created by Aman Sharma on 27/06/23.
//

import SwiftUI
import Shimmer

struct GroupMediaDetailView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack{
            VStack{
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach( mesiboVM.messageList, id: \.id){ meess in
                        if meess.mMessage.isImage(){
                            GroupMediaDetailViewImageTab(message: meess.mMessage)
                        }
                    }
                }
            }
        }
    }
}

//struct GroupMediaDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupMediaDetailView()
//    }
//}
