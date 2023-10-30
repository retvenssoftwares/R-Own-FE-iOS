//
//  EmploymentTypeBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI

struct EmploymentTypeBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    
        
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
                            Text("What type of job you’re doing ?")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            VStack(alignment: .leading){
                                
                                //Location Array
                                ScrollView{
                                    VStack(alignment: .leading){
                                        VStack{
                                            Button(action: {
                                                loginData.mainUserEmploymentType = "Full-Time"
                                                loginData.showEmploymentTypeSheet.toggle()
                                            }, label: {
                                                VStack{
                                                    Text("Full-Time")
                                                        .font(.body)
                                                        .foregroundColor(.black)
                                                        .padding(.vertical, UIScreen.screenHeight/40)
                                                    Divider()
                                                }
                                            })
                                        }
                                        VStack{
                                            Button(action: {
                                                loginData.mainUserEmploymentType = "Part-time"
                                                loginData.showEmploymentTypeSheet.toggle()
                                            }, label: {
                                                VStack{
                                                    Text("Part-time")
                                                        .font(.body)
                                                        .foregroundColor(.black)
                                                        .padding(.vertical, UIScreen.screenHeight/40)
                                                    Divider()
                                                }
                                            })
                                        }
                                        VStack{
                                            Button(action: {
                                                loginData.mainUserEmploymentType = "Self-employed"
                                                loginData.showEmploymentTypeSheet.toggle()
                                            }, label: {
                                                VStack{
                                                    Text("Self-employed")
                                                        .font(.body)
                                                        .foregroundColor(.black)
                                                        .padding(.vertical, UIScreen.screenHeight/40)
                                                    Divider()
                                                }
                                            })
                                        }
                                        VStack{
                                            Button(action: {
                                                loginData.mainUserEmploymentType = "Freelance"
                                                loginData.showEmploymentTypeSheet.toggle()
                                            }, label: {
                                                VStack{
                                                    Text("Freelance")
                                                        .font(.body)
                                                        .foregroundColor(.black)
                                                        .padding(.vertical, UIScreen.screenHeight/40)
                                                    Divider()
                                                }
                                            })
                                        }
                                        VStack{
                                            Button(action: {
                                                loginData.mainUserEmploymentType = "Internship"
                                                loginData.showEmploymentTypeSheet.toggle()
                                            }, label: {
                                                VStack{
                                                    Text("Internship")
                                                        .font(.body)
                                                        .foregroundColor(.black)
                                                        .padding(.vertical, UIScreen.screenHeight/40)
                                                    Divider()
                                                }
                                            })
                                        }
                                        VStack{
                                            Button(action: {
                                                loginData.mainUserEmploymentType = "Trainee"
                                                loginData.showEmploymentTypeSheet.toggle()
                                            }, label: {
                                                VStack{
                                                    Text("Trainee")
                                                        .font(.body)
                                                        .foregroundColor(.black)
                                                        .padding(.vertical, UIScreen.screenHeight/40)
                                                    Divider()
                                                }
                                            })
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, UIScreen.screenWidth/40)
                            .frame(width: UIScreen.screenWidth)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: loginData.showEmploymentTypeSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showEmploymentTypeSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showEmploymentTypeSheet.toggle()
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
                    loginData.showEmploymentTypeSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}
//struct EmploymentTypeBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        EmploymentTypeBottomSheet()
//    }
//}
