//
//  InterestSearchView.swift
//  R-own
//
//  Created by Aman Sharma on 09/04/23.
//

import SwiftUI
import AlertToast

struct InterestSearchView: View {
    
    @ObservedObject var interestData = InterestViewModel()
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var userVM = UserViewModel()
    @State var interestSearchText = ""
    
    @FocusState private var isKeyboardShowing: Bool
    @State var alertNoInterest: Bool = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    TextField("What are you into?", text: $interestSearchText)
                        .font(.body)
                        .padding(.leading, UIScreen.screenWidth/40)
                        .frame(width: UIScreen.screenWidth/1.7)
                        .overlay(alignment: .trailing, content: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(lightGreyUi)
                        })
                        .padding(.vertical, UIScreen.screenHeight/90)
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                .cornerRadius(15, corners: .allCorners)
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color(UIColor.systemGray4), lineWidth: 2)
                        .frame(width: UIScreen.screenWidth/1.7, height: 25)
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
                
                TagsView(items: loginData.interestList, searchText: interestSearchText, loginData: loginData)
                    .padding(.horizontal, UIScreen.screenWidth/20)
//                LazyVGrid(columns: columns, spacing: 5){
//                    ForEach(loginData.interestList.filter({ "\($0.name)".contains(searchText) || searchText.isEmpty})) { Interest in
//                        InterestTabView(interestName: Interest.name, interest: Interest, loginData: loginData)
//                    }
//                }
//                .padding(.horizontal, 20)
                Spacer()
                HStack(spacing: UIScreen.screenWidth/20){
                    
                        Button(action: {
                            print("Starting to upload interest data to server")
                            loginData.interestSelected = true
                        }, label: {
                            Text("Skip")
                                .foregroundColor(greenUi)
                                .font(.body)
                                .fontWeight(.light)
                                .padding(.vertical, 10)
                                .padding(.horizontal, UIScreen.screenWidth/15)
                                .background(jobsDarkBlue)
                                .cornerRadius(10, corners: .allCorners)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                .padding(.bottom, 20)
                        })
                    
                        Button(action: {
                            if loginData.selectedInterestList.isEmpty {
                                alertNoInterest.toggle()
                                print("interest list is empty")
                                print(loginData.interestSelected)
                            }else {
                                
                                print("Starting to upload interest data to server")
                                loginData.showLoader = true
                                userVM.updateInterestDataToServer(loginData: loginData)
                                loginData.interestSelected = true
                            }
                        }, label: {
                            Text("Continue")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.light)
                                .padding(.vertical, 10)
                                .padding(.horizontal, UIScreen.screenWidth/15)
                                .background(greenUi)
                                .cornerRadius(10, corners: .allCorners)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                .padding(.bottom, 20)
                        })
                        .navigationDestination(isPresented: $loginData.interestSelected, destination: {
                            SyncContactsView(loginData: loginData, globalVM: globalVM)
                        })
                }
            }
            
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .toast(isPresenting: $alertNoInterest, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "No Interest Selected", subTitle: ("Select your interest to proceed"))
        }
    }
    
}

//struct InterestSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        InterestSearchView()
//    }
//}



struct TagsView: View {
    
    var loginData: LoginViewModel
    let items: [GetInterest]
    var searchText: String
    var groupedItems: [[GetInterest]] = [[GetInterest]]()
    let screenWidth = UIScreen.main.bounds.width
    
    init(items: [GetInterest], searchText: String, loginData: LoginViewModel) {
        self.items = items
        self.searchText = searchText
        self.loginData = loginData
        self.groupedItems = createGroupedItems(items)
    }
    
    private func createGroupedItems(_ items: [GetInterest]) -> [[GetInterest]] {
        
        var groupedItems: [[GetInterest]] = [[GetInterest]]()
        var tempItems: [GetInterest] =  [GetInterest]()
        var width: CGFloat = 0
        
        for word in items {
            
            let label = UILabel()
            label.text = word.name
            label.sizeToFit()
            
            let labelWidth = label.frame.size.width + UIScreen.screenWidth/25
            
            if (width + labelWidth + UIScreen.screenWidth/25) < screenWidth {
                width += labelWidth
                tempItems.append(word)
            } else {
                width = labelWidth
                groupedItems.append(tempItems)
                tempItems.removeAll()
                tempItems.append(word)
            }
            
        }
        
        groupedItems.append(tempItems)
        return groupedItems
        
    }
    
    var body: some View {
        VStack{
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(groupedItems, id: \.self) { subItems in
                        HStack {
                            ForEach(subItems.filter({ "\($0.name.lowercased())".contains(searchText.lowercased()) || searchText.isEmpty})) { interest in
                                InterestTabView(interestName: interest.name, interest: interest, loginData: loginData)
                                    .padding(.top, 4)
                            }
                        }
                        .frame(width: UIScreen.screenWidth/1.4)
                    }
                    
                    Spacer()
                }
            }
        }
        .frame(width: UIScreen.screenWidth/1.4)
    }
    
}
