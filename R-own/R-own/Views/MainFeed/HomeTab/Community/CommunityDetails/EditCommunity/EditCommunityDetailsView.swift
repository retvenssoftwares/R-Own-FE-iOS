//
//  EditCommunityDetailsView.swift
//  R-own
//
//  Created by Aman Sharma on 23/05/23.
//

import SwiftUI

struct EditCommunityDetailsView: View {
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Create Community")
                VStack{
                    Text("Edit community details")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(greenUi)
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/40)
                        .background(jobsDarkBlue)
                        .border(width: 1, edges: [.bottom], color: greenUi)
                    
                }
            }
        }
    }
}

//struct EditCommunityDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditCommunityDetailsView()
//    }
//}
