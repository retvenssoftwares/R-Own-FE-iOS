//
//  ToCloseCommunityBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 28/06/23.
//

import SwiftUI

struct ToCloseCommunityBottomSheet: View {
    
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
                            
                            Text("Only you would be able to let the person in your community, do you really want to proceed ?")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            HStack{
                                Button(action: {
                                    communityService.updateGroupInfo(loginData: loginData, communityVM: communityVM, groupID: communityVM.selectedGroupID, communityName: "", communityLocation: "", communityLat: "", communityLong: "", communityType: "Close Community", commuinityDescp: "", communityImage: nil){ result in
                                        switch result {
                                        case .success(let message):
                                            print(message)
                                            switchToggle = true
                                            communityVM.showCloseCommunityBottomSheet = false
                                            globalVM.communityDetail.communityType = "Close Community"
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
                                    communityVM.showCloseCommunityBottomSheet = false
                                }, label: {
                                    Text("No, Keep it Open")
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
                .offset(y: communityVM.showCloseCommunityBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(communityVM.showCloseCommunityBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        communityVM.showCloseCommunityBottomSheet.toggle()
                    }
                }
            )
    }
}

//struct ToCloseCommunityBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ToCloseCommunityBottomSheet()
//    }
//}
