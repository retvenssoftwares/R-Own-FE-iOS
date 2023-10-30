//
//  EventFPPSecondHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct EventFPPSecondHalfView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var eventVM: EventViewModel
    @StateObject var globalVM: GlobalViewModel
    
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        VStack{
            //Search Field
            TextField("Art exhibition, concerts, Open mics...", text: $eventVM.eventSearchText)
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
            //Filter
            HStack{
                //Filter Tabs
                ScrollView(.horizontal){
                    HStack{
                        //Tabs
                        if globalVM.eventCategoryList.count > 0 {
                            ForEach(1..<globalVM.eventCategoryList.count, id: \.self) { count in
                                //Card
                                EventQuickFilterCategoryCard(categoryName: globalVM.eventCategoryList[count].categoryName, selected: $eventVM.selectedEventCategoryFilter)
                                    .padding(.vertical, UIScreen.screenHeight/50)
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct EventFPPSecondHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventFPPSecondHalfView()
//    }
//}
