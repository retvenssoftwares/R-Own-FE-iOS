//
//  IncomingAudioCallView.swift
//  R-own
//
//  Created by Aman Sharma on 24/04/23.
//

import SwiftUI

struct IncomingAudioCallView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Spacer()
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                .background(.gray)
                .overlay{
                    VStack{
                        Text("Incoming Audio Call")
                            .foregroundColor(.white)
                            .font(.body)
                            .fontWeight(.light)
                            .frame(alignment: .leading)
                        Text("Karsten")
                            .foregroundColor(.white)
                            .font(.body)
                            .fontWeight(.light)
                            .frame(alignment: .leading)
                        Image("UserIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenHeight/5, height: UIScreen.screenHeight/5)
                            .padding(UIScreen.screenHeight/25)
                        HStack{
                            Button(action: {
                                
                            }) {
                                Text("")
                                    .frame(width: UIScreen.screenHeight/17, height: UIScreen.screenHeight/17)
                                    .foregroundColor(.black.opacity(0.5))
                                    .background(.black.opacity(0.5))
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                    .overlay{
                                        Image("CallEndIcon")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                    }
                            }
                            .padding()
                            Button(action: {
                                
                            }) {
                                Text("")
                                    .frame(width: UIScreen.screenHeight/17, height: UIScreen.screenHeight/17)
                                    .foregroundColor(callGreenColorUI)
                                    .background(callGreenColorUI)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                    .overlay{
                                        Image("CallCallIcon")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                    }
                            }
                            .padding(.horizontal, UIScreen.screenWidth/10)
                            Button(action: {
                                
                            }) {
                                Text("")
                                    .frame(width: UIScreen.screenHeight/17, height: UIScreen.screenHeight/17)
                                    .foregroundColor(.black.opacity(0.5))
                                    .background(.black.opacity(0.5))
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                    .overlay{
                                        Image("CallChatIcon")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                    }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
    }
}

//struct IncomingAudioCallView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncomingAudioCallView()
//    }
//}
