//
//  PollsOpinionTab.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI

struct PollsOpinionTab: View {
    
    @Binding var pollOption: String
    @State var opinionTab: Int
    
    @FocusState private var isKeyboardShowing: Bool
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        VStack{
            HStack{
                TextField("Add opinion", text: $pollOption)
                    .padding()
                    .cornerRadius(7)
                    .overlay{
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 0.5)
                    }
                    .overlay{
                        // apply a rounded border
                        VStack{
                            HStack{
                                Text("Opinion \(opinionTab)")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .fontWeight(.ultraLight)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                    .offset(y: -10)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .focused($isKeyboardShowing)
            }
            .padding(.vertical, UIScreen.screenHeight/50)
            .padding(.horizontal, UIScreen.screenWidth/30)
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
    }
}

//struct PollsOpinionTab_Previews: PreviewProvider {
//    static var previews: some View {
//        PollsOpinionTab()
//    }
//}
