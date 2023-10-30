//
//  LanguageViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//

import Foundation
import SwiftUI

class LanguageViewModel: ObservableObject{
    @Published var languages = [
        Language(langName:"Arabic" , langCode:"ar", langImgW: "LangArabic-w", langImgG: "LangArabic-g"),
        Language(langName:"English" , langCode:"en", langImgW: "LangEnglish-w", langImgG: "LangEnglish-g"),
        Language(langName:"Hindi" , langCode:"hi", langImgW: "LangHindi-w", langImgG: "LangHindi-g"),
        Language(langName:"Spanish" , langCode:"es", langImgW: "LangSpanish-w", langImgG: "LangSpanish-g"),
        Language(langName:"German" , langCode:"de", langImgW: "LangGerman-w", langImgG: "LangGerman-g"),
        Language(langName:"Japanese" , langCode:"ja", langImgW: "LangJapanese-w", langImgG: "LangJapanese-g"),
        Language(langName:"Portuguese" , langCode:"pt-PT", langImgW: "LangPortuguese-w", langImgG: "LangPortuguese-g"),
        Language(langName:"Italian" , langCode:"it", langImgW: "LangItalian-w", langImgG: "LangItalian-g"),
        Language(langName:"French" , langCode:"fr", langImgW: "LangFrench-w", langImgG: "LangFrench-g"),
        Language(langName:"Russian" , langCode:"ru", langImgW: "LangRussian-w", langImgG: "LangRussian-g"),
        Language(langName:"Chinese" , langCode:"zh-Hans", langImgW: "LangChinese-w", langImgG: "LangChinese-g")
    ]
    
    @Published var showLangBottomSheet = false
    @Published var currentLanguage: String = "en"
    
}
