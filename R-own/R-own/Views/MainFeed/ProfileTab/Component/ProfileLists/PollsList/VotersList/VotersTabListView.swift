//
//  VotersTabListView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct VotersTabListView: View {
    
    @State var options: Option234
    @State var votesCount: Int = 13
    
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    var body: some View {
        VStack{
            ZStack{
                Divider()
                    .overlay{
                        HStack{
                            HStack{
                                Text(options.option)
                                    .font(.body)
                                    .fontWeight(.regular)
                                Text("\(options.votes.count) votes")
                                    .font(.body)
                                    .fontWeight(.light)
                            }
                            .background(.white)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            Spacer()
                        }
                    }
                
            }
            if options.votes.count > 0 {
                ForEach(0..<options.votes.count, id: \.self){ count in
                    VotersListTabsView(voters: options.votes[count], loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM)
                }
            } else {
                HStack{
                    Text("No Voters Yet!")
                        .font(.body)
                        .padding(.vertical, UIScreen.screenHeight/80)
                    Spacer()
                }
                .padding(.horizontal, UIScreen.screenWidth/30)
            }
        }
        .padding(.top, UIScreen.screenHeight/60)
    }
}

//struct VotersTabListView_Previews: PreviewProvider {
//    static var previews: some View {
//        VotersTabListView()
//    }
//}
