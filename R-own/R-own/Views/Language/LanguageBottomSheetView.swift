//
//  LanguageBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//

import SwiftUI

struct LanguageBottomSheetView: View {
    
    @ObservedObject var languageData = LanguageViewModel()
    @AppStorage("lang_selected") var langSelected: String = "en"
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var body: some View {
        VStack{
                    Spacer()
                    VStack(spacing: 12){
                        Capsule()
                            .fill(Color.gray)
                            .frame(width:60, height: 4)
                        Text("In what language do you want \n to have your hospitality adventures ?")
                            .foregroundColor(.gray)
                        ScrollView(.vertical, showsIndicators: false, content: {
                            VStack(spacing: 0){
                                ForEach(languageData.languages){language in
                                    LanguageTabView(language: language)
                                        .contentShape(Rectangle())
                                        .onTapGesture(perform: {
                                            withAnimation {
                                                languageData.currentLanguage = language.langCode
                                                langSelected = language.langCode
                                                languageData.showLangBottomSheet.toggle()
                                            }
                                        })
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom)
                            .padding(.bottom,edges?.bottom)
                        })
                        .frame(height: UIScreen.screenHeight/1.7)
                    }
                    .padding(.top)
                    .background(
                        BlurView()
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight]))
                    )
        //            .background(onTapGesture {
        //
        //                    withAnimation{
        //                        languageData.showLangBottomSheet.toggle()
        //                    }
        //            })
                    .offset(y: offset)
                    .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                    .offset(y: languageData.showLangBottomSheet ? 0 : UIScreen.main.bounds.height)
                }
                .ignoresSafeArea()
                .background(
                    Color.black.opacity(languageData.showLangBottomSheet ? 0.3 : 0).ignoresSafeArea()
                        .onTapGesture {
                            withAnimation{
                                languageData.showLangBottomSheet.toggle()
                            }
                        }
                    
                )
    }
    func onChanged(value: DragGesture.Value){
        if value.translation.height > 0{
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value){
        if value.translation.height > 0{
            withAnimation(Animation.easeInOut(duration: 0.2)){
                
                //onChecking
                
                let height = UIScreen.screenHeight/3
                
                if value.translation.height > height/1.5 {
                    languageData.showLangBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}
//struct LanguageBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        LanguageBottomSheetView()
//    }
//}
