//
//  GroupUserDetailView.swift
//  R-own
//
//  Created by Aman Sharma on 25/07/23.
//

import SwiftUI

struct GroupUserDetailListView: View {
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var communityVM: CommunityViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @State var totalUsers: [MesiboGroupUser]
    
    @State var adminStatus: Bool
    @State var memberStatus: Bool
    
    @State var selectedUserNav: String
    
    
    var body: some View {
        NavigationStack{
            VStack{
                //Nav
                VStack{
                    HStack{
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "arrow.left.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                .foregroundColor(greenUi)
                                .padding(.horizontal, UIScreen.screenWidth/50)
                                .padding(.vertical, 10)
                        })
                        
                        Spacer()
                        
                        Text(selectedUserNav)
                            .font(.body)
                            .foregroundColor(greenUi)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                    }
                    .padding(.vertical, UIScreen.screenHeight/40)
                    .frame(width: UIScreen.screenWidth)
                    .background(jobsDarkBlue)
                }
                ScrollView{
                    VStack(alignment: .leading, spacing: UIScreen.screenHeight/60){
                        ForEach(0..<totalUsers.count, id: \.self){ count in
                            GroupMembersCardView(communityVM: communityVM, user: totalUsers[count], loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, adminStatus: adminStatus, memberStatus: memberStatus)
                        }
                    }
                }
            }
        }
        .onAppear{
        }
        .navigationBarBackButtonHidden()
    }
}

//struct GroupUserDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupUserDetailView()
//    }
//}
