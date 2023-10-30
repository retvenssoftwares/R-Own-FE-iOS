//
//  ConnectionsListView.swift
//  R-own
//
//  Created by Aman Sharma on 16/05/23.
//

import SwiftUI

struct ConnectionsProfileListView: View {
    
    @State var connectionOwnerName: String
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var mainUser: Bool
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var profileService = ProfileService()
    
    @State private var filteredConns: [Conn334] = []
    
    @State private var isDataLoaded = false
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var searchConnection: String = ""
    
    
    var body: some View {
        VStack{
            if isDataLoaded {
                BasicNavbarView(navbarTitle: "\(connectionOwnerName) Connections")
                
                //SearchField
                
                VStack{
                    
                    TextField("Search", text: $searchConnection )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.default)
                        .padding()
                        .frame(width: UIScreen.screenWidth/1.2)
                        .cornerRadius(5)
                        .overlay{
                            Image("ExploreSearchIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                .offset(x: UIScreen.screenWidth/2.9)
                        }
                        .focused($isKeyboardShowing)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                
                                Button("Done") {
                                    
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                                }
                            }
                        }
                        .onChange(of: searchConnection) { newValue in
                            if newValue.isEmpty {
                                filteredConns = globalVM.getConnectionList[0].conns
                            } else {
                                filteredConns = globalVM.getConnectionList[0].conns.filter { conn in
                                    conn.fullName.localizedCaseInsensitiveContains(newValue)
                                }
                            }
                        }
                        .onAppear {
                            if globalVM.getConnectionList.count > 0 {
                                if globalVM.getConnectionList[0].conns.count > 0 {
                                    filteredConns = globalVM.getConnectionList[0].conns
                                } // Set the initial filteredConns to all connections
                            }
                        }
                    
                }
                ScrollView{
                    VStack{
                        if globalVM.getConnectionList.count > 0 {
                            if globalVM.getConnectionList[0].conns.count > 0 {
                                ForEach(0..<filteredConns.count, id: \.self){ id in
                                    ConnectionListTabView(connection: filteredConns[id], globalVM: globalVM, loginData: loginData, mainUser: mainUser, profileVM: profileVM, mesiboVM: mesiboVM)
                                    Divider()
                                }
                            }
                        } else {
                            Text("There are no connections to show")
                        }
                    }
                }
            } else {
                
                // Show a loading indicator while data is being fetched
                ProgressView("Loading...")
            }
                
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            makeAPICall(globalVM: globalVM, userID: loginData.mainUserID)
        }
    }
    
    func makeAPICall(globalVM: GlobalViewModel, userID: String){
        
            Task{
                let res = await profileService.getConnectionsList(globalVM: globalVM, userID: userID)
                if res == "Success" {
                    isDataLoaded = true
                } else {
                    makeAPICall(globalVM: globalVM, userID: userID)
                }
            }
    }
    
}

//struct ConnectionsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConnectionsListView()
//    }
//}
