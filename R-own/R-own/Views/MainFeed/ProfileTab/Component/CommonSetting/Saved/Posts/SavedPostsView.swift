//
//  SavedPostsView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct SavedPostsView: View {
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    var body: some View {
        ScrollView{
            VStack{
                SavedPostListView(globalVM: globalVM, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM)
            }
        }
    }
}

//struct SavedPostsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedPostsView()
//    }
//}
