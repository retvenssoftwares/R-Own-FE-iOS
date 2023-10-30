//
//  EditFPPProfileNavView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI

struct EditFPPProfileNavView: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "arrow.backward.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                
                Spacer()
                
                Text("Edit Your Profile")
                    .font(.body)
                    .fontWeight(.bold)
                Spacer()
            }
            Divider()
        }
    }
}

//struct EditFPPProfileNavView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditFPPProfileNavView()
//    }
//}
