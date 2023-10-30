//
//  ToLeaveCommunityBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 09/08/23.
//

import SwiftUI

struct ToLeaveCommunityBottomSheet: View {
    
    @StateObject var communityVM: CommunityViewModel
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @FocusState private var isKeyboardShowing: Bool
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @Binding var switchToggle: Bool
    
    @StateObject var communityService = CommunityService()
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            
                            Text("Do you really want to leave this community ?")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            HStack{
                                Button(action: {
                                    Task{
                                        loginData.showLoader = true
                                        let res = await communityService.removeCommunityMember(groupID: communityVM.selectedGroupID, userID: communityVM.selectedGroupUserID)
                                        if res == "Success" {
                                            loginData.showLoader = false
                                            communityVM.showLeaveCommunityBottomSheet = false
                                        }
                                    }
                                }, label: {
                                    Text("Yes, I am sure")
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                        .padding(.vertical, UIScreen.screenHeight/60)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 1)
                                        }
                                })
                                
                                Button(action: {
                                    communityVM.showLeaveCommunityBottomSheet = false
                                }, label: {
                                    Text("No")
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                        .padding(.vertical, UIScreen.screenHeight/60)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 1)
                                        }
                                })
                            }
                            
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/4)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .offset(y: communityVM.showLeaveCommunityBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(communityVM.showLeaveCommunityBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        communityVM.showLeaveCommunityBottomSheet.toggle()
                    }
                }
            )
    }
}

//struct ToLeaveCommunityBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ToLeaveCommunityBottomSheet()
//    }
//}
