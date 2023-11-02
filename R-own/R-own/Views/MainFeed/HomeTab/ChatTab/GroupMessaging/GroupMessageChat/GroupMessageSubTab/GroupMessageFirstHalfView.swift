//
//  GroupMessageFirstHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI
import Shimmer

struct GroupMessageFirstHalfView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    @State var communityName: String
    @State var communityPic: String
    @State var groupID: String
    
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var profileVM: ProfileViewModel
    
    @State var navigateToCommunityDetailsView: Bool = false
    
    //back button var
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State private var currentUrl: URL?
    
    var body: some View {
        
        HStack{
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                    .foregroundColor(.black)
                    .padding(.leading, UIScreen.screenWidth/40)
            })
            AsyncImage(url: currentUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .onTapGesture {
                        navigateToCommunityDetailsView.toggle()
                    }
                    .navigationDestination(isPresented: $navigateToCommunityDetailsView, destination: {
                        GroupMessageDetailsView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, groupID: groupID, globalVM: globalVM, profileVM: profileVM, memberStatus: true)
                    })
            } placeholder: {
                Circle()
                    .fill(lightGreyUi)
                    .shimmering(active: true)
            }
            .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
            .clipShape(Circle())
            .padding(.horizontal, UIScreen.screenWidth/50)
            .onAppear {
                if currentUrl == nil {
                    DispatchQueue.main.async {
                        currentUrl = URL(string: communityPic)
                    }
                }
            }
            
            VStack(alignment: .leading){
                Text(communityName)
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
                    .onTapGesture {
                        navigateToCommunityDetailsView.toggle()
                    }
            }
            Spacer()
        }
        .frame(width: UIScreen.screenWidth)
        .padding(.bottom, UIScreen.screenHeight/70)
        .padding(.top, UIScreen.screenHeight/90)
    }
}

//struct GroupMessageFirstHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupMessageFirstHalfView()
//    }
//}
