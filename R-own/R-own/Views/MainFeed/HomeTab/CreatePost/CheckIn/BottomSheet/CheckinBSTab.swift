//
//  CheckinBSTab.swift
//  R-own
//
//  Created by Aman Sharma on 23/07/23.
//

import SwiftUI

struct CheckinBSTab: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var createPostVM: CreatePostViewModel
    @State var selectedVenueID: String
    @State var hotelLogoURL: String
    @State var hotelName: String
    @State var hotelAddress: String
    @State var hotelID: String
    
    @State private var currentUrl: URL?
    
    var body: some View {
        VStack{
            Button(action: {
                createPostVM.postVenue = hotelName
                selectedVenueID = hotelID
                createPostVM.venuePostBottomSheet.toggle()
            }, label: {
                VStack (alignment: .leading){
                    HStack{
                        AsyncImage(url: currentUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                .padding(.horizontal, UIScreen.screenWidth/60)
                        } placeholder: {
                            Rectangle()
                                .fill(lightGreyUi)
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                .shimmering(active: true)
                        }
                        .onAppear {
                            if currentUrl == nil {
                                DispatchQueue.main.async {
                                    currentUrl = URL(string: hotelLogoURL)
                                }
                            }
                        }
                        VStack (alignment: .leading){
                            Text(hotelName )
                                .font(.body)
                                .foregroundColor(.black)
                                .fontWeight(.regular)
                            
                            Text(hotelAddress )
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fontWeight(.thin)
                        }
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    Divider()
                }
            })}
    }
}

//struct CheckinBSTab_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckinBSTab()
//    }
//}
