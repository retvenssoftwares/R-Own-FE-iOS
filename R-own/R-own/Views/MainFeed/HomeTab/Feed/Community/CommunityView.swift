//
//  CommunityView.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import SwiftUI

struct CommunityView: View {
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true, content: {
            HStack{
                CreateCommunityView(communityVM: communityVM, mesiboVM: mesiboVM, loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                if globalVM.ownCommunityModelList.count > 0 {
                    ForEach(0..<(globalVM.ownCommunityModelList.count < 8 ? globalVM.ownCommunityModelList.count : 8), id: \.self){ count in
                        CommunityCardView(community: globalVM.ownCommunityModelList[count], loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, globalVM: globalVM, profileVM: profileVM)
                    }
                }
                if globalVM.ownCommunityModelList.count > 5 {
                    ViewAllCommunityCardView(loginData: loginData, globalVM: globalVM, communityVM: communityVM, mesiboVM: mesiboVM, profileVM: profileVM)
                }
            }
            .padding(.bottom, UIScreen.screenHeight/70)
            .padding(.leading, UIScreen.screenWidth/30)
            .padding(.trailing, 10)
        })
    }
}

//struct CommunityView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityView()
//    }
//}
