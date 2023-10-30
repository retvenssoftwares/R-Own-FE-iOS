//
//  FAQsView.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI

struct FAQsView: View {
    
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var faqService = FAQService()
    @State var isLoading: Bool = false
    
    var body: some View {
            VStack{
                //Nav
                BasicNavbarView(navbarTitle: "What people generally ask us")
                //QnA View
                if isLoading {
                    VStack {
                        ScrollView{
                            ForEach(0..<globalVM.faqList.count, id: \.self){ count in
                                FAQsTabView(faq: globalVM.faqList[count], showAnswer: count == 0 ? true : false)
                                    .padding(.vertical, UIScreen.screenHeight/40)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                            }
                        }
                        Spacer()
                    }
                } else {
                    ProgressView()
                }
            }
            .onAppear{
                isLoading = false
                Task {
                    let res = await faqService.getFAQList(globalVM: globalVM)
                    if res == "Success"{
                        isLoading = true
                    } else {
                        isLoading = false
                    }
                }
            }
        .navigationBarBackButtonHidden()
    }
}

//struct FAQsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FAQsView()
//    }
//}
