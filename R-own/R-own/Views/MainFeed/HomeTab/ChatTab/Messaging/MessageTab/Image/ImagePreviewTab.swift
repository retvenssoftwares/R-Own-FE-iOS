//
//  ImagePreviewTab.swift
//  R-own
//
//  Created by Aman Sharma on 30/06/23.
//

import SwiftUI
import mesibo

struct ImagePreviewTab: View {
    
    //back button var
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State var message: MesiboMessage
    
    @State private var currentUrl: URL?
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    var body: some View {
        VStack{
            
            HStack{
                //button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.backward.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                        .foregroundColor(.black)
                })
                
                Spacer()
                //text
                
            }
            .padding(.horizontal, UIScreen.screenWidth/40)
            .padding(.vertical, UIScreen.screenHeight/70)
            .border(width: 1, edges: [.bottom], color: .black)

            Spacer()
            
            ScrollView(.init()) {
                AsyncImage(url: currentUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/1.5)
                        .clipped()
                        .padding()
                        .scaleEffect(max(1.0, scale))
                        .gesture(MagnificationGesture()
                            .onChanged { value in
                                let delta = value / self.lastScale
                                self.lastScale = value
                                self.scale *= delta
                            }
                            .onEnded { _ in
                                self.lastScale = 1.0
                            }
                        )
                } placeholder: {
                    Rectangle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/1.5)
                        .shimmering(active: true)
                }
            }
            .onAppear {
                if currentUrl == nil {
                    DispatchQueue.main.async {
                        currentUrl = URL(string: message.getFile()?.url ?? "")
                    }
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

//struct ImagePreviewTab_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePreviewTab()
//    }
//}
