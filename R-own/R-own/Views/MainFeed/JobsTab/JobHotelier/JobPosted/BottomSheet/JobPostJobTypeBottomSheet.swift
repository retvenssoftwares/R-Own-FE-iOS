//
//  JobPostJobTypeBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 10/06/23.
//

import SwiftUI

struct JobPostJobTypeBottomSheet: View {
    
    @StateObject var jobsVM: JobsViewModel
    @Binding var jobType: String
        
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
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            VStack(alignment: .leading){
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
                                                jobType = "Full-Time"
                                                jobsVM.shoJobPostJobTypeBottomSheet.toggle()
                                            }, label: {
                                                HStack{
                                                    Text("Full-Time")
                                                        .foregroundColor(.black)
                                                        .padding(.leading, UIScreen.screenWidth/40)
                                                    Spacer()
                                                    if jobType == "Full-Time" {
                                                        Circle()
                                                            .strokeBorder(greenUi,lineWidth: 3)
                                                            .background(Circle().foregroundColor(Color.white))
                                                    } else {
                                                        Circle()
                                                            .strokeBorder(Color.black,lineWidth: 3)
                                                            .background(Circle().foregroundColor(Color.white))
                                                    }
                                                }
                                                .frame(width: UIScreen.screenWidth)
                                            })
                                            Divider()
                                        }
                                        VStack{
                                            Button(action: {
                                                jobType = "Part-time"
                                                jobsVM.shoJobPostJobTypeBottomSheet.toggle()
                                            }, label: {
                                                HStack{
                                                    Text("Part-time")
                                                        .foregroundColor(.black)
                                                        .padding(.leading, UIScreen.screenWidth/40)
                                                    Spacer()
                                                    if jobType == "Part-time" {
                                                        Circle()
                                                            .strokeBorder(greenUi,lineWidth: 3)
                                                            .background(Circle().foregroundColor(Color.white))
                                                    } else {
                                                        Circle()
                                                            .strokeBorder(Color.black,lineWidth: 3)
                                                            .background(Circle().foregroundColor(Color.white))
                                                    }
                                                }
                                                .frame(width: UIScreen.screenWidth)
                                            })
                                            Divider()
                                        }
                                        VStack{
                                            Button(action: {
                                                jobType = "Self-employed"
                                                jobsVM.shoJobPostJobTypeBottomSheet.toggle()
                                            }, label: {
                                                HStack{
                                                    Text("Self-employed")
                                                        .foregroundColor(.black)
                                                        .padding(.leading, UIScreen.screenWidth/40)
                                                    Spacer()
                                                    if jobType == "Self-employed" {
                                                        Circle()
                                                            .strokeBorder(greenUi,lineWidth: 3)
                                                            .background(Circle().foregroundColor(Color.white))
                                                    } else {
                                                        Circle()
                                                            .strokeBorder(Color.black,lineWidth: 3)
                                                            .background(Circle().foregroundColor(Color.white))
                                                    }
                                                }
                                                .frame(width: UIScreen.screenWidth)
                                            })
                                            Divider()
                                        }
                                        VStack{
                                            Button(action: {
                                                jobType = "Freelance"
                                                jobsVM.shoJobPostJobTypeBottomSheet.toggle()
                                            }, label: {
                                                HStack{
                                                    Text("Freelance")
                                                        .foregroundColor(.black)
                                                        .padding(.leading, UIScreen.screenWidth/40)
                                                    Spacer()
                                                    if jobType == "Freelance" {
                                                        Circle()
                                                            .strokeBorder(greenUi,lineWidth: 3)
                                                            .background(Circle().foregroundColor(Color.white))
                                                    } else {
                                                        Circle()
                                                            .strokeBorder(Color.black,lineWidth: 3)
                                                            .background(Circle().foregroundColor(Color.white))
                                                    }
                                                }
                                                .frame(width: UIScreen.screenWidth)
                                            })
                                            Divider()
                                        }
                                        VStack{
                                            Button(action: {
                                                jobType = "Internship"
                                                jobsVM.shoJobPostJobTypeBottomSheet.toggle()
                                            }, label: {
                                                HStack{
                                                    Text("Internship")
                                                        .foregroundColor(.black)
                                                        .padding(.leading, UIScreen.screenWidth/40)
                                                    Spacer()
                                                    if jobType == "Internship" {
                                                        Circle()
                                                            .strokeBorder(greenUi,lineWidth: 3)
                                                            .background(Circle().foregroundColor(Color.white))
                                                    } else {
                                                        Circle()
                                                            .strokeBorder(Color.black,lineWidth: 3)
                                                            .background(Circle().foregroundColor(Color.white))
                                                    }
                                                }
                                                .frame(width: UIScreen.screenWidth)
                                            })
                                            Divider()
                                        }
                                        VStack{
                                            Button(action: {
                                                jobType = "Trainee"
                                                jobsVM.shoJobPostJobTypeBottomSheet.toggle()
                                            }, label: {
                                                HStack{
                                                    Text("Trainee")
                                                        .foregroundColor(.black)
                                                        .padding(.leading, UIScreen.screenWidth/40)
                                                    Spacer()
                                                    if jobType == "Trainee" {
                                                        Circle()
                                                            .strokeBorder(greenUi,lineWidth: 3)
                                                            .background(Circle().foregroundColor(Color.white))
                                                    } else {
                                                        Circle()
                                                            .strokeBorder(Color.black,lineWidth: 3)
                                                            .background(Circle().foregroundColor(Color.white))
                                                    }
                                                }
                                                .frame(width: UIScreen.screenWidth)
                                            })
                                            Divider()
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
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/2.2)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: jobsVM.shoJobPostJobTypeBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(jobsVM.shoJobPostJobTypeBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        jobsVM.shoJobPostJobTypeBottomSheet.toggle()
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
                    jobsVM.shoJobPostJobTypeBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}
//struct JobPostJobTypeBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        JobPostJobTypeBottomSheet()
//    }
//}
