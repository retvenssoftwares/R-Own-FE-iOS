//
//  AdminMemberSettingBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 23/05/23.
//

import SwiftUI

struct AdminMemberSettingBottomSheet: View {
    
    @StateObject var communityVM: CommunityViewModel
    @State var memberType: String
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            
                            Spacer()
                            if memberType == "Admin" {
                                Button(action: {
                                    print("remove member")
                                }, label: {
                                    Text("Remove")
                                        .font(.body)
                                        .fontWeight(.light)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/60)
                                        .padding(.vertical, 10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color.white, lineWidth: 2)
                                        )
                                })
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }, label: {
                                Text("Messagee")
                                    .font(.body)
                                    .fontWeight(.light)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, UIScreen.screenWidth/60)
                                    .padding(.vertical, 10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }, label: {
                                Text("View Profile")
                                    .font(.body)
                                    .fontWeight(.light)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, UIScreen.screenWidth/60)
                                    .padding(.vertical, 10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            })
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/4)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: communityVM.showAdminMemberSettingBottomSheet ? 0 : UIScreen.main.bounds.height)
                .onDisappear{
                    communityVM.showAdminMemberSettingBottomSheet = false
                }
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(communityVM.showAdminMemberSettingBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        communityVM.showAdminMemberSettingBottomSheet.toggle()
                    }
                }
            )
    }
    func onChanged(value: DragGesture.Value){
        if value.translation.height > 0{
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value){
        if value.translation.height > 0{
            withAnimation(Animation.easeInOut(duration: 0.2)){
                
                //onChecking
                
                let height = UIScreen.screenHeight/3
                
                if value.translation.height > height/1.5 {
                    communityVM.showAdminMemberSettingBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}


//struct AdminMemberSettingBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        AdminMemberSettingBottomSheet()
//    }
//}
