//
//  EventCategoryTabView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI
import Shimmer

struct EventCategoryTabView: View {
    
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var event: EventCategoryModel
    @StateObject var eventSevice = UserEventService()
    @State var navigateToEventDetailView: Bool = false
    
    var body: some View {
        NavigationStack {
            HStack{
                AsyncImage(url: URL(string: event.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                        .clipShape(Circle())
                } placeholder: {
                    Rectangle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                        .shimmering(active: true)
                }
                VStack(alignment: .leading){
                    Text(event.categoryName)
                        .font(.system(size: UIScreen.screenHeight/60))
                        .fontWeight(.bold)
                    Text("\(event.eventCount) Events")
                        .font(.system(size: UIScreen.screenHeight/80))
                        .fontWeight(.thin)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
            }
            .frame(width: UIScreen.screenWidth/1.2)
            .padding(.horizontal, UIScreen.screenWidth/50)
            .padding(.vertical, UIScreen.screenHeight/70)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
            .padding(.horizontal, UIScreen.screenWidth/50)
            .padding(.vertical, UIScreen.screenHeight/70)
            .onTapGesture {
                eventSevice.getEventByCategory(globalVM: globalVM, loginData: loginData, categoryID: event.categoryID)
                navigateToEventDetailView.toggle()
            }
            .navigationDestination(isPresented: $navigateToEventDetailView, destination: {
                EventsBasedOnCategoryList(categoryID: event.categoryID, categoryName: event.categoryName, loginData: loginData, globalVM: globalVM)
            })
        }
    }
}

//struct EventCategoryTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventCategoryTabView()
//    }
//}
