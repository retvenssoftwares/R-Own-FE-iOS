//
//  OpenCommunityList.swift
//  R-own
//
//  Created by Aman Sharma on 12/07/23.
//

import SwiftUI

struct OpenCommunityList: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var communityVM: CommunityViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    @State var communities: [NewFeedCommunity]
    
    @State var navigateToViewAll: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Connect with the like-minded individuals")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        OpenCommunityListView(loginData: loginData, globalVM: globalVM, communityVM: communityVM, mesiboVM: mesiboVM, profileVM: profileVM)
                    }, label: {
                        HStack(spacing: 4){
                            Text("View All")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(greenUi)
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                                .foregroundColor(greenUi)
                        }
                    })
                }
                .padding(.leading, UIScreen.screenWidth/30)
                .padding(.trailing, UIScreen.screenWidth/30)
                .padding(.vertical, UIScreen.screenHeight/60)
                
                ScrollView(.horizontal, showsIndicators: true, content: {
                    HStack(spacing: 4){
                        if communities.count > 0 {
                            ForEach(0..<communities.count , id: \.self){ count in
                                OpenCommunityCardTab(community: communities[count], loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, globalVM: globalVM, profileVM: profileVM)
                            }
                        }
                    }
                    .padding(.vertical, UIScreen.screenHeight/80)
                    .padding(.trailing, 10)
                    .padding(.leading, UIScreen.screenWidth/30)
                })
            }
        }
    }
}

//struct OpenCommunityList_Previews: PreviewProvider {
//    static var previews: some View {
//        OpenCommunityList()
//    }
//}
