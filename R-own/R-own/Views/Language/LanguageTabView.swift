//
//  LanguageTabView.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//

import SwiftUI

struct LanguageTabView: View {
    
    @State var language: Language
    
    @AppStorage("lang_selected") var langSelected: String = "en"
    
    var body: some View {
        
        HStack(spacing: 15){
            
            VStack{
                
                Text(language.langName)
                    .font(.body)
            }
            
            Spacer()
            if langSelected == language.langCode{
                
                Image(language.langImgG)
                    .resizable()
    //                .renderingMode(.template)
    //                .foregroundColor(color)
                    .frame(width: UIScreen.screenWidth/2.5, height: 45)
            }else{
                
                Image(language.langImgW)
                    .resizable()
    //                .renderingMode(.template)
    //                .foregroundColor(color)
                    .frame(width: UIScreen.screenWidth/2.5, height: 45)
            }
        }
        .padding(.leading, 10)
        .padding(.trailing)
        .padding(.vertical)
        
    }
}

//struct LanguageTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        LanguageTabView()
//    }
//}
