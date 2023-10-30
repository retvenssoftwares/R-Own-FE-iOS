//
//  RemoveCommunityBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 29/06/23.
//

import SwiftUI

struct RemoveCommunityBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var communityVM: CommunityViewModel
    @State var groupID: String
    
    @Environment(\.presentationMode) var presentationMode
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @FocusState private var isKeyboardShowing: Bool
    
    @StateObject var communityService = CommunityService()
    
    @State var offset : CGFloat = 0
    @StateObject var globalVM: GlobalViewModel
    
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            
                            Text("Do you really want to delete this community ?")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            HStack{
                                Button(action: {
                                    communityService.deleteCommunity(loginData: loginData, groupID: groupID)
                                    communityVM.showRemoveCommunityBottomSheet = false
                                    presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Text("YES, I am sure")
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                        .padding(.vertical, UIScreen.screenHeight/60)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 1)
                                        }
                                })
                                
                                Button(action: {
                                    communityVM.showRemoveCommunityBottomSheet.toggle()
                                }, label: {
                                    Text("No, Keep this community")
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
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
                .offset(y: communityVM.showRemoveCommunityBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(communityVM.showRemoveCommunityBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        communityVM.showRemoveCommunityBottomSheet.toggle()
                    }
                }
            )
    }
}

//struct RemoveCommunityBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        RemoveCommunityBottomSheet()
//    }
//}
