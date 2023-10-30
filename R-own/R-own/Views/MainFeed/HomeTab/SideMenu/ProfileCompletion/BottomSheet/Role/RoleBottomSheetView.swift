//
//  RoleBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI

struct RoleBottomSheetView: View {
    
    @StateObject var loginData: LoginViewModel
    @Binding var userRole: String
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                    VStack(alignment: .leading){
                        HStack{
                            
                            Text("Select your role in hospitality")
                                .foregroundColor(.black)
                                .font(.title3)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top, UIScreen.screenHeight/30)
                            Spacer()
                            
                        }
                            //Roles Array
                            VStack(alignment: .leading){
                                VStack{
                                    Button(action: {
                                        userRole = "Hospitality Expert"
                                        loginData.showRoleSheet = false
                                    }, label: {
                                        HStack{
                                            Text("Hospitality Expert")
                                                .foregroundColor(.black)
                                                .padding(.vertical, UIScreen.screenHeight/40)
                                                .padding(.horizontal, UIScreen.screenWidth/30)
                                            Spacer()
                                        }
                                    })
                                    Divider()
                                }
                                VStack{
                                    Button(action: {
                                        userRole = "Business Vendor / Freelancer"
                                        loginData.showRoleSheet = false
                                    }, label: {
                                        HStack{
                                            Text("Business Vendor/ Freelancer")
                                                .foregroundColor(.black)
                                                .padding(.vertical, UIScreen.screenHeight/40)
                                                .padding(.horizontal, UIScreen.screenWidth/30)
                                            Spacer()
                                        }
                                    })
                                    Divider()
                                }
                                VStack{
                                    Button(action: {
                                        userRole = "Hotel Owner"
                                        loginData.showRoleSheet = false
                                    }, label: {
                                        HStack{
                                            Text("Hotel Owner")
                                                .foregroundColor(.black)
                                                .padding(.vertical, UIScreen.screenHeight/40)
                                                .padding(.horizontal, UIScreen.screenWidth/30)
                                            Spacer()
                                        }
                                    })
                                    Divider()
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/3)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: loginData.showRoleSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showRoleSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showRoleSheet.toggle()
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
                    loginData.showRoleSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct RoleBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoleBottomSheetView()
//    }
//}
