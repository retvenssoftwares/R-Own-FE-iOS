//
//  GroupMessageDetailViewImageTab.swift
//  R-own
//
//  Created by Aman Sharma on 29/07/23.
//

import SwiftUI
import mesibo
import Shimmer

struct GroupMediaDetailViewImageTab: View {
    
    @State var message: MesiboMessage
    @State var openImagePreviewChat: Bool = false
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            VStack{
                AsyncImage(url: currentUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/5)
                        .clipped()
                        .padding()
                } placeholder: {
                    Rectangle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/5)
                        .shimmering(active: true)
                }
                .onAppear {
                    if currentUrl == nil {
                        DispatchQueue.main.async {
                            currentUrl = URL(string: message.getFile()?.url ?? "")
                        }
                    }
                }
                .onTapGesture {
                    openImagePreviewChat = true
                }
                .navigationDestination(isPresented: $openImagePreviewChat, destination: {
                    ImagePreviewTab(message: message)
                })
                NavigationLink(isActive: $openImagePreviewChat, destination: {
                    ImagePreviewTab(message: message)
                }, label: {
                    Text("")
                })
            }
        }
        .onAppear{
            openImagePreviewChat = false
        }
    }
}

//struct GroupMessageDetailViewImageTab_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupMessageDetailViewImageTab()
//    }
//}
