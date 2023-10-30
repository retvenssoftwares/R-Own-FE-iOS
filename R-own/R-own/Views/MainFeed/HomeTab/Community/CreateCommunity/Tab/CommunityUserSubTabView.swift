//
//  CommunityUserSubTabView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI

struct CommunityUserSubTabView: View {
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    @State var user: Conn334
    @State var memberSelected: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                ProfilePictureView(profilePic: user.profilePic, verified: user.verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                    .padding(.horizontal, UIScreen.screenWidth/50)
                VStack(alignment: .leading){
                    Text(user.fullName)
                        .font(.body)
                        .fontWeight(.bold)
                    Text(user.role)
                        .font(.footnote)
                        .fontWeight(.thin)
                }
                Spacer()
                if memberSelected {
                    Image("JobActivityDone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/40)
            .padding(.vertical, UIScreen.screenHeight/90)
            .background(communityGreyBG)
            .cornerRadius(5)
            .padding(.vertical, UIScreen.screenHeight/130)
            .padding(.horizontal, UIScreen.screenWidth/40)
            .onTapGesture {
                if memberSelected {
                    memberSelected = false
                    communityVM.selectedGroupMember.remove(object: user)
                } else{
                    memberSelected = true
                    communityVM.selectedGroupMember.append(user)
                }
                print(communityVM.selectedGroupMember)
            }
        }
    }
}

