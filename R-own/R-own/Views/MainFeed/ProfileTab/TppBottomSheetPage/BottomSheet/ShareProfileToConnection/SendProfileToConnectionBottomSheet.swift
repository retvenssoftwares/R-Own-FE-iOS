//
//  SendProfileToConnectionBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 03/07/23.
//

import SwiftUI

struct SendProfileToConnectionBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var userRole: String
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var encodedString: String = ""
    @State var connectionSearch: String = ""
    
    @State var isLoading: Bool = false
    
    @StateObject var mesiboVM = MesiboViewModel()
    
    @StateObject var profileService = ProfileService()
    
    @State var sentStatus: Bool = false
    
    var filteredConnections: [Conn334] {
        connectionSearch.isEmpty ? globalVM.getConnectionList[0].conns : globalVM.getConnectionList[0].conns.filter { $0.fullName.localizedCaseInsensitiveContains(connectionSearch) }
    }
    
    var body: some View {
        VStack{
            VStack(spacing: 20){
                Text("Share with your connections")
                    .foregroundColor(.black)
                    .font(.system(size: UIScreen.screenHeight/40))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top,30)
                
                TextField("Search connections Profile", text: $connectionSearch)
                    .font(.system(size: 14))
                    .frame(width: UIScreen.screenWidth/1.2)
                    .overlay(alignment: .trailing, content: {
                        Image(systemName: "magnifyingglass")
                    })
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
                    .padding()
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 0.8)
                            .foregroundColor(lightGreyUi)
                    }
                
                
                //Location Array
                if isLoading{
                    if globalVM.getConnectionList.count > 0{
                        if globalVM.getConnectionList[0].conns.count > 0{
                            ScrollView{
                                VStack(alignment: .leading){
                                    ForEach(0..<filteredConnections.count, id: \.self) {count in
                                        ShareProfileToConnectionTab(loginData: loginData, globalVM: globalVM, userRole: userRole, profileConnection: filteredConnections[count])
                                    }
                                }
                            }
                        } else {
                            Text("Oops, You dont have any connection to show yet!")
                        }
                        Spacer()
                    } else {
                        Text("Error occured, please try again")
                    }
                } else {
                    ProgressView()
                }
                
            }
            .onAppear{
                isLoading = false
                Task{
                    let res = await profileService.getConnectionsList(globalVM: globalVM, userID: loginData.mainUserID)
                    if res == "Success"{
                        isLoading = true
                    } else {
                        isLoading = true
                    }
                }
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
    }
    
}

//struct SendProfileToConnectionBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        SendProfileToConnectionBottomSheet()
//    }
//}
