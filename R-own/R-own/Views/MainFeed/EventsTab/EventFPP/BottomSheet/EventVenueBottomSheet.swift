//
//  EventVenueBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 19/05/23.
//

import SwiftUI

struct EventVenueBottomSheet: View {
    @StateObject var globalVM: GlobalViewModel
    @StateObject var eventVM: EventViewModel
    @Binding var venueName: String
    @Binding var venueID: String
    @State var venueTitleSearch: String = ""
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            Text("Select your venue ?")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            Text("Search your venue below")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            TextField("Search Venue Name", text: $venueTitleSearch)
                                .font(.system(size: 14))
                                .frame(width: UIScreen.screenWidth/1.2)
                                .overlay(alignment: .trailing, content: {
                                    Image(systemName: "magnifyingglass")
                                })
                                .focused($isKeyboardShowing)
                                .padding()
                                .border(.black.opacity(0.5))
                            
                            
                            //Location Array
                            ScrollView{
                                VStack(alignment: .leading){
                                    if globalVM.hotelListByID.count > 0 {
                                        ForEach(0..<globalVM.hotelListByID.count, id: \.self){ count in
                                            VStack{
                                                Text(globalVM.hotelListByID[count].hotelName)
                                                    .padding(.vertical, UIScreen.screenHeight/40)
                                                    .onTapGesture{
                                                        venueName = globalVM.hotelListByID[count].hotelName
                                                        venueID = globalVM.hotelListByID[count].hotelID
                                                        eventVM.showVenueBottomSheet = false
                                                    }
                                                Divider()
                                            }
                                        }
                                        
                                    } else {
                                        Text("You havent posted any hotel yet")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .offset(y: eventVM.showVenueBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(eventVM.showVenueBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        eventVM.showVenueBottomSheet.toggle()
                    }
                }
            )
    }
}

//struct EventVenueBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        EventVenueBottomSheet()
//    }
//}
