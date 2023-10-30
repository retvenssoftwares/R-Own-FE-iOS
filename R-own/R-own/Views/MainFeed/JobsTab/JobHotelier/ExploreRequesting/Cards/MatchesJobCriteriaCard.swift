//
//  MatchesJobCriteriaCard.swift
//  R-own
//
//  Created by Aman Sharma on 09/06/23.
//

import SwiftUI

struct MatchesJobCriteriaCard: View {
    
    @State var jobProfile: RequestedUsersModel
    
    var body: some View {
        VStack{
            HStack{
                ProfilePictureView(profilePic: jobProfile.profilePic ?? "", verified: false, height: UIScreen.screenHeight/25, width: UIScreen.screenHeight/25)
                VStack(alignment: .leading){
                    Text(jobProfile.fullName ?? "Fetching Name")
                        .font(.system(size: UIScreen.screenHeight/70))
                        .fontWeight(.bold)
                    Text("\(jobProfile.designationType) . exp . \(jobProfile.location ?? jobProfile.preferredLocation)")
                        .font(.system(size: UIScreen.screenHeight/100))
                        .fontWeight(.thin)
                }
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("View")
                        .font(.system(size: UIScreen.screenHeight/100))
                        .fontWeight(.thin)
                        .padding(.horizontal, UIScreen.screenWidth/30)
                        .padding(.vertical, UIScreen.screenHeight/80)
                        .background(jobsBrightGreen)
                        .shadow(radius: 5)
                        .padding(5)
                })
            }
        }
    }
}

//struct MatchesJobCriteriaCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MatchesJobCriteriaCard()
//    }
//}
