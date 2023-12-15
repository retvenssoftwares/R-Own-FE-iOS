//
//  CommunityUsersTabView.swift
//  R-own
//
//  Created by Aman Sharma on 23/05/23.
//

import SwiftUI

struct CommunityUsersTabView: View {
    
    
    @State var navigateToBusinessUserList: Bool = false
    @State var navigateToVendorsUserList: Bool = false
    @State var navigateToHoteliersUserList: Bool = false
    @State var navigateToOthersUserList: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack{
                    HStack{
                        Spacer()
                        Text("Business in the community")
                            .font(.headline)
                            .fontWeight(.regular)
                        Spacer()
                    }
                    VStack {
                        ForEach(1...4, id: \.self){_ in
                            VendorNBusinessCard()
                        }
                    }
                    Button(action: {
                        navigateToBusinessUserList = true
                    }, label: {
                        HStack(spacing: 1){
                            Text("View all Business")
                                .font(.body)
                                .fontWeight(.thin)
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/70)
                        }
                        .background(.white)
                        .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/40)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    })
                    .navigationDestination(isPresented: $navigateToBusinessUserList, destination: {
                        CommunityBusinessListView()
                    })
                    NavigationLink(isActive: $navigateToBusinessUserList, destination: {
                        CommunityBusinessListView()
                    }, label: {
                        Text("")
                    })
                }
                
                VStack{
                    HStack{
                        Spacer()
                        Text("Vendors in the community")
                            .font(.body)
                            .fontWeight(.regular)
                        Spacer()
                    }
                    VStack {
                        ForEach(1...4, id: \.self){_ in
                            VendorNBusinessCard()
                        }
                    }
                    Button(action: {
                        navigateToVendorsUserList = true
                    }, label: {
                        HStack(spacing: 1){
                            Text("View all Vendors")
                                .font(.body)
                                .fontWeight(.thin)
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/70)
                        }
                        .background(.white)
                        .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/40)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    })
                    .navigationDestination(isPresented: $navigateToVendorsUserList, destination: {
                        CommunityVendorListView()
                    })
                    NavigationLink(isActive: $navigateToVendorsUserList, destination: {
                        CommunityVendorListView()
                    }, label: {
                        Text("")
                    })
                }
                
                VStack{
                    HStack{
                        Spacer()
                        Text("Hoteliers in the community")
                            .font(.body)
                            .fontWeight(.regular)
                        Spacer()
                    }
                    VStack {
                        ForEach(1...4, id: \.self){_ in
                            HoteliersNOthersCard()
                        }
                    }
                    Button(action: {
                        navigateToHoteliersUserList = true
                    }, label: {
                        HStack(spacing: 1){
                            Text("View all Hoteliers")
                                .font(.body)
                                .fontWeight(.thin)
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/70)
                        }
                        .background(.white)
                        .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/40)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    })
                    .navigationDestination(isPresented: $navigateToHoteliersUserList, destination: {
                        CommunityHotelierListView()
                    })
                    NavigationLink(isActive: $navigateToHoteliersUserList, destination: {
                        CommunityHotelierListView()
                    }, label: {
                        Text("")
                    })
                }
                
                VStack{
                    HStack{
                        Spacer()
                        Text("Others in the community")
                            .font(.body)
                            .fontWeight(.regular)
                        Spacer()
                    }
                    VStack {
                        ForEach(1...4, id: \.self){_ in
                            HoteliersNOthersCard()
                        }
                    }
                    Button(action: {
                        navigateToOthersUserList = true
                    }, label: {
                        HStack(spacing: 1){
                            Text("View all Others")
                                .font(.body)
                                .fontWeight(.thin)
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/70)
                        }
                        .background(.white)
                        .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/40)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    })
                    .navigationDestination(isPresented: $navigateToOthersUserList, destination: {
                        CommuityOthersListView()
                    })
                    NavigationLink(isActive: $navigateToOthersUserList, destination: {
                        CommuityOthersListView()
                    }, label: {
                        Text("")
                    })
                }
                Spacer()
            }
        }
        .onAppear{
            navigateToOthersUserList = false
            navigateToVendorsUserList = false
            navigateToBusinessUserList = false
            navigateToHoteliersUserList = false
        }
    }
}

//struct CommunityUsersTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityUsersTabView()
//    }
//}
