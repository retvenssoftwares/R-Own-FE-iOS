//
//  HomeFeedHotelListView.swift
//  R-own
//
//  Created by Aman Sharma on 12/07/23.
//

import SwiftUI

struct HomeFeedHotelListView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @State var hotels: [NewFeedHotel]
    
    @State var navigateToViewAll: Bool = false
    
    var body: some View {
        NavigationStack{
            if hotels.count != 0 {
                VStack{
                    HStack{
                        Text("Check into the most comfortable stays..")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        //                    Button(action: {
                        //                        navigateToViewAll.toggle()
                        //                    }, label: {
                        //                        HStack(spacing: 4){
                        //                            Text("View All")
                        //                                .font(.system(size: UIScreen.screenHeight/70))
                        //                                .fontWeight(.semibold)
                        //                                .foregroundColor(greenUi)
                        //                            Image(systemName: "chevron.right")
                        //                                .resizable()
                        //                                .scaledToFit()
                        //                                .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                        //                                .foregroundColor(greenUi)
                        //                        }
                        //                    })
                    }
                    .padding(.leading, UIScreen.screenWidth/30)
                    .padding(.trailing, UIScreen.screenWidth/30)
                    .padding(.vertical, UIScreen.screenHeight/80)
                    
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack(spacing: 4){
                            if hotels.count > 0 {
                                ForEach(0..<hotels.count, id: \.self) { id in
                                    HomeFeedHotelCard(hotel: hotels[id], globalVM: globalVM, loginData: loginData)
                                }
                            }else {
                                VStack{
                                    Text("")
                                }
                            }
                        }
                        .padding(.vertical, UIScreen.screenHeight/60)
                        .padding(.trailing, 10)
                        .padding(.leading, UIScreen.screenWidth/30)
                    })
                }
            }
        }
    }
}

//struct HomeFeedHotelListView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeFeedHotelListView()
//    }
//}
