//
//  HomeFeedServiceList.swift
//  R-own
//
//  Created by Aman Sharma on 12/07/23.
//

import SwiftUI

struct HomeFeedServiceList: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    @State var services: [NewFeedService]
    
    @State var navigateToViewAll: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Avail the Best-in-class service for yourself.")
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
                .padding(.horizontal, UIScreen.screenWidth/30)
                .padding(.vertical, UIScreen.screenHeight/90)
                
                ScrollView(.horizontal, showsIndicators: true, content: {
                    HStack(spacing: UIScreen.screenWidth/30){
                        if services.count > 0{
                            if services.count > 0 {
                                ForEach(0..<services.count, id: \.self) { id in
                                    if services[id].displayStatus == "1" {
                                        HomeFeedServiceListTabView(vendor: services[id], loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                                    }
                                }
                            }else {
                                Text("No Vendors to show")
                                    .font(.body)
                            }
                        } else {
                            Text("Still loading")
                                .font(.body)
                        }
                    }
                    .padding(.leading, UIScreen.screenWidth/30)
                    .padding(.vertical, UIScreen.screenHeight/70)
                    .padding(.trailing, UIScreen.screenWidth/30)
                })
            }
            .padding(.vertical, UIScreen.screenHeight/60)
        }
    }
}

//struct HomeFeedServiceList_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeFeedServiceList()
//    }
//}
