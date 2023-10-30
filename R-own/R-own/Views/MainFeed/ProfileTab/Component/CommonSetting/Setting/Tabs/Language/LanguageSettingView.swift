//
//  LanguageSettingView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct LanguageSettingView: View {
    
    @State var languageSelected: String = "English"
    
    var body: some View {
        ScrollView {
            VStack{
                BasicNavbarView(navbarTitle: "Language")
                
                Text("In what language do you want to have your hospitality adventures?")
                    .font(.system(size: UIScreen.screenHeight/70))
                    .multilineTextAlignment(.leading)
                    .fontWeight(.bold)
                    .padding(.bottom, UIScreen.screenHeight/40)
                
                VStack{
                    HStack{
                        Text("Arabic")
                            .font(.system(size: UIScreen.screenHeight/70))
                            .fontWeight(.bold)
                        Image(languageSelected == "Arabic" ? "LangArabic-g" : "LangArabic-w")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/12)
                    }
                    .padding()
                    .background(.white)
                    .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/10)
                    .padding()
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .padding()
                    .onTapGesture {
                        languageSelected = "Arabic"
                    }
                    
                    HStack{
                        Text("English")
                            .font(.system(size: UIScreen.screenHeight/70))
                            .fontWeight(.bold)
                        Image(languageSelected == "English" ? "LangEnglish-g" : "LangEnglish-w")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/12)
                    }
                    .padding()
                    .background(.white)
                    .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/10)
                    .padding()
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .padding()
                    .onTapGesture {
                        languageSelected = "English"
                    }
                    
                    HStack{
                        Text("Hindi")
                            .font(.system(size: UIScreen.screenHeight/70))
                            .fontWeight(.bold)
                        Image(languageSelected == "Hindi" ? "LangHindi-g" : "LangHindi-w")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/12)
                    }
                    .padding()
                    .background(.white)
                    .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/10)
                    .padding()
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .padding()
                    .onTapGesture {
                        languageSelected = "Hindi"
                    }
                    
                    HStack{
                        Text("Spanish")
                            .font(.system(size: UIScreen.screenHeight/70))
                            .fontWeight(.bold)
                        Image(languageSelected == "Spanish" ? "LangSpanish-g" : "LangSpanish-w")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/12)
                    }
                    .padding()
                    .background(.white)
                    .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/10)
                    .padding()
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .padding()
                    .onTapGesture {
                        languageSelected = "Spanish"
                    }
                    
                    HStack{
                        Text("German")
                            .font(.system(size: UIScreen.screenHeight/70))
                            .fontWeight(.bold)
                        Image(languageSelected == "German" ? "LangGerman-g" : "LangGerman-w")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/12)
                    }
                    .padding()
                    .background(.white)
                    .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/10)
                    .padding()
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .padding()
                    .onTapGesture {
                        languageSelected = "German"
                    }
                    
                    HStack{
                        Text("Japanese")
                            .font(.system(size: UIScreen.screenHeight/70))
                            .fontWeight(.bold)
                        Image(languageSelected == "Japanese" ? "LangJapanese-g" : "LangJapanese-w")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/12)
                    }
                    .padding()
                    .background(.white)
                    .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/10)
                    .padding()
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .padding()
                    .onTapGesture {
                        languageSelected = "Japanese"
                    }
                    VStack{
                        
                        HStack{
                            Text("Portuguese")
                                .font(.system(size: UIScreen.screenHeight/70))
                                .fontWeight(.bold)
                            Image(languageSelected == "Portuguese" ? "LangPortuguese-g" : "LangPortuguese-w")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/12)
                        }
                        .padding()
                        .background(.white)
                        .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/10)
                        .padding()
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                        .padding()
                        .onTapGesture {
                            languageSelected = "Portuguese"
                        }
                        
                        HStack{
                            Text("Italian")
                                .font(.system(size: UIScreen.screenHeight/70))
                                .fontWeight(.bold)
                            Image(languageSelected == "Italian" ? "LangItalian-g" : "LangItalian-w")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/12)
                        }
                        .padding()
                        .background(.white)
                        .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/10)
                        .padding()
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                        .padding()
                        .onTapGesture {
                            languageSelected = "Italian"
                        }
                        
                        HStack{
                            Text("French")
                                .font(.system(size: UIScreen.screenHeight/70))
                                .fontWeight(.bold)
                            Image(languageSelected == "French" ? "LangFrench-g" : "LangFrench-w")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/12)
                        }
                        .padding()
                        .background(.white)
                        .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/10)
                        .padding()
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                        .padding()
                        .onTapGesture {
                            languageSelected = "French"
                        }
                        
                        HStack{
                            Text("Russian")
                                .font(.system(size: UIScreen.screenHeight/70))
                                .fontWeight(.bold)
                            Image(languageSelected == "Russian" ? "LangRussian-g" : "LangRussian-w")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/12)
                        }
                        .padding()
                        .background(.white)
                        .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/10)
                        .padding()
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                        .padding()
                        .onTapGesture {
                            languageSelected = "Russian"
                        }
                        
                        HStack{
                            Text("Chinese")
                                .font(.system(size: UIScreen.screenHeight/70))
                                .fontWeight(.bold)
                            Image(languageSelected == "Chinese" ? "LangChinese-g" : "LangChinese-w")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/12)
                        }
                        .padding()
                        .background(.white)
                        .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/10)
                        .padding()
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                        .padding()
                        .onTapGesture {
                            languageSelected = "Chinese"
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct LanguageSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LanguageSettingView()
//    }
//}
