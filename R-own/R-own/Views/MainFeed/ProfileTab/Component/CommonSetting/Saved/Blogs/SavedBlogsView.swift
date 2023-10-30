//
//  SavedBlogsView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct SavedBlogsView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        VStack{
            SavedBlogsListView(loginData: loginData, globalVM: globalVM)
        }
    }
}

//struct SavedBlogsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedBlogsView()
//    }
//}
