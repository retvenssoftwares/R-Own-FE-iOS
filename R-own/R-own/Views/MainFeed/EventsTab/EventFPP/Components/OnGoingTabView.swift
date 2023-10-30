//
//  OnGoingTabView.swift
//  R-own
//
//  Created by Aman Sharma on 19/05/23.
//

import SwiftUI
import Shimmer

struct OnGoingTabView: View {
    
    @State var navigateToEventDetailView: Bool = false
    @State var event: OngoingEventModel
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    var body: some View {
        NavigationStack {
            HStack{
                AsyncImage(url: URL(string: event.eventThumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                        .shimmering(active: true)
                }
                VStack(alignment: .leading){
                    HStack{
                        Text(event.categoryName)
                            .font(.system(size: UIScreen.screenHeight/80))
                            .fontWeight(.thin)
                        Spacer()
                        Text("\(event.price) INR")
                            .font(.system(size: UIScreen.screenHeight/100))
                            .foregroundColor(.white)
                            .fontWeight(.thin)
                            .padding(5)
                            .background(.black)
                            .cornerRadius(10)
                    }
                    Text(event.eventTitle)
                        .font(.system(size: UIScreen.screenHeight/60))
                        .fontWeight(.bold)
                        .padding(.vertical, UIScreen.screenHeight/60)
                    HStack{
                        Spacer()
//                        Text("18k Participant")
//                            .font(.system(size: UIScreen.screenHeight/100))
//                            .fontWeight(.thin)
//                        Text(".")
//                            .font(.system(size: UIScreen.screenHeight/100))
//                            .fontWeight(.bold)
                        Text(event.eventStartDate)
                            .font(.system(size: UIScreen.screenHeight/100))
                            .fontWeight(.thin)
                    }
                }
                .padding(.vertical, UIScreen.screenHeight/50)
                .padding(.horizontal, UIScreen.screenWidth/70)
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
                navigateToEventDetailView.toggle()
            }
            .navigationDestination(isPresented: $navigateToEventDetailView, destination: {
                EventDetails(categoryID: event.categoryID, loginData: loginData, globalVM: globalVM, eventBG: event.eventThumbnail, eventName: event.eventTitle, eventPrice: event.price, eventDescription: event.eventDescription, eventProfilePic: event.profilePic, eventUserName: event.userName)
            })
        }
    }
}

//struct OnGoingTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnGoingTabView()
//    }
//}
