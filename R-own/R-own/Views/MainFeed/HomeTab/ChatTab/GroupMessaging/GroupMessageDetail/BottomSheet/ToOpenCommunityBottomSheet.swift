//
//  ToOpenCommunityBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 28/06/23.
//

import SwiftUI

struct ToOpenCommunityBottomSheet: View {
    
    @StateObject var communityVM: CommunityViewModel
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var offset : CGFloat = 0
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @Binding var switchToggle: Bool
    
    @StateObject var communityService = CommunityService()
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            
                            Text("Anyone can request to join your community, do you really want to proceed ?")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            HStack{
                                Button(action: {
                                    communityService.updateGroupInfo(loginData: loginData, communityVM: communityVM, groupID: communityVM.selectedGroupID, communityName: "", communityLocation: "", communityLat: "", communityLong: "", communityType: "Open Community", commuinityDescp: "", communityImage: nil){ result in
                                        switch result {
                                        case .success(let message):
                                            print(message)
                                            switchToggle = true
                                            communityVM.showOpenCommunityBottomSheet = false
                                            globalVM.communityDetail.communityType == "Open Community"
                                        case .failure(let error):
                                            print("Update failed with error: \(error)")
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
                                    communityVM.showOpenCommunityBottomSheet = false
                                }, label: {
                                    Text("No, Keep it Closed")
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
                .offset(y: communityVM.showOpenCommunityBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(communityVM.showOpenCommunityBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        communityVM.showOpenCommunityBottomSheet.toggle()
                    }
                }
            )
    }
}

//struct ToOpenCommunityBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ToOpenCommunityBottomSheet()
//    }
//}
