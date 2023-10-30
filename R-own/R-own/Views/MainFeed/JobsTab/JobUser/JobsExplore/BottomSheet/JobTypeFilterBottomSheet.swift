//
//  JobTypeFilterBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct JobTypeFilterBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    
        
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
                            Text("What type of job do you want ?")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            
                            Text("Select One:")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/80))
                                .fontWeight(.regular)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            //Location Array
                            ScrollView{
                                VStack(alignment: .leading){
                                    VStack{
                                        Button(action: {
                                            jobsVM.jobsTypeFilter = "Full-Time"
                                        }, label: {
                                            HStack{
                                                Text("Full-Time")
                                                Spacer()
                                                if jobsVM.jobsTypeFilter == "Full-Time" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                }
                                            }
                                        })
                                        Divider()
                                    }
                                    VStack{
                                        Button(action: {
                                            jobsVM.jobsTypeFilter = "Part-time"
                                        }, label: {
                                            HStack{
                                                Text("Part-time")
                                                Spacer()
                                                if jobsVM.jobsTypeFilter == "Part-time" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                }
                                            }
                                        })
                                        Divider()
                                    }
                                    VStack{
                                        Button(action: {
                                            jobsVM.jobsTypeFilter = "Self-employed"
                                        }, label: {
                                            HStack{
                                                Text("Self-employed")
                                                Spacer()
                                                if jobsVM.jobsTypeFilter == "Self-employed" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                }
                                            }
                                        })
                                        Divider()
                                    }
                                    VStack{
                                        Button(action: {
                                            jobsVM.jobsTypeFilter = "Freelance"
                                        }, label: {
                                            HStack{
                                                Text("Freelance")
                                                Spacer()
                                                if jobsVM.jobsTypeFilter == "Freelance" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                }
                                            }
                                        })
                                        Divider()
                                    }
                                    VStack{
                                        Button(action: {
                                            jobsVM.jobsTypeFilter = "Internship"
                                        }, label: {
                                            HStack{
                                                Text("Internship")
                                                Spacer()
                                                if jobsVM.jobsTypeFilter == "Internship" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                }
                                            }
                                        })
                                        Divider()
                                    }
                                    VStack{
                                        Button(action: {
                                            jobsVM.jobsTypeFilter = "Trainee"
                                        }, label: {
                                            HStack{
                                                Text("Trainee")
                                                Spacer()
                                                if jobsVM.jobsTypeFilter == "Trainee" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                }
                                            }
                                        })
                                        Divider()
                                    }
                                }
                            }
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

//struct JobTypeFilterBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        JobTypeFilterBottomSheet()
//    }
//}
