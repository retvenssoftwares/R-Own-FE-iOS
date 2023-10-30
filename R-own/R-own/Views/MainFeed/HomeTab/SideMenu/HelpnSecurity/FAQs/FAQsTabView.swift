//
//  FAQsTabView.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI

struct FAQsTabView: View {
    
    @State var faq: FAQModel
    @State var showAnswer: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Button(action: {
                showAnswer.toggle()
            }, label: {
                Text(faq.question)
                    .font(.body)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .frame(width: UIScreen.screenWidth/1.1)
                    .background(.white)
                    .cornerRadius(5)
                    .multilineTextAlignment(.leading)
                    .border(width: 1, edges: [.bottom], color: .black)
            })
                
            
            if showAnswer{
                Text(faq.answer)
                    .font(.body)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.leading)
                    .frame(width: UIScreen.screenWidth/1.1)
                    .padding(.horizontal, UIScreen.screenHeight/70)
                    .padding(.vertical, UIScreen.screenHeight/60)
                    .frame(width: UIScreen.screenWidth/1.1)
                    .background(communityTextGreyColorUI)
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
            }
        }
    }
}

//struct FAQsTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        FAQsTabView()
//    }
//}
