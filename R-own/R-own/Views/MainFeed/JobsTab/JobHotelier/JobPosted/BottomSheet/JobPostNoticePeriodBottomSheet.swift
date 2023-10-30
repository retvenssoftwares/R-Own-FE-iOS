//
//  JobPostNoticePeriodBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 10/06/23.
//

import SwiftUI

struct JobPostNoticePeriodBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    
    @State var jobTitleSearch: String = ""
        
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
                            Text("Notice Period?")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            Text("Select one -")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            //Location Array
                            ScrollView{
                                VStack(alignment: .leading){
                                    VStack{
                                        Text("No")
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                            .onTapGesture{
                                                jobsVM.postAJobNoticePeriod = "No"
                                                jobsVM.requestedNoticePeriodBottomSheet = false
                                            }
                                        Divider()
                                    }
                                    VStack{
                                        Text("< 1 Month")
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                            .onTapGesture{
                                                jobsVM.postAJobNoticePeriod = "< 1 Month"
                                                jobsVM.requestedNoticePeriodBottomSheet = false
                                            }
                                        Divider()
                                    }
                                    VStack{
                                        Text("1 Month")
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                            .onTapGesture{
                                                jobsVM.postAJobNoticePeriod = "1 Month"
                                                jobsVM.requestedNoticePeriodBottomSheet = false
                                            }
                                        Divider()
                                    }
                                    VStack{
                                        Text("2 Month")
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                            .onTapGesture{
                                                jobsVM.postAJobNoticePeriod = "2 Month"
                                                jobsVM.requestedNoticePeriodBottomSheet = false
                                            }
                                        Divider()
                                    }
                                    VStack{
                                        Text("3 Month")
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                            .onTapGesture{
                                                jobsVM.postAJobNoticePeriod = "3 Month"
                                                jobsVM.requestedNoticePeriodBottomSheet = false
                                            }
                                        Divider()
                                    }
                                    VStack{
                                        Text(">3 Month")
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                            .onTapGesture{
                                                jobsVM.postAJobNoticePeriod = ">3 Month"
                                                jobsVM.requestedNoticePeriodBottomSheet = false
                                            }
                                        Divider()
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.7)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: jobsVM.requestedNoticePeriodBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(jobsVM.requestedNoticePeriodBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        jobsVM.requestedNoticePeriodBottomSheet.toggle()
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
                    jobsVM.requestedNoticePeriodBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct JobPostNoticePeriodBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        JobPostNoticePeriodBottomSheet()
//    }
//}
