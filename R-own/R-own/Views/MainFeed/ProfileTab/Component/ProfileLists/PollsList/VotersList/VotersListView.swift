//
//  VotersListView.swift
//  R-own
//
//  Created by Aman Sharma on 16/05/23.
//

import SwiftUI

struct VotersListView: View {
    
    @StateObject var profileService = ProfileService()
    @State var post: Post434
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    var body: some View {
        NavigationStack{
            BasicNavbarView(navbarTitle: "Voters")
            ScrollView{
                VStack{
                    if globalVM.getPollVotes.count > 0 {
                        if globalVM.getPollVotes[0].options.count > 0 {
                            ForEach(0..<post.pollQuestion[0].options.count, id: \.self){ count in
                                VotersTabListView(options: globalVM.getPollVotes[0].options[count], loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM)
                            }
                        }
                    }
                }
                .onAppear {
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
 
//struct VotersListView_Previews: PreviewProvider {
//    static var previews: some View {
//        VotersListView()
//    }
//}
