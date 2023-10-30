//
//  ImageOutGoingTabView.swift
//  R-own
//
//  Created by Aman Sharma on 30/06/23.
//

import SwiftUI
import mesibo
import Shimmer

struct ImageOutGoingTabView: View {
    
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    @State var messageStatus = "read"
    @State var message: MesiboMessage
    
    @State var openImagePreviewChat: Bool = false
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            NavigationLink(destination: {
                ImagePreviewTab(message: message)
            }, label: {
                VStack(alignment: .leading){
                    HStack{
                        Spacer(minLength: UIScreen.screenWidth/3)
                        
                        VStack(alignment: .leading, spacing: 0){
                            
                            AsyncImage(url: currentUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.screenWidth/1.9)
                                    .clipped()
                                    .padding()
                            } placeholder: {
                                Rectangle()
                                    .fill(lightGreyUi)
                                    .frame(width: UIScreen.screenWidth/1.9, height: (UIScreen.screenHeight/3))
                                    .shimmering(active: true)
                            }
                            .onAppear {
                                if currentUrl == nil {
                                    DispatchQueue.main.async {
                                        currentUrl = URL(string: message.getFile()?.url ?? "")
                                    }
                                }
                            }
                            if message.message != nil {
                                if message.message ?? "" != "" {
                                    HStack{
                                        Text(message.message ?? "")
                                            .font(.body)
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.black)
                                            .padding(.vertical, UIScreen.screenHeight/100)
                                            .padding(.horizontal, UIScreen.screenWidth/35)
                                    }
                                }
                            }
                            
                            HStack{
                                Spacer()
                                Text(convertTo12HourClock(message.getTimestamp().getTime(true))!)
                                    .font(.footnote)
                                    .foregroundColor(.black)
                                
                                if message.status == 3{
                                    Image("MessageSeenTick")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: UIScreen.screenHeight/90)
                                } else if message.status == 2{
                                    Image("MessageDoubleTick")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: UIScreen.screenHeight/90)
                                } else if message.status == 1{
                                    Image("MessageSingleTick")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: UIScreen.screenHeight/90)
                                } else {
                                    Image("MessageNotSentTick")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: UIScreen.screenHeight/90)
                                }
                            }
                        }
                        .padding()
                        .frame(width: UIScreen.screenWidth/1.7)
                        .background(chatLightGreenColorUI)
                        .cornerRadius(10, corners: .bottomLeft)
                        .cornerRadius(10, corners: .topLeft)
                        .cornerRadius(10, corners: .topRight)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                    }
                }
            })
        }
    }
}
//struct ImageOutGoingTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageOutGoingTabView()
//    }
//}
