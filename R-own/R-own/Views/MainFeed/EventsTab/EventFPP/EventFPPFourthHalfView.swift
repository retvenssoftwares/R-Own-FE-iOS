//
//  EventFPPFourthHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct EventFPPFourthHalfView: View {
    
    @State var navigateToEventsCategoryView: Bool = false
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Text("Category")
                        .font(.system(size: UIScreen.screenHeight/50))
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        navigateToEventsCategoryView.toggle()
                    }, label: {
                        Text("See All")
                            .font(.system(size: UIScreen.screenHeight/80))
                            .foregroundColor(.black)
                    })
                    .navigationDestination(isPresented: $navigateToEventsCategoryView, destination: {
                        EventCategoryListView(loginData: loginData, globalVM: globalVM)
                    })
                }
                .padding(.trailing, UIScreen.screenWidth/20)
                if globalVM.eventCategoryList.count > 0 {
                    ForEach(0..<globalVM.eventCategoryList.count, id: \.self){ count in
                        EventCategoryTabView( loginData: loginData, globalVM: globalVM, event: globalVM.eventCategoryList[count])
                    }
                }
            }
        }
    }
}

//struct EventFPPFourthHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventFPPFourthHalfView()
//    }
//}
