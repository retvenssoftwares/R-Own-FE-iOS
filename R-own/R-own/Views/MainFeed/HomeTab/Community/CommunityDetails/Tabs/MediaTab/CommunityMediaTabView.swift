//
//  CommunityMediaTabView.swift
//  R-own
//
//  Created by Aman Sharma on 23/05/23.
//

import SwiftUI

struct CommunityMediaTabView: View {
    
    
    
    @State var navigateToImageDetailViewTab: Bool = false
    @State var navigateToImageListViewTab: Bool = false
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var timeColumn = ["Today", "Yesterday", "This Month", "March"]
    
    var body: some View {
        NavigationStack{
            VStack{
                ForEach(timeColumn, id: \.self){ days in
                    VStack{
                        HStack{
                            Text(days)
                                .font(.footnote)
                                .fontWeight(.thin)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                        }
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        .onTapGesture {
                            navigateToImageListViewTab.toggle()
                        }
                        .navigationDestination(isPresented: $navigateToImageListViewTab, destination: {
                            CommunityImageListView()
                        })
                        
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(1...6, id: \.self) { item in
                                Image("GalleryImageDemo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct CommunityMediaTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityMediaTabView()
//    }
//}
