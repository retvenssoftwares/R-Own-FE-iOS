//
//  CreateCommunityView.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import SwiftUI

struct CreateCommunityView: View {
    
    @State var navigateToCreateCommunityView: Bool = false
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                NavigationLink(destination: DescriptionCommunityView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, globalVM: globalVM, profileVM: profileVM), isActive: $navigateToCreateCommunityView, label: {
                    Text("")
                })
                VStack{
                    Text("")
                        .frame(width: UIScreen.screenHeight/14, height: UIScreen.screenHeight/14)
                        .foregroundColor(Color.black)
                        .background(Color.black)
                        .clipShape(Circle())
                    //                    .shadow(color: Color.black.opacity(0.4), radius: 2,y: 4)
                        .overlay{
                            Image("CommunityCreate")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.screenHeight/23, height: UIScreen.screenHeight/23)
                        }
                        .padding(.vertical, 10)
                    VStack{
                        Text("Create your own")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .frame(alignment: .center)
                        Text("COMMUNITY")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(alignment: .center)
                    }
                    .padding(.vertical, 2)
                    
                    Spacer()
                    
                    Text("CREATE")
                        .frame(width: UIScreen.screenWidth/3)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(alignment: .center)
                }
                .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenHeight/4.5)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 2)
                .padding(.horizontal, 5)
                .padding(.top, UIScreen.screenHeight/80)
                .onTapGesture {
                    communityVM.communityName = ""
                    communityVM.communityDescription = ""
                    communityVM.communityLocation = ""
                    communityVM.selectedGroupMember = [Conn334]()
                    navigateToCreateCommunityView = true
                }
                Spacer()
            }
        }
        .onAppear{
            navigateToCreateCommunityView = false
        }
    }
}

//struct CreateCommunityView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateCommunityView()
//    }
//}
