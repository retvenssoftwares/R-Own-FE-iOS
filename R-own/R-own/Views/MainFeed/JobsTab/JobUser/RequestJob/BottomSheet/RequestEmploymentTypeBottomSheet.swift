//
//  RequestEmploymentTypeBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct RequestEmploymentTypeBottomSheet: View {
    
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
                        
                    VStack(alignment: .leading){
                            Text("What type of employment you seek for?")
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
                            
                            //Hotel Type
                                VStack(alignment: .leading){
                                    VStack{
                                            HStack{
                                                Text("Full-time")
                                                Spacer()
                                                if jobsVM.employmentTypeRequestedFor == "Full-time" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                }
                                            }
                                            .onTapGesture{
                                                jobsVM.employmentTypeRequestedFor = "Full-time"
                                                jobsVM.requestedEmploymentBottomSheet = false
                                            }
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/40)
                                    VStack{
                                            HStack{
                                                Text("Part-time")
                                                Spacer()
                                                if jobsVM.employmentTypeRequestedFor == "Part-time" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                }
                                            }
                                            .onTapGesture{
                                                jobsVM.employmentTypeRequestedFor = "Part-time"
                                                jobsVM.requestedEmploymentBottomSheet = false
                                            }
                                    }
                                    VStack{
                                            HStack{
                                                Text("Self-employed")
                                                Spacer()
                                                if jobsVM.employmentTypeRequestedFor == "Self-employed" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                }
                                            }
                                            .onTapGesture{
                                                jobsVM.employmentTypeRequestedFor = "Self-employed"
                                                jobsVM.requestedEmploymentBottomSheet = false
                                            }
                                    }
                                    VStack{
                                            HStack{
                                                Text("Freelance")
                                                Spacer()
                                                if jobsVM.employmentTypeRequestedFor == "Freelance" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                }
                                            }
                                            .onTapGesture{
                                                jobsVM.employmentTypeRequestedFor = "Freelance"
                                                jobsVM.requestedEmploymentBottomSheet = false
                                            }
                                    }
                                    VStack{
                                            HStack{
                                                Text("Internship")
                                                Spacer()
                                                if jobsVM.employmentTypeRequestedFor == "Internship" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                }
                                            }
                                            .onTapGesture{
                                                jobsVM.employmentTypeRequestedFor = "Internship"
                                                jobsVM.requestedEmploymentBottomSheet = false
                                            }
                                    }
                                    VStack{
                                            HStack{
                                                Text("Trainee")
                                                Spacer()
                                                if jobsVM.employmentTypeRequestedFor == "Trainee" {
                                                    Circle()
                                                        .strokeBorder(greenUi,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                } else {
                                                    Circle()
                                                        .strokeBorder(Color.black,lineWidth: 3)
                                                        .background(Circle().foregroundColor(Color.white))
                                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                                }
                                            }
                                            .onTapGesture{
                                                jobsVM.employmentTypeRequestedFor = "Trainee"
                                                jobsVM.requestedEmploymentBottomSheet = false
                                            }
                                    }
                                }
                        }
                        .padding(.horizontal, UIScreen.screenWidth/20)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/2.5)
                }
                .padding(UIScreen.screenHeight/40)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: jobsVM.requestedEmploymentBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(jobsVM.requestedEmploymentBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        jobsVM.requestedEmploymentBottomSheet.toggle()
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
                    jobsVM.requestedEmploymentBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct RequestEmploymentTypeBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestEmploymentTypeBottomSheet()
//    }
//}
