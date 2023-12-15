//
//  ViewAllCommunityCardView.swift
//  R-own
//
//  Created by Aman Sharma on 15/04/23.
//

import SwiftUI

struct ViewAllCommunityCardView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var communityVM: CommunityViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var navigateToViewAllCommunityView: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                NavigationLink(isActive: $navigateToViewAllCommunityView, destination: {
                    CommunityDetailListView(loginData: loginData, globalVM: globalVM, communityVM: communityVM, mesiboVM: mesiboVM, profileVM: profileVM)
                }, label: {Text("")})
                Button(action: {
                    navigateToViewAllCommunityView = true
                }, label: {
                    Text("")
                        .frame(width: UIScreen.screenHeight/14, height: UIScreen.screenHeight/14)
                        .foregroundColor(Color.black)
                        .background(Color.black)
                        .clipShape(Circle())
                    //                    .shadow(color: Color.black.opacity(0.4), radius: 2,y: 4)
                        .overlay{
                            Image("CommunityViewAll")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.screenHeight/23, height: UIScreen.screenHeight/23)
                        }
                        .padding(.vertical, 10)
                })
                .navigationDestination(isPresented: $navigateToViewAllCommunityView, destination: {
                    CommunityDetailListView(loginData: loginData, globalVM: globalVM, communityVM: communityVM, mesiboVM: mesiboVM, profileVM: profileVM)
                })
                VStack{
                    Text("View All")
                        .foregroundColor(.black)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(alignment: .center)
                    Text("COMMUNITIES")
                        .foregroundColor(.black)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(alignment: .center)
                }
                .padding(.vertical, 2)
                Spacer()
                Text("VIEW")
                    .frame(width: UIScreen.screenWidth/3)
                    .padding(.vertical, 5)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .font(.body)
                    .fontWeight(.bold)
                    .frame(alignment: .center)
            }
            .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenHeight/5)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
            .padding(.horizontal, 5)
        }
        .onAppear{
            navigateToViewAllCommunityView = false
        }
    }
}

//struct ViewAllCommunityCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewAllCommunityCardView()
//    }
//}
